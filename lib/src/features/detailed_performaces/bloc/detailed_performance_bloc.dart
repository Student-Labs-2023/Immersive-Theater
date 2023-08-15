import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:performances_repository/performances_repository.dart';

part 'detailed_performance_event.dart';
part 'detailed_performance_state.dart';

class DetailedPerformanceBloc
    extends Bloc<DetailedPerformanceEvent, DetailedPerformanceState> {
  final PerformancesRepository performanceRepository;
  final Performance performance;
  DetailedPerformanceBloc({
    required this.performance,
    required this.performanceRepository,
  }) : super(DetailedPerformanceLoadInProgress(performance: performance)) {
    on<DetailedPerformanceStarted>(_onDetailedPerformanceStarted);

    on<DetailedPerformanceInfoLoaded>(_onDetailedPerformanceInfoLoaded);

    on<DetailedPerformancePay>(_onDetailedPerformancePay);
    on<DetailedPerformanceDownload>(_onDetailedPerformanceDownload);
  }

  Future<void> _onDetailedPerformanceStarted(
    DetailedPerformanceEvent event,
    Emitter<DetailedPerformanceState> emit,
  ) async {
    try {
      final info =
          await performanceRepository.fetchPerformanceById(performance.id);
      await Future.delayed(const Duration(seconds: 3));
      add(
        DetailedPerformanceInfoLoaded(
          performance: state.performance.copyWith(info: info),
        ),
      );
    } catch (_) {
      emit(DetailedPerformanceFailure(performance: state.performance));
    }
  }

  void _onDetailedPerformanceInfoLoaded(
    DetailedPerformanceInfoLoaded event,
    Emitter<DetailedPerformanceState> emit,
  ) {
    //TODO: check on paid, downloaded
    emit(DetailedPerformanceUnPaid(performance: event.performance));
  }

  Future<void> _onDetailedPerformancePay(
    DetailedPerformancePay event,
    Emitter<DetailedPerformanceState> emit,
  ) async {
//TODO: logic of payment

    try {
      emit(DetailedPerformancePaid(performance: state.performance));
    } catch (e) {
      emit(DetailedPerformanceUnPaid(performance: state.performance));
    }
  }

  Future<void> _onDetailedPerformanceDownload(
    DetailedPerformanceDownload event,
    Emitter<DetailedPerformanceState> emit,
  ) async {
    try {
      emit(DetailedPerformanceDownLoaded(performance: state.performance));
    } catch (e) {
      emit(DetailedPerformancePaid(performance: state.performance));
    }
  }
}
