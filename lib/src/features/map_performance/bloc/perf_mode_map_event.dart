part of 'perf_mode_map_bloc.dart';

abstract class PerfModeMapEvent extends Equatable {
  const PerfModeMapEvent();

  @override
  List<Object> get props => [];
}

class PerfModeMapInitialEvent extends PerfModeMapEvent {
  final YandexMapController controller;
  const PerfModeMapInitialEvent(this.controller);
  @override
  List<Object> get props => [controller];
}

class PerfModeMapGetUserLocationEvent extends PerfModeMapEvent {}

class PerfModeMapUserLocationAddedEvent extends PerfModeMapEvent {
  final UserLocationView userLocationView;
  const PerfModeMapUserLocationAddedEvent(
    this.userLocationView,
  );
  @override
  List<Object> get props => [userLocationView];
}

class PerfModeMapPinsLoadEvent extends PerfModeMapEvent {
  final int index;
  final int countLocations;
  final List<Location> locations;
  const PerfModeMapPinsLoadEvent(
    this.index,
    this.countLocations,
    this.locations,
  );
  @override
  List<Object> get props => [index];
}

class PerfModeMapRoutesLoadEvent extends PerfModeMapEvent {
  final int index;
  final int countLocations;
  final List<Location> locations;
  const PerfModeMapRoutesLoadEvent(
    this.index,
    this.countLocations,
    this.locations,
  );
  @override
  List<Object> get props => [index];
}

class PerfModeMapMoveCameraEvent extends PerfModeMapEvent {
  final Point coords;

  const PerfModeMapMoveCameraEvent(
    this.coords,
  );
  @override
  List<Object> get props => [coords];
}
