import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:performances_repository/performances_repository.dart';

part 'performance_event.dart';
part 'performance_state.dart';

class PerformanceBloc extends Bloc<PerformanceEvent, PerformanceState> {
  final PerformancesRepository _performanceRepository;
  PerformanceBloc({required PerformancesRepository performanceRepository})
      : _performanceRepository = performanceRepository,
        super(PerformanceLoadInProgress())
        {
          on<PerformancesStarted>(_onPerformanceStarted);
          on<PerformancesRefreshed>(_onPerformanceRefreshed);
        }

  Future<void> _onPerformanceStarted(PerformancesStarted event, Emitter<PerformanceState> emit) async {
    try{
      final performances =  await _performanceRepository.fetchPerformances();
      emit(PerformanceLoadSuccess(event.props, perfomances: performances));

    }
    catch (_)
    {
      emit(PerformanceLoadFailure());
      rethrow;
    }
        
  }

  Future<void> _onPerformanceRefreshed(PerformancesRefreshed event, Emitter<PerformanceState> emit) async {
    try{
      final performances =  await _performanceRepository.fetchPerformances();
      emit(PerformanceLoadSuccess(event.props, perfomances: performances));

    }
    catch (_)
    {
      emit(PerformanceLoadFailure());
      rethrow;
    }
  }
}
