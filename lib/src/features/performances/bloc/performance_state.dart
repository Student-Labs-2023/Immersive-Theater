part of 'performance_bloc.dart';

abstract class PerformanceState extends Equatable {
  const PerformanceState();

  @override
  List<Object> get props => [];
}

class PerformanceLoadInProgress extends PerformanceState {}

class PerformanceLoadFailure extends PerformanceState {}

class PerformanceFullInfoLoadFailure extends PerformanceState {}

class PerformanceLoadSuccess extends PerformanceState {
  final List<Performance> perfomances;
  const PerformanceLoadSuccess(List<Object> props, {required this.perfomances});

  @override
  List<Object> get props => [perfomances];
}

class PerformanceFullInfoLoadSuccess extends PerformanceState {
  const PerformanceFullInfoLoadSuccess();
  @override
  List<Object> get props => [];
}
