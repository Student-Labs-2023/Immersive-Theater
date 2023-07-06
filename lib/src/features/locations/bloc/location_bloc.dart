import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locations_repository/locations_repository.dart';
part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationsRepository _locationRepository;
  LocationBloc({required LocationsRepository locationRepository})
      : _locationRepository = locationRepository,
        super(LocationsLoadInProgress()) {
    on<LocationsStarted>(_onLocationStarted);
    on<LocationsRefreshed>(_onLocationRefreshed);
  }

  Future<void> _onLocationStarted(
    LocationsStarted event,
    Emitter<LocationState> emit,
  ) async {
    try {
      final locations = await _locationRepository.fetchLocations();
      emit(LocationsLoadSuccess(locations: locations));
    } catch (_) {
      emit(LocationsLoadFailure());
      rethrow;
    }
  }

  Future<void> _onLocationRefreshed(
    LocationsRefreshed event,
    Emitter<LocationState> emit,
  ) async {
    try {
      final locations = await _locationRepository.fetchLocations();
      emit(LocationsLoadSuccess(locations: locations));
    } catch (_) {
      emit(LocationsLoadFailure());
      rethrow;
    }
  }
}
