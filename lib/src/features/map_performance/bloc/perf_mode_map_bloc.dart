import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:locations_repository/locations_repository.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
part 'perf_mode_map_event.dart';
part 'perf_mode_map_state.dart';

class PerfModeMapBloc extends Bloc<PerfModeMapEvent, PerfModeMapState> {
  late YandexMapController mapcontroller;
  UserLocationView? userLocationView;
  Future<bool> get locationPermissionNotGranted async =>
      !(await Permission.location.request().isGranted);
  PerfModeMapBloc() : super(PerfModeMapInProgress([])) {
    on<PerfModeMapGetUserLocationEvent>(_onGetUserLocationEvent);
    on<PerfModeMapMoveCameraEvent>(_onMoveCameraEvent);
    on<PerfModeMapInitialEvent>(_onInitialEvent);
    on<PerfModeMapPinsLoadEvent>(_onPerfModeMapPinsLoad);
    on<PerfModeMapRoutesLoadEvent>(_onPerfModeMapRoutesLoad);
  }

  Future<void> _onGetUserLocationEvent(
    PerfModeMapGetUserLocationEvent event,
    Emitter<PerfModeMapState> emit,
  ) async {
    if (await locationPermissionNotGranted) {
      return;
    } else {
      mapcontroller.toggleUserLayer(
        visible: true,
        autoZoomEnabled: true,
      );
    }
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
    state.mapObjects.addAll(
      (indexLocation == 0
              ? <MapObject>[]
              : locations
                  .sublist(0, indexLocation)
                  .map(
                    (location) => PlacemarkMapObject(
                      opacity: 1,
                      mapId: MapObjectId(location.number),
                      point: Point(
                        latitude: double.parse(location.latitude),
                        longitude: double.parse(location.longitude),
                      ),
                      icon: PlacemarkIcon.single(
                        PlacemarkIconStyle(
                          image: BitmapDescriptor.fromAssetImage(
                            ImagesSources.grayPlacemark,
                          ),
                          scale: 2,
                        ),
                      ),
                    ),
                  )
                  .toList()) +
          (indexLocation == countLocations
              ? <MapObject>[]
              : locations
                  .sublist(indexLocation)
                  .map(
                    (location) => PlacemarkMapObject(
                      mapId: MapObjectId(location.number),
                      opacity: 1,
                      point: Point(
                        latitude: double.parse(location.latitude),
                        longitude: double.parse(location.longitude),
                      ),
                      icon: PlacemarkIcon.single(
                        PlacemarkIconStyle(
                          image: BitmapDescriptor.fromAssetImage(
                            ImagesSources.purplePlacemark,
                          ),
                          scale: 2,
                        ),
                      ),
                    ),
                  )
                  .toList()),
    );
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
        scale: 4,
        isFlat: true,
        rotationType: RotationType.rotate,
      ),
    );
    final userLocationView = locationView.copyWith(
      arrow: locationView.arrow.copyWith(
        icon: userIcon,
      ),
      pin: locationView.pin.copyWith(
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
