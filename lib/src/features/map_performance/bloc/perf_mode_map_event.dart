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
  final List<Place> locations;

  const PerfModeGetUserLocationEvent(this.locations);
}

class PerfModeCurrentLocationUpdate extends PerfModeEvent {
  final int index;

  const PerfModeCurrentLocationUpdate(this.index);
  @override
  List<Object> get props => [index];
}

class PerfModeUserOnPlaceNow extends PerfModeEvent {
  final int index;

  const PerfModeUserOnPlaceNow(this.index);
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
  const PerfModePinsLoadEvent(
    this.index,
    this.countLocations,
  );
  @override
  List<Object> get props => [index, countLocations];
}

class PerfModeRoutesLoadEvent extends PerfModeEvent {
  final int index;
  final int countLocations;
  const PerfModeRoutesLoadEvent(
    this.index,
    this.countLocations,
  );
  @override
  List<Object> get props => [index, countLocations];
}

class PerfModeMoveCameraEvent extends PerfModeEvent {
  final Point coords;

  const PerfModeMoveCameraEvent(
    this.coords,
  );
  @override
  List<Object> get props => [coords];
}
