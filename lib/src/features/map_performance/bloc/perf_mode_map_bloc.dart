import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:locations_repository/locations_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shebalin/src/features/mode_performance/view/widgets/audio_player/bloc/audio_player_bloc.dart';
import 'dart:developer';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
part 'perf_mode_map_event.dart';
part 'perf_mode_map_state.dart';

class PerfModeBloc extends Bloc<PerfModeEvent, PerfModeState> {
  late YandexMapController mapcontroller;
  late StreamSubscription<Position> positionStream;
  final List<MapObject> mapObjects;
  final int indexLocation;
  final int countLocations;
  final String performanceTitle;
  final String imagePerformanceLink;
  final AudioPlayerBloc audioPlayerBloc;
  late StreamSubscription subscriptionStateBothBlocs;
  UserLocationView? userLocationView;
  PerfModeBloc(
    this.mapObjects,
    this.indexLocation,
    this.countLocations,
    this.performanceTitle,
    this.imagePerformanceLink,
    this.audioPlayerBloc,
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
    on<PerfModeCurrentLocationUpdate>(_onModePerformanceCurrentLocationUpdate);
    on<PerfModeUserOnPlaceNow>(
      _onPerfModeUserOnPlaceNow,
      transformer: (events, mapper) => events.distinct().switchMap(mapper),
    );
  }

  @override
  Future<void> close() async {
    positionStream.cancel();
    subscriptionStateBothBlocs.cancel();
    super.close();
  }

  Future<bool> _checkServiceEnabled() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    return true;
  }

  Future<bool> _checkPermission() async {
    log('_checkPermission', name: 'Theater');
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  Future<void> _onGetUserLocationEvent(
    PerfModeGetUserLocationEvent event,
    Emitter<PerfModeState> emit,
  ) async {
    log('_onGetUserLocationEvent', name: 'Theater');
    if (!(await _checkServiceEnabled() && await _checkPermission())) {
      return;
    }
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 10,
    );
    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      if (state.indexLocation == state.countLocations - 1) {
        return;
      }
      final dist = Geolocator.distanceBetween(
        position!.latitude,
        position.longitude,
        double.parse(event.locations[state.indexLocation + 1].latitude),
        double.parse(event.locations[state.indexLocation + 1].longitude),
      );
      log(
        state.toString().substring(0, 20) + state.indexLocation.toString(),
        name: "state",
      );

      if (dist < 10) {
        add(PerfModeUserOnPlaceNow(state.indexLocation));
      }
    });

    subscriptionStateBothBlocs = ZipStream(
      [
        stream.where(
          (perfModeState) => perfModeState is PerfModeUserOnPlace,
        ),
        audioPlayerBloc.stream.where(
          (audioPlayerState) => audioPlayerState is AudioPlayerFinishedState,
        )
      ],
      (values) => {},
    ).listen((value) {
      add(PerfModeCurrentLocationUpdate());
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
    log('_onModePerformanceCurrentLocationUpdate', name: 'Theater');
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
    log('_onMoveCameraEvent', name: 'Theater');
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
    log('_onInitialEvent', name: 'Theater');
    mapcontroller = event.controller;
  }

  Future<FutureOr<void>> _onPerfModeMapPinsLoad(
    PerfModePinsLoadEvent event,
    Emitter<PerfModeState> emit,
  ) async {
    log('_onPerfModeMapPinsLoad', name: 'Theater');
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
    final locations = event.locations;
    final List<MapObject> placemarks = [];

    for (var i = 0; i < countLocations; i++) {
      placemarks.add(
        PlacemarkMapObject(
          opacity: 1,
          mapId: MapObjectId(locations[i].number),
          point: Point(
            latitude: double.parse(locations[i].latitude),
            longitude: double.parse(locations[i].longitude),
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
    log('_onPerfModeMapRoutesLoad', name: 'Theater');
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
    final locations = event.locations;

    final locationsNotDone = locations.sublist(indexLocation);

    if (indexLocation != 0) {
      final locationsDone = locations.sublist(0, indexLocation + 1);
      BicycleResultWithSession resultWithSessionDone =
          YandexBicycle.requestRoutes(
        points: locationsDone
            .map(
              (e) => RequestPoint(
                point: Point(
                  latitude: double.parse(e.latitude),
                  longitude: double.parse(e.longitude),
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
                  latitude: double.parse(e.latitude),
                  longitude: double.parse(e.longitude),
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
    log('onUserLocationAddedCallback', name: 'Theater');
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
    log('_onPerfModeUserOnPlaceNow', name: 'Theater');
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
