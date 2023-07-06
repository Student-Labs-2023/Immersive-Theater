import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
part 'perf_mode_map_event.dart';
part 'perf_mode_map_state.dart';

class PerfModeMapBloc extends Bloc<PerfModeMapEvent, PerfModeMapState> {
  late YandexMapController mapcontroller;
  Future<bool> get locationPermissionNotGranted async =>
      !(await Permission.location.request().isGranted);
  PerfModeMapBloc() : super(PerfModeMapInitial()) {
    on<PerfModeMapGetUserLocationEvent>(_onGetUserLocationEvent);
    on<PerfModeMapUserLocationAddedEvent>(_onUserLocationAddedEvent);
    on<PerfModeMapMoveCameraEvent>(_onMoveCameraEvent);
    on<PerfModeMapInitialEvent>(_onInitialEvent);
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

  Future<void> _onUserLocationAddedEvent(
    PerfModeMapUserLocationAddedEvent event,
    Emitter<PerfModeMapState> emit,
  ) async {
    final UserLocationView userLocationView = event.userLocationView.copyWith(
      arrow: event.userLocationView.arrow.copyWith(
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage(ImagesSources.markStar),
            scale: 0.3,
          ),
        ),
      ),
      pin: event.userLocationView.pin.copyWith(
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage(ImagesSources.markStar),
            scale: 0.3,
          ),
        ),
      ),
      accuracyCircle: event.userLocationView.accuracyCircle
          .copyWith(fillColor: Colors.green.withOpacity(0.5)),
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
      PerfModeMapInitialEvent event, Emitter<PerfModeMapState> emit) {
    mapcontroller = event.controller;
  }
}
/*
нужно хранить есть ли права на метсоположение
нужно хранить текущее местоположение пользователя
текущая локация должна быть известна  по индексе


*/