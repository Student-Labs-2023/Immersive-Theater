import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:payment_service/payment_service.dart';
import 'package:performances_repository/performances_repository.dart';

part 'detailed_performance_event.dart';
part 'detailed_performance_state.dart';

class DetailedPerformanceBloc
    extends Bloc<DetailedPerformanceEvent, DetailedPerformanceState> {
  final PerformancesRepository performanceRepository;
  final Performance performance;
  final PaymentService paymentService;
  DetailedPerformanceBloc({
    required this.paymentService,
    required this.performance,
    required this.performanceRepository,
  }) : super(DetailedPerformanceLoadInProgress(performance: performance)) {
    on<DetailedPerformanceStarted>(_onDetailedPerformanceStarted);
    on<DetailedPerformanceRefreshed>(_onDetailedPerformanceRefreshed);
    on<DetailedPerformanceInfoLoaded>(_onDetailedPerformanceInfoLoaded);
  }

  Future<void> _onDetailedPerformanceStarted(
    DetailedPerformanceStarted event,
    Emitter<DetailedPerformanceState> emit,
  ) async {
    try {
      emit(DetailedPerformanceLoadInProgress(performance: performance));
      final info = await performanceRepository.fetchPerformanceById(
        performance.id,
        event.userId,
      );
      await Future.delayed(const Duration(seconds: 2));
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
    if (event.performance.bought) {
      return emit(DetailedPerformancePaid(performance: event.performance));
    }
    emit(DetailedPerformanceUnPaid(performance: event.performance));
  }

  Future<void> _onDetailedPerformanceRefreshed(
    DetailedPerformanceRefreshed event,
    Emitter<DetailedPerformanceState> emit,
  ) async {
    try {
      emit(DetailedPerformanceLoadInProgress(performance: performance));
      final info = await performanceRepository.fetchPerformanceById(
        performance.id,
        event.userId,
      );
      await Future.delayed(const Duration(seconds: 2));
      add(
        DetailedPerformanceInfoLoaded(
          performance: state.performance.copyWith(info: info),
        ),
      );
    } catch (_) {
      emit(DetailedPerformanceFailure(performance: state.performance));
    }
  }
}
