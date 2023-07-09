part of 'perf_mode_map_bloc.dart';

abstract class PerfModeMapState extends Equatable {
  final List<MapObject> mapObjects;

  const PerfModeMapState(this.mapObjects);

  @override
  List<Object> get props => [mapObjects];

  PerfModeMapState copyWith({List<MapObject>? mapObjects});
}

class PerfModeMapInProgress extends PerfModeMapState {
  const PerfModeMapInProgress(super.mapObjects);
  @override
  List<Object> get props => [mapObjects];
  @override
  PerfModeMapInProgress copyWith({List<MapObject>? mapObjects}) {
    return PerfModeMapInProgress(mapObjects ?? this.mapObjects);
  }
}

class PerfModeMapLoadSuccess extends PerfModeMapState {
  const PerfModeMapLoadSuccess(super.mapObjects);
  @override
  List<Object> get props => [mapObjects];
  @override
  PerfModeMapLoadSuccess copyWith({List<MapObject>? mapObjects}) {
    return PerfModeMapLoadSuccess(mapObjects ?? this.mapObjects);
  }
}

class PerfModeMapFailure extends PerfModeMapState {
  const PerfModeMapFailure(super.mapObjects);
  @override
  List<Object> get props => [mapObjects];
  @override
  PerfModeMapFailure copyWith({List<MapObject>? mapObjects}) {
    return PerfModeMapFailure(mapObjects ?? this.mapObjects);
  }
}
