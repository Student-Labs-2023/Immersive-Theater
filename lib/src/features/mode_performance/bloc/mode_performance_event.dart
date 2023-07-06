part of 'mode_performance_bloc.dart';

abstract class ModePerformanceEvent extends Equatable {
  const ModePerformanceEvent();

  @override
  List<Object> get props => [];
}

class ModePerformanceCurrentLocationUpdate extends ModePerformanceEvent {}

class ModePerformanceFinishPerformance extends ModePerformanceEvent {}
