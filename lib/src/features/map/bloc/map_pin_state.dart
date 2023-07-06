part of 'map_pin_bloc.dart';

abstract class MapPinState extends Equatable {
  const MapPinState();

  @override
  List<Object> get props => [];
}

class MapPinInitialState extends MapPinState {}

class MapPinLoadingState extends MapPinState {}

class MapPinLoaded extends MapPinState {
  final MapObject mapObject;
  final Point point;

  const MapPinLoaded({required this.mapObject, required this.point});
  @override
  List<Object> get props => [mapObject, point];
}

class MapPinClosingState extends MapPinState {
  @override
  List<Object> get props => [];
}
