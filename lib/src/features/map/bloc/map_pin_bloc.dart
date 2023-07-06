import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

part 'map_pin_event.dart';
part 'map_pin_state.dart';

class MapPinBloc extends Bloc<MapPinEvent, MapPinState> {
  MapPinBloc() : super(MapPinInitialState()) {
    on<MapPinEvent>(_mapPinEventHandler);
    on<LoadMapPin>(_loadingMapPin);
    on<UpdateMapPinLocation>(_updateMapPinLocation);
    on<CloseMapPin>(_closeMapPinLocation);
  }
  Future<void> _mapPinEventHandler(MapPinEvent event, Emitter emit) async {
    emit(MapPinInitialState());
  }

  Future<void> _loadingMapPin(LoadMapPin event, Emitter emit) async {
    emit(MapPinLoadingState());
  }

  Future<void> _updateMapPinLocation(
    UpdateMapPinLocation event,
    Emitter emit,
  ) async {
    emit(MapPinLoaded(mapObject: event.mapObject, point: event.point));
  }

  Future<void> _closeMapPinLocation(CloseMapPin event, Emitter emit) async {
    emit(MapPinClosingState());
  }
}
