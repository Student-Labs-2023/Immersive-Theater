part of 'mode_performance_bloc.dart';

abstract class ModePerformanceState extends Equatable {
  final int indexLocation;
  final int countLocations;
  const ModePerformanceState(this.indexLocation, this.countLocations);

  @override
  List<Object> get props => [indexLocation, countLocations];

  ModePerformanceState copyWith({int? indexLocation, int? countLocations});
}

class ModePerformanceAudioInProcess extends ModePerformanceState {
  const ModePerformanceAudioInProcess(
    super.indexLocation,
    super.countLocations,
  );

  @override
  List<Object> get props => [indexLocation, countLocations];

  @override
  ModePerformanceAudioInProcess copyWith({
    int? indexLocation,
    int? countLocations,
  }) {
    return ModePerformanceAudioInProcess(
      indexLocation ?? this.indexLocation,
      countLocations ?? this.countLocations,
    );
  }
}

class ModePerformanceAudioSuccess extends ModePerformanceState {
  const ModePerformanceAudioSuccess(super.indexLocation, super.countLocations);
  @override
  List<Object> get props => [indexLocation, countLocations];

  @override
  ModePerformanceAudioSuccess copyWith({
    int? indexLocation,
    int? countLocations,
  }) {
    return ModePerformanceAudioSuccess(
      indexLocation ?? this.indexLocation,
      countLocations ?? this.countLocations,
    );
  }
}

class ModePerformanceFailure extends ModePerformanceState {
  const ModePerformanceFailure(super.indexLocation, super.countLocations);
  @override
  List<Object> get props => [indexLocation, countLocations];

  @override
  ModePerformanceFailure copyWith({
    int? indexLocation,
    int? countLocations,
  }) {
    return ModePerformanceFailure(
      indexLocation ?? this.indexLocation,
      countLocations ?? this.countLocations,
    );
  }
}
