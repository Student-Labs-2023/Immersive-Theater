part of 'mode_performance_bloc.dart';

abstract class ModePerformanceState extends Equatable {
  final int indexLocation;
  final int countLocations;
  final String performanceTitle;
  final String imagePerformanceLink;
  const ModePerformanceState(
    this.indexLocation,
    this.countLocations,
    this.performanceTitle,
    this.imagePerformanceLink,
  );

  @override
  List<Object> get props =>
      [indexLocation, countLocations, performanceTitle, imagePerformanceLink];

  ModePerformanceState copyWith({int? indexLocation, int? countLocations});
}

class ModePerformanceAudioInProcess extends ModePerformanceState {
  const ModePerformanceAudioInProcess(
    super.indexLocation,
    super.countLocations,
    super.performanceTitle,
    super.imagePerformanceLink,
  );

  @override
  List<Object> get props =>
      [indexLocation, countLocations, performanceTitle, imagePerformanceLink];

  @override
  ModePerformanceAudioInProcess copyWith({
    int? indexLocation,
    int? countLocations,
    String? performanceTitle,
    String? imagePerformanceLink,
  }) {
    return ModePerformanceAudioInProcess(
      indexLocation ?? this.indexLocation,
      countLocations ?? this.countLocations,
      performanceTitle ?? this.performanceTitle,
      imagePerformanceLink ?? this.performanceTitle,
    );
  }
}

class ModePerformanceAudioSuccess extends ModePerformanceState {
  const ModePerformanceAudioSuccess(
    super.indexLocation,
    super.countLocations,
    super.performanceTitle,
    super.imagePerformanceLink,
  );
  @override
  List<Object> get props =>
      [indexLocation, countLocations, performanceTitle, imagePerformanceLink];

  @override
  ModePerformanceAudioSuccess copyWith({
    int? indexLocation,
    int? countLocations,
    String? performanceTitle,
    String? imagePerformanceLink,
  }) {
    return ModePerformanceAudioSuccess(
      indexLocation ?? this.indexLocation,
      countLocations ?? this.countLocations,
      performanceTitle ?? this.performanceTitle,
      imagePerformanceLink ?? this.performanceTitle,
    );
  }
}

class ModePerformanceFailure extends ModePerformanceState {
  const ModePerformanceFailure(
    super.indexLocation,
    super.countLocations,
    super.performanceTitle,
    super.imagePerformanceLink,
  );
  @override
  List<Object> get props =>
      [indexLocation, countLocations, performanceTitle, imagePerformanceLink];

  @override
  ModePerformanceFailure copyWith({
    int? indexLocation,
    int? countLocations,
    String? performanceTitle,
    String? imagePerformanceLink,
  }) {
    return ModePerformanceFailure(
      indexLocation ?? this.indexLocation,
      countLocations ?? this.countLocations,
      performanceTitle ?? this.performanceTitle,
      imagePerformanceLink ?? this.performanceTitle,
    );
  }
}
