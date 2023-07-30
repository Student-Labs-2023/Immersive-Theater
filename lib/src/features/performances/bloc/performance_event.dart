part of "performance_bloc.dart";

abstract class PerformanceEvent extends Equatable {
  const PerformanceEvent();

  @override
  List<Object> get props => [];
}

class PerformancesStarted extends PerformanceEvent {}

class PerformancesRefreshed extends PerformanceEvent {
  final List<Performance> performances;

  const PerformancesRefreshed(this.performances);

  @override
  List<Object> get props => [performances];
}

class PerformanceLoadFullInfo extends PerformanceEvent {
  final Performance performance;

  const PerformanceLoadFullInfo(this.performance);
}
