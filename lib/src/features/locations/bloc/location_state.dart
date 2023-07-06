part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationsLoadInProgress extends LocationState {}

class LocationsLoadFailure extends LocationState {}

class LocationsLoadSuccess extends LocationState {
  final List<Location> locations;

  const LocationsLoadSuccess({required this.locations});

  @override
  List<Object> get props => [locations];
}
