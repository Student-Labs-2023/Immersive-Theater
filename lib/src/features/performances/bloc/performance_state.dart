part of 'performance_bloc.dart';

abstract class PerformanceState extends Equatable {
  const PerformanceState();

  @override
  List<Object> get props => [];
}

class PerformanceLoadInProgress extends PerformanceState {}

class PerformanceLoadFailure extends PerformanceState {}

class PerformanceLoadSuccess extends PerformanceState {
  final List<Performance> perfomances;
  const PerformanceLoadSuccess(List<Object> props, {required this.perfomances});

  @override
  List<Object> get props => [perfomances];
}

class PerformanceDescriptionLoadSuccess extends PerformanceState {
  final Performance perfomance;
  const PerformanceDescriptionLoadSuccess(List<Object> props,
      {required this.perfomance});

  @override
  List<Object> get props => [perfomance];
}
