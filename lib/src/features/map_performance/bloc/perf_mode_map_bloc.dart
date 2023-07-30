import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_service/location_service.dart';
import 'package:performances_repository/performances_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shebalin/src/features/mode_performance/view/widgets/audio_player/bloc/audio_player_bloc.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
part 'perf_mode_map_event.dart';
part 'perf_mode_map_state.dart';

class PerfModeBloc extends Bloc<PerfModeEvent, PerfModeState> {
  final List<MapObject> mapObjects;
  final int indexLocation;
  final int countLocations;
  final String performanceTitle;
  final String imagePerformanceLink;
  final AudioPlayerBloc audioPlayerBloc;
  late StreamSubscription subscriptionStateBothBlocs;
  late YandexMapController mapcontroller;
  final List<Place> places;
  late StreamSubscription<Position> positionStream;
  UserLocationView? userLocationView;
  final LocationServiceImpl locationService = LocationServiceImpl();
  PerfModeBloc(
    this.mapObjects,
    this.indexLocation,
    this.countLocations,
    this.performanceTitle,
    this.imagePerformanceLink,
    this.audioPlayerBloc,
    this.places,
  ) : super(
          PerfModeInProgress(
            mapObjects,
            indexLocation,
            countLocations,
            performanceTitle,
            imagePerformanceLink,
          ),
        ) {
    on<PerfModeGetUserLocationEvent>(_onGetUserLocationEvent);
    on<PerfModeMoveCameraEvent>(_onMoveCameraEvent);
    on<PerfModeInitialEvent>(_onInitialEvent);
    on<PerfModePinsLoadEvent>(_onPerfModeMapPinsLoad);
    on<PerfModeRoutesLoadEvent>(
      _onPerfModeMapRoutesLoad,
    );
    on<PerfModeCurrentLocationUpdate>(
      _onModePerformanceCurrentLocationUpdate,
    );
    on<PerfModeUserOnPlaceNow>(
      _onPerfModeUserOnPlaceNow,
      transformer: (events, mapper) => events
          .debounceTime(const Duration(seconds: 1))
          .distinct()
          .switchMap(mapper),
    );
  }

  @override
  Future<void> close() async {
    positionStream.cancel();
    subscriptionStateBothBlocs.cancel();
    super.close();
  }

  Future<void> _onGetUserLocationEvent(
    PerfModeGetUserLocationEvent event,
    Emitter<PerfModeState> emit,
  ) async {
    if (!(await locationService.checkLocationPermissionOnDevice() &&
        await locationService.checkLocationServiceOnDevice())) {
      return;
    }
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 10,
    );
    positionStream = locationService
        .getPositionStream(locationSettings)
        .listen((Position? position) {
      if (state.indexLocation == state.countLocations - 1) {
        return;
      }
      final dist = locationService.getDistanceBetweenTwoLocations(
        position!.latitude,
        position.longitude,
        places[state.indexLocation + 1].latitude,
        places[state.indexLocation + 1].longitude,
      );
      if (dist < 10) {
        add(PerfModeUserOnPlaceNow(state.indexLocation));
      }
    });

    mapcontroller.toggleUserLayer(
      visible: true,
      autoZoomEnabled: true,
    );
  }

  void _onModePerformanceCurrentLocationUpdate(
    PerfModeCurrentLocationUpdate event,
    Emitter<PerfModeState> emit,
  ) {
    if (state.indexLocation >= state.countLocations - 1) {
      return emit(
        PerfModeInProgress(
          state.mapObjects,
          state.indexLocation,
          state.countLocations,
          state.performanceTitle,
          state.imagePerformanceLink,
        ),
      );
    }
    emit(
      PerfModeInProgress(
        state.mapObjects,
        state.indexLocation + 1,
        state.countLocations,
        state.performanceTitle,
        state.imagePerformanceLink,
      ),
    );
  }

  Future<void> _onMoveCameraEvent(
    PerfModeMoveCameraEvent event,
    Emitter<PerfModeState> emit,
  ) async {
    mapcontroller.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(zoom: 15, target: event.coords),
      ),
    );
  }

  void _onInitialEvent(
    PerfModeInitialEvent event,
    Emitter<PerfModeState> emit,
  ) {
    mapcontroller = event.controller;
    subscriptionStateBothBlocs = ZipStream(
      [
        stream.where(
          (perfModeState) => perfModeState is PerfModeUserOnPlace,
        ),
        audioPlayerBloc.stream
            .where(
              (audioPlayerState) =>
                  audioPlayerState is AudioPlayerFinishedState,
            )
            .throttleTime(const Duration(seconds: 10))
      ],
      (values) => {},
    ).listen((value) {
      add(
        PerfModeRoutesLoadEvent(
          state.indexLocation + 1,
          countLocations,
        ),
      );
      add(
        PerfModePinsLoadEvent(
          state.indexLocation + 1,
          countLocations,
        ),
      );
      add(PerfModeCurrentLocationUpdate(state.indexLocation));
    });
  }

  Future<FutureOr<void>> _onPerfModeMapPinsLoad(
    PerfModePinsLoadEvent event,
    Emitter<PerfModeState> emit,
  ) async {
    emit(
      PerfModeInProgress(
        state.mapObjects,
        state.indexLocation,
        state.countLocations,
        state.performanceTitle,
        state.imagePerformanceLink,
      ),
    );
    final int indexLocation = event.index;
    final countLocations = event.countLocations;
    final List<MapObject> placemarks = [];

    for (var i = 0; i < countLocations; i++) {
      placemarks.add(
        PlacemarkMapObject(
          opacity: 1,
          mapId: MapObjectId(places[i].address),
          point: Point(
            latitude: places[i].latitude,
            longitude: places[i].longitude,
          ),
          icon: PlacemarkIcon.single(
            PlacemarkIconStyle(
              image: BitmapDescriptor.fromAssetImage(
                i < indexLocation
                    ? ImagesSources.grayPlacemark
                    : ImagesSources.purplePlacemark,
              ),
              scale: 2,
            ),
          ),
        ),
      );
    }
    state.mapObjects.addAll(placemarks);
    emit(
      PerfModeLoadSuccess(
        state.mapObjects,
        state.indexLocation,
        state.countLocations,
        state.performanceTitle,
        state.imagePerformanceLink,
      ),
    );
  }

  Future<void> _onPerfModeMapRoutesLoad(
    PerfModeRoutesLoadEvent event,
    Emitter<PerfModeState> emit,
  ) async {
    emit(
      PerfModeInProgress(
        state.mapObjects,
        state.indexLocation,
        state.countLocations,
        state.performanceTitle,
        state.imagePerformanceLink,
      ),
    );
    final int indexLocation = event.index;
    final countLocations = event.countLocations;

    final locationsNotDone = places.sublist(indexLocation);

    if (indexLocation != 0) {
      final locationsDone = places.sublist(0, indexLocation + 1);
      BicycleResultWithSession resultWithSessionDone =
          YandexBicycle.requestRoutes(
        points: locationsDone
            .map(
              (e) => RequestPoint(
                point: Point(
                  latitude: e.latitude,
                  longitude: e.longitude,
                ),
                requestPointType: RequestPointType.wayPoint,
              ),
            )
            .toList(),
        bicycleVehicleType: BicycleVehicleType.bicycle,
      );
      var result = await resultWithSessionDone.result;

      if (result.error != null) {
        return emit(
          PerfModeFailure(
            state.mapObjects,
            state.indexLocation,
            state.countLocations,
            state.performanceTitle,
            state.imagePerformanceLink,
          ),
        );
      }
      result.routes!.asMap().forEach((i, route) {
        state.mapObjects.add(
          PolylineMapObject(
            mapId: const MapObjectId('done'),
            polyline: Polyline(points: route.geometry),
            strokeColor: AppColor.grey,
            strokeWidth: 3,
          ),
        );
      });
    }

    if (indexLocation != countLocations - 1) {
      BicycleResultWithSession resultWithSession = YandexBicycle.requestRoutes(
        points: locationsNotDone
            .map(
              (e) => RequestPoint(
                point: Point(
                  latitude: e.latitude,
                  longitude: e.longitude,
                ),
                requestPointType: RequestPointType.wayPoint,
              ),
            )
            .toList(),
        bicycleVehicleType: BicycleVehicleType.bicycle,
      );
      var resultNotDone = await resultWithSession.result;

      if (resultNotDone.error != null) {
        return emit(
          PerfModeFailure(
            state.mapObjects,
            state.indexLocation,
            state.countLocations,
            state.performanceTitle,
            state.imagePerformanceLink,
          ),
        );
      }

      resultNotDone.routes!.asMap().forEach((i, route) {
        state.mapObjects.add(
          PolylineMapObject(
            mapId: const MapObjectId("not_done"),
            polyline: Polyline(points: route.geometry),
            strokeColor: AppColor.purplePrimary,
            strokeWidth: 3,
          ),
        );
      });
    }
    emit(
      PerfModeLoadSuccess(
        state.mapObjects,
        state.indexLocation,
        state.countLocations,
        state.performanceTitle,
        state.imagePerformanceLink,
      ),
    );
  }

  Future<UserLocationView>? onUserLocationAddedCallback(
    UserLocationView locationView,
  ) async {
    final PlacemarkIcon userIcon = PlacemarkIcon.single(
      PlacemarkIconStyle(
        image: BitmapDescriptor.fromAssetImage(ImagesSources.userPlacemark),
        scale: 1.5,
        isFlat: true,
        rotationType: RotationType.rotate,
      ),
    );
    final userLocationView = locationView.copyWith(
      arrow: locationView.arrow.copyWith(
        opacity: 1,
        icon: userIcon,
      ),
      pin: locationView.pin.copyWith(
        opacity: 1,
        icon: userIcon,
      ),
      accuracyCircle: locationView.accuracyCircle.copyWith(
        fillColor: Colors.transparent,
        strokeColor: Colors.transparent,
      ),
    );

    return userLocationView;
  }

  void _onPerfModeUserOnPlaceNow(
    PerfModeUserOnPlaceNow event,
    Emitter<PerfModeState> emit,
  ) {
    emit(
      PerfModeUserOnPlace(
        state.mapObjects,
        state.indexLocation,
        state.countLocations,
        state.performanceTitle,
        state.imagePerformanceLink,
      ),
    );
  }
}
