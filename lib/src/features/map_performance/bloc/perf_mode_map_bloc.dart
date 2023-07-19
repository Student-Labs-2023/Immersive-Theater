import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:locations_repository/locations_repository.dart';
import 'dart:developer';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
part 'perf_mode_map_event.dart';
part 'perf_mode_map_state.dart';

class PerfModeMapBloc extends Bloc<PerfModeMapEvent, PerfModeMapState> {
  late YandexMapController mapcontroller;
  late StreamSubscription<Position> positionStream;
  UserLocationView? userLocationView;
  PerfModeMapBloc() : super(PerfModeMapInProgress([])) {
    on<PerfModeMapGetUserLocationEvent>(_onGetUserLocationEvent);
    on<PerfModeMapMoveCameraEvent>(_onMoveCameraEvent);
    on<PerfModeMapInitialEvent>(_onInitialEvent);
    on<PerfModeMapPinsLoadEvent>(_onPerfModeMapPinsLoad);
    on<PerfModeMapRoutesLoadEvent>(_onPerfModeMapRoutesLoad);
  }

  @override
  Future<void> close() async {
    positionStream.cancel();
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
    PerfModeMapGetUserLocationEvent event,
    Emitter<PerfModeMapState> emit,
  ) async {
    if (!(await _checkServiceEnabled() && await _checkPermission())) {
      return;
    }
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 100,
    );
    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      log(position == null
          ? 'Unknown'
          : '${position.latitude.toString()}, ${position.longitude.toString()}');
    });
    mapcontroller.toggleUserLayer(
      visible: true,
      autoZoomEnabled: true,
    );
  }

  Future<void> _onMoveCameraEvent(
    PerfModeMapMoveCameraEvent event,
    Emitter<PerfModeMapState> emit,
  ) async {
    mapcontroller.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(zoom: 15, target: event.coords),
      ),
    );
  }

  void _onInitialEvent(
    PerfModeMapInitialEvent event,
    Emitter<PerfModeMapState> emit,
  ) {
    mapcontroller = event.controller;
  }

  Future<FutureOr<void>> _onPerfModeMapPinsLoad(
    PerfModeMapPinsLoadEvent event,
    Emitter<PerfModeMapState> emit,
  ) async {
    emit(PerfModeMapInProgress(state.mapObjects));
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
    emit(PerfModeMapLoadSuccess(state.mapObjects));
  }

  Future<FutureOr<void>> _onPerfModeMapRoutesLoad(
    PerfModeMapRoutesLoadEvent event,
    Emitter<PerfModeMapState> emit,
  ) async {
    emit(PerfModeMapInProgress(state.mapObjects));
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
        emit(PerfModeMapFailure(state.mapObjects));
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
        emit(PerfModeMapFailure(state.mapObjects));
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
    emit(PerfModeMapLoadSuccess(state.mapObjects));
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
}
