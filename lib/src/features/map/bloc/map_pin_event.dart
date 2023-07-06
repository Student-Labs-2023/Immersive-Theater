part of 'map_pin_bloc.dart';

abstract class MapPinEvent extends Equatable {
  const MapPinEvent();

  @override
  List<Object> get props => [];
}

class LoadMapPin extends MapPinEvent {}

class CloseMapPin extends MapPinEvent {}

class UpdateMapPinLocation extends MapPinEvent {
  final MapObject mapObject;
  final Point point;
  const UpdateMapPinLocation(this.mapObject, this.point);

  @override
  List<Object> get props => [mapObject, point];
}
