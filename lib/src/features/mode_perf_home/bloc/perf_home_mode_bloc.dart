import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:performances_repository/performances_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shebalin/src/features/audio_player/bloc/audio_player_bloc.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

part 'perf_home_mode_event.dart';
part 'perf_home_mode_state.dart';

class PerfHomeModeBloc extends Bloc<PerfHomeModeEvent, PerfHomeModeState> {
  final List<MapObject> mapObjects;
  final int indexLocation;
  final int countLocations;
  final String performanceTitle;
  final String imagePerformanceLink;
  final AudioPlayerBloc audioPlayerBloc;
  late StreamSubscription audioPlayerBlocSub;
  late YandexMapController mapcontroller;
  final List<Place> places;

  PerfHomeModeBloc(
    this.mapObjects,
    this.indexLocation,
    this.countLocations,
    this.performanceTitle,
    this.imagePerformanceLink,
    this.audioPlayerBloc,
    this.places,
  ) : super(
          PerfHomeModeInProgress(
            mapObjects,
            indexLocation,
            countLocations,
            performanceTitle,
            imagePerformanceLink,
          ),
        ) {
    on<PerfHomeModeMoveCameraEvent>(_onMoveCameraEvent);
    on<PerfHomeModeInitialEvent>(_onInitialEvent);
    on<PerfHomeModePinsLoadEvent>(_onPerfHomeModeMapPinsLoad);
    on<PerfHomeModeRoutesLoadEvent>(
      _onPerfHomeModeMapRoutesLoad,
    );
    on<PerfHomeModeCurrentLocationUpdate>(
      _onModePerformanceCurrentLocationUpdate,
    );
  }

  @override
  Future<void> close() async {
    audioPlayerBlocSub.cancel();
    super.close();
  }

  void _onModePerformanceCurrentLocationUpdate(
    PerfHomeModeCurrentLocationUpdate event,
    Emitter<PerfHomeModeState> emit,
  ) {
    if (state.indexLocation >= state.countLocations - 1) {
      return emit(
        PerfHomeModeInProgress(
          state.mapObjects,
          state.indexLocation,
          state.countLocations,
          state.performanceTitle,
          state.imagePerformanceLink,
        ),
      );
    }
    emit(
      PerfHomeModeInProgress(
        state.mapObjects,
        state.indexLocation + 1,
        state.countLocations,
        state.performanceTitle,
        state.imagePerformanceLink,
      ),
    );
  }

  Future<void> _onMoveCameraEvent(
    PerfHomeModeMoveCameraEvent event,
    Emitter<PerfHomeModeState> emit,
  ) async {
    mapcontroller.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(zoom: 15, target: event.coords),
      ),
    );
  }

  void _onInitialEvent(
    PerfHomeModeInitialEvent event,
    Emitter<PerfHomeModeState> emit,
  ) {
    mapcontroller = event.controller;

    audioPlayerBlocSub = audioPlayerBloc.stream
        .debounceTime(const Duration(seconds: 1))
        .distinct()
        .where(
          (audioPlayerState) => audioPlayerState is AudioPlayerFinishedState,
        )
        .listen((audioPlayerState) {
      if (state.indexLocation == state.countLocations - 1) {
        return;
      }
      add(
        PerfHomeModeRoutesLoadEvent(
          state.indexLocation + 1,
          countLocations,
        ),
      );
      add(
        PerfHomeModePinsLoadEvent(
          state.indexLocation + 1,
          countLocations,
        ),
      );
      add(PerfHomeModeCurrentLocationUpdate(state.indexLocation));
    });
  }

  Future<FutureOr<void>> _onPerfHomeModeMapPinsLoad(
    PerfHomeModePinsLoadEvent event,
    Emitter<PerfHomeModeState> emit,
  ) async {
    emit(
      PerfHomeModeInProgress(
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
      PerfHomeModeLoadSuccess(
        state.mapObjects,
        state.indexLocation,
        state.countLocations,
        state.performanceTitle,
        state.imagePerformanceLink,
      ),
    );
  }

  Future<void> _onPerfHomeModeMapRoutesLoad(
    PerfHomeModeRoutesLoadEvent event,
    Emitter<PerfHomeModeState> emit,
  ) async {
    emit(
      PerfHomeModeInProgress(
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
          PerfHomeModeFailure(
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
          PerfHomeModeFailure(
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
      PerfHomeModeLoadSuccess(
        state.mapObjects,
        state.indexLocation,
        state.countLocations,
        state.performanceTitle,
        state.imagePerformanceLink,
      ),
    );
  }
}
