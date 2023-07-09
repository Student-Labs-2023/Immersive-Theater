import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:locations_repository/locations_repository.dart';
import 'package:permission_handler/permission_handler.dart';
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
    on<PerfModeMapUserLocationAddedEvent>(_onUserLocationAddedEvent);
    on<PerfModeMapMoveCameraEvent>(_onMoveCameraEvent);
    on<PerfModeMapInitialEvent>(_onInitialEvent);
    on<PerfModeMapAddMapObjectsEvent>(_onPerfModeMapAddMapObjectsEvent);
    on<PerfModeMaPinsLoadEvent>(_onPerfModeMapPinsLoad);
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

  void _onUserLocationAddedEvent(
    PerfModeMapUserLocationAddedEvent event,
    Emitter<PerfModeMapState> emit,
  ) async {
    userLocationView = event.userLocationView.copyWith(
      arrow: event.userLocationView.arrow.copyWith(
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage(ImagesSources.userPlacemark),
            scale: 3,
          ),
        ),
      ),
      pin: event.userLocationView.pin.copyWith(
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage(ImagesSources.userPlacemark),
            scale: 3,
          ),
        ),
      ),
      accuracyCircle: event.userLocationView.accuracyCircle.copyWith(
        fillColor: Colors.transparent,
        strokeColor: Colors.transparent,
      ),
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

  FutureOr<void> _onPerfModeMapAddMapObjectsEvent(
      PerfModeMapAddMapObjectsEvent event, Emitter<PerfModeMapState> emit) {
    state.mapObjects.addAll(event.mapObjects);
  }

  FutureOr<void> _onPerfModeMapPinsLoad(
      PerfModeMaPinsLoadEvent event, Emitter<PerfModeMapState> emit) {
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

    emit(state.copyWith(mapObjects: state.mapObjects));
  }
}
