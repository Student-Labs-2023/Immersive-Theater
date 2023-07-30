import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:performances_repository/performances_repository.dart';

part 'performance_event.dart';
part 'performance_state.dart';

class PerformanceBloc extends Bloc<PerformanceEvent, PerformanceState> {
  final PerformancesRepository _performanceRepository;
  PerformanceBloc({required PerformancesRepository performanceRepository})
      : _performanceRepository = performanceRepository,
        super(PerformanceLoadInProgress()) {
    on<PerformancesStarted>(_onPerformanceStarted);
    on<PerformancesRefreshed>(_onPerformanceRefreshed);
    on<PerformanceLoadFullInfo>(_onPerformanceLoadFullInfo);
  }

  Future<void> _onPerformanceStarted(
    PerformancesStarted event,
    Emitter<PerformanceState> emit,
  ) async {
    try {
      final performances = await _performanceRepository.fetchPerformances();
      emit(PerformanceLoadSuccess(event.props, perfomances: performances));
    } catch (_) {
      emit(PerformanceLoadFailure());
      rethrow;
    }
  }

  Future<void> _onPerformanceRefreshed(
    PerformancesRefreshed event,
    Emitter<PerformanceState> emit,
  ) async {
    try {
      final performances = await _performanceRepository.fetchPerformances();
      emit(PerformanceLoadSuccess(event.props, perfomances: performances));
    } catch (_) {
      emit(PerformanceLoadFailure());
      rethrow;
    }
  }

  Future<void> _onPerformanceLoadFullInfo(
    PerformanceLoadFullInfo event,
    Emitter<PerformanceState> emit,
  ) async {
    try {
      final performance = await _performanceRepository
          .fetchPerformanceById(event.performance.id);
      event.performance.copyWith(
        description: performance.description,
        duration: performance.duration,
        images: performance.images,
        chapters: performance.chapters,
      );
      emit(const PerformanceFullInfoLoadSuccess());
    } catch (_) {
      emit(PerformanceLoadFailure());
    }
  }
}
