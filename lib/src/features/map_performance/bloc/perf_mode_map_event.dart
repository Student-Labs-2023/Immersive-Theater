part of 'perf_mode_map_bloc.dart';

abstract class PerfModeEvent extends Equatable {
  const PerfModeEvent();

  @override
  List<Object> get props => [];
}

class PerfModeInitialEvent extends PerfModeEvent {
  final YandexMapController controller;
  const PerfModeInitialEvent(this.controller);
  @override
  List<Object> get props => [controller];
}

class PerfModeGetUserLocationEvent extends PerfModeEvent {
  final List<Location> locations;

  PerfModeGetUserLocationEvent(this.locations);
}

class PerfModeCurrentLocationUpdate extends PerfModeEvent {}

class PerfModeUserOnPlaceNow extends PerfModeEvent {
  final int index;

  PerfModeUserOnPlaceNow(this.index);
  @override
  List<Object> get props => [index];
}

class PerfModeUserLocationAddedEvent extends PerfModeEvent {
  final UserLocationView userLocationView;
  const PerfModeUserLocationAddedEvent(
    this.userLocationView,
  );
  @override
  List<Object> get props => [userLocationView];
}

class PerfModePinsLoadEvent extends PerfModeEvent {
  final int index;
  final int countLocations;
  final List<Location> locations;
  const PerfModePinsLoadEvent(
    this.index,
    this.countLocations,
    this.locations,
  );
  @override
  List<Object> get props => [index];
}

class PerfModeRoutesLoadEvent extends PerfModeEvent {
  final int index;
  final int countLocations;
  final List<Location> locations;
  const PerfModeRoutesLoadEvent(
    this.index,
    this.countLocations,
    this.locations,
  );
  @override
  List<Object> get props => [index];
}

class PerfModeMoveCameraEvent extends PerfModeEvent {
  final Point coords;

  const PerfModeMoveCameraEvent(
    this.coords,
  );
  @override
  List<Object> get props => [coords];
}
