part of 'detailed_performance_bloc.dart';

abstract class DetailedPerformanceState extends Equatable {
  final Performance performance;
  const DetailedPerformanceState({required this.performance});

  @override
  List<Object> get props => [];
}

class DetailedPerformanceLoadInProgress extends DetailedPerformanceState {
  const DetailedPerformanceLoadInProgress({required super.performance});
}

class DetailedPerformancePaid extends DetailedPerformanceState {
  const DetailedPerformancePaid({required super.performance});
}

class DetailedPerformanceUnPaid extends DetailedPerformanceState {
  const DetailedPerformanceUnPaid({required super.performance});
}

class DetailedPerformanceDownLoaded extends DetailedPerformanceState {
  const DetailedPerformanceDownLoaded({required super.performance});
}

class DetailedPerformanceFailure extends DetailedPerformanceState {
  const DetailedPerformanceFailure({required super.performance});
}
