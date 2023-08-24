part of "performance_bloc.dart";

abstract class PerformanceEvent extends Equatable {
  const PerformanceEvent();

  @override
  List<Object> get props => [];
}

class PerformancesStarted extends PerformanceEvent {
  final String userId;

  const PerformancesStarted(this.userId);
}

class PerformancesRefreshed extends PerformanceEvent {
  final String userId;

  const PerformancesRefreshed(this.userId);

  @override
  List<Object> get props => [userId];
}

class PerformanceLoadFullInfo extends PerformanceEvent {
  final int id;
  final String userId;

  const PerformanceLoadFullInfo(this.id, this.userId);
  @override
  List<Object> get props => [id];
}
