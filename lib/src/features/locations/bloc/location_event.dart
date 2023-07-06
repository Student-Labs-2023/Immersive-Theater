part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class LocationsStarted extends LocationEvent {}

class LocationsRefreshed extends LocationEvent {
  final List<Location> locations;

  const LocationsRefreshed(this.locations);

  @override
  List<Object> get props => [locations];
}
