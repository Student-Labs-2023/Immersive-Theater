part of 'performance_bloc.dart';

abstract class PerformanceState extends Equatable {
  final List<Performance> perfomances;
  const PerformanceState({required this.perfomances});

  @override
  List<Object> get props => [perfomances];
}

class PerformanceLoadInProgress extends PerformanceState {
  const PerformanceLoadInProgress({required super.perfomances});
  @override
  List<Object> get props => [perfomances];
}

class PerformanceLoadFailure extends PerformanceState {
  const PerformanceLoadFailure({required super.perfomances});
  @override
  List<Object> get props => [perfomances];
}

class PerformanceFullInfoLoadFailure extends PerformanceState {
  const PerformanceFullInfoLoadFailure({required super.perfomances});
  @override
  List<Object> get props => [perfomances];
}

class PerformanceLoadSuccess extends PerformanceState {
  const PerformanceLoadSuccess({required super.perfomances});

  @override
  List<Object> get props => [perfomances];
}

class PerformanceFullInfoLoadInProgress extends PerformanceState {
  const PerformanceFullInfoLoadInProgress({required super.perfomances});

  @override
  List<Object> get props => [perfomances];
}
