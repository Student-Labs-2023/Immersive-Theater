part of 'perf_home_mode_bloc.dart';

abstract class PerfHomeModeEvent extends Equatable {
  const PerfHomeModeEvent();

  @override
  List<Object> get props => [];
}

class PerfHomeModeInitialEvent extends PerfHomeModeEvent {
  final YandexMapController controller;
  const PerfHomeModeInitialEvent(this.controller);
  @override
  List<Object> get props => [controller];
}

class PerfHomeModeGetUserLocationEvent extends PerfHomeModeEvent {
  final List<Place> locations;

  const PerfHomeModeGetUserLocationEvent(this.locations);
}

class PerfHomeModeCurrentLocationUpdate extends PerfHomeModeEvent {
  final int index;

  const PerfHomeModeCurrentLocationUpdate(this.index);
  @override
  List<Object> get props => [index];
}

class PerfHomeModeUserOnPlaceNow extends PerfHomeModeEvent {
  final int index;

  const PerfHomeModeUserOnPlaceNow(this.index);
  @override
  List<Object> get props => [index];
}

class PerfHomeModeUserLocationAddedEvent extends PerfHomeModeEvent {
  final UserLocationView userLocationView;
  const PerfHomeModeUserLocationAddedEvent(
    this.userLocationView,
  );
  @override
  List<Object> get props => [userLocationView];
}

class PerfHomeModePinsLoadEvent extends PerfHomeModeEvent {
  final int index;
  final int countLocations;
  const PerfHomeModePinsLoadEvent(
    this.index,
    this.countLocations,
  );
  @override
  List<Object> get props => [index, countLocations];
}

class PerfHomeModeRoutesLoadEvent extends PerfHomeModeEvent {
  final int index;
  final int countLocations;
  const PerfHomeModeRoutesLoadEvent(
    this.index,
    this.countLocations,
  );
  @override
  List<Object> get props => [index, countLocations];
}

class PerfHomeModeMoveCameraEvent extends PerfHomeModeEvent {
  final Point coords;

  const PerfHomeModeMoveCameraEvent(
    this.coords,
  );
  @override
  List<Object> get props => [coords];
}
