import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:performances_repository/performances_repository.dart';

part 'performance_event.dart';
part 'performance_state.dart';

class PerformanceBloc extends Bloc<PerformanceEvent, PerformanceState> {
  final PerformancesRepository _performanceRepository;
  PerformanceBloc({required PerformancesRepository performanceRepository})
      : _performanceRepository = performanceRepository,
        super(const PerformanceLoadInProgress(perfomances: [])) {
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
      emit(PerformanceLoadSuccess(perfomances: performances));
    } catch (_) {
      emit(const PerformanceLoadFailure(perfomances: []));
      rethrow;
    }
  }

  Future<void> _onPerformanceRefreshed(
    PerformancesRefreshed event,
    Emitter<PerformanceState> emit,
  ) async {
    try {
      final performances = await _performanceRepository.fetchPerformances();
      emit(PerformanceLoadSuccess(perfomances: performances));
    } catch (_) {
      emit(const PerformanceLoadFailure(perfomances: []));
      rethrow;
    }
  }

  Future<void> _onPerformanceLoadFullInfo(
    PerformanceLoadFullInfo event,
    Emitter<PerformanceState> emit,
  ) async {
    emit(PerformanceLoadInProgress(perfomances: state.perfomances));
    try {
      final performance =
          await _performanceRepository.fetchPerformanceById(event.id);
      log(performance.chapters.isNotEmpty.toString());
      emit(
        PerformanceLoadSuccess(
          perfomances: state.perfomances
              .map(
                (perf) => (perf.id != event.id)
                    ? perf
                    : perf.copyWith(
                        duration: performance.duration,
                        chapters: performance.chapters,
                        description: performance.description,
                        images: performance.images,
                      ),
              )
              .toList(),
        ),
      );
    } catch (_) {
      emit(PerformanceLoadFailure(perfomances: state.perfomances));
    }
  }
}
