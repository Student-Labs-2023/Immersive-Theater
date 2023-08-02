part of 'perf_home_mode_bloc.dart';

abstract class PerfHomeModeState extends Equatable {
  final List<MapObject> mapObjects;
  final int indexLocation;
  final int countLocations;
  final String performanceTitle;
  final String imagePerformanceLink;

  const PerfHomeModeState(
    this.mapObjects,
    this.indexLocation,
    this.countLocations,
    this.performanceTitle,
    this.imagePerformanceLink,
  );

  @override
  List<Object> get props => [
        mapObjects,
        indexLocation,
        countLocations,
        performanceTitle,
        imagePerformanceLink
      ];

  PerfHomeModeState copyWith({
    List<MapObject>? mapObjects,
    int? indexLocation,
    int? countLocations,
  });
}

class PerfHomeModeInProgress extends PerfHomeModeState {
  const PerfHomeModeInProgress(
    super.mapObjects,
    super.indexLocation,
    super.countLocations,
    super.performanceTitle,
    super.imagePerformanceLink,
  );
  @override
  List<Object> get props => [
        mapObjects,
        indexLocation,
        countLocations,
        performanceTitle,
        imagePerformanceLink
      ];
  @override
  PerfHomeModeInProgress copyWith({
    List<MapObject>? mapObjects,
    int? indexLocation,
    int? countLocations,
    String? performanceTitle,
    String? imagePerformanceLink,
  }) {
    return PerfHomeModeInProgress(
      mapObjects ?? this.mapObjects,
      indexLocation ?? this.indexLocation,
      countLocations ?? this.countLocations,
      performanceTitle ?? this.performanceTitle,
      imagePerformanceLink ?? this.imagePerformanceLink,
    );
  }
}

class PerfHomeModeLoadSuccess extends PerfHomeModeState {
  const PerfHomeModeLoadSuccess(
    super.mapObjects,
    super.indexLocation,
    super.countLocations,
    super.performanceTitle,
    super.imagePerformanceLink,
  );
  @override
  List<Object> get props => [
        mapObjects,
        indexLocation,
        countLocations,
        performanceTitle,
        imagePerformanceLink
      ];
  @override
  PerfHomeModeLoadSuccess copyWith({
    List<MapObject>? mapObjects,
    int? indexLocation,
    int? countLocations,
    String? performanceTitle,
    String? imagePerformanceLink,
  }) {
    return PerfHomeModeLoadSuccess(
      mapObjects ?? this.mapObjects,
      indexLocation ?? this.indexLocation,
      countLocations ?? this.countLocations,
      performanceTitle ?? this.performanceTitle,
      imagePerformanceLink ?? this.imagePerformanceLink,
    );
  }
}

class PerfHomeModeUserOnPlace extends PerfHomeModeState {
  const PerfHomeModeUserOnPlace(
    super.mapObjects,
    super.indexLocation,
    super.countLocations,
    super.performanceTitle,
    super.imagePerformanceLink,
  );
  @override
  List<Object> get props => [
        mapObjects,
        indexLocation,
        countLocations,
        performanceTitle,
        imagePerformanceLink
      ];
  @override
  PerfHomeModeUserOnPlace copyWith({
    List<MapObject>? mapObjects,
    int? indexLocation,
    int? countLocations,
    String? performanceTitle,
    String? imagePerformanceLink,
  }) {
    return PerfHomeModeUserOnPlace(
      mapObjects ?? this.mapObjects,
      indexLocation ?? this.indexLocation,
      countLocations ?? this.countLocations,
      performanceTitle ?? this.performanceTitle,
      imagePerformanceLink ?? this.imagePerformanceLink,
    );
  }
}

class PerfHomeModeFailure extends PerfHomeModeState {
  const PerfHomeModeFailure(
    super.mapObjects,
    super.indexLocation,
    super.countLocations,
    super.performanceTitle,
    super.imagePerformanceLink,
  );
  @override
  List<Object> get props => [
        mapObjects,
        indexLocation,
        countLocations,
        performanceTitle,
        imagePerformanceLink
      ];
  @override
  PerfHomeModeFailure copyWith({
    List<MapObject>? mapObjects,
    int? indexLocation,
    int? countLocations,
    String? performanceTitle,
    String? imagePerformanceLink,
  }) {
    return PerfHomeModeFailure(
      mapObjects ?? this.mapObjects,
      indexLocation ?? this.indexLocation,
      countLocations ?? this.countLocations,
      performanceTitle ?? this.performanceTitle,
      imagePerformanceLink ?? this.imagePerformanceLink,
    );
  }
}
