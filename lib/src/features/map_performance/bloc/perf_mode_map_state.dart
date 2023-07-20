part of 'perf_mode_map_bloc.dart';

abstract class PerfModeState extends Equatable {
  final List<MapObject> mapObjects;
  final int indexLocation;
  final int countLocations;
  final String performanceTitle;
  final String imagePerformanceLink;

  const PerfModeState(
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

  PerfModeState copyWith({
    List<MapObject>? mapObjects,
    int? indexLocation,
    int? countLocations,
  });
}

class PerfModeInProgress extends PerfModeState {
  const PerfModeInProgress(
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
  PerfModeInProgress copyWith({
    List<MapObject>? mapObjects,
    int? indexLocation,
    int? countLocations,
    String? performanceTitle,
    String? imagePerformanceLink,
  }) {
    return PerfModeInProgress(
      mapObjects ?? this.mapObjects,
      indexLocation ?? this.indexLocation,
      countLocations ?? this.countLocations,
      performanceTitle ?? this.performanceTitle,
      imagePerformanceLink ?? this.imagePerformanceLink,
    );
  }
}

class PerfModeLoadSuccess extends PerfModeState {
  const PerfModeLoadSuccess(
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
  PerfModeLoadSuccess copyWith({
    List<MapObject>? mapObjects,
    int? indexLocation,
    int? countLocations,
    String? performanceTitle,
    String? imagePerformanceLink,
  }) {
    return PerfModeLoadSuccess(
      mapObjects ?? this.mapObjects,
      indexLocation ?? this.indexLocation,
      countLocations ?? this.countLocations,
      performanceTitle ?? this.performanceTitle,
      imagePerformanceLink ?? this.imagePerformanceLink,
    );
  }
}

class PerfModeUserOnPlace extends PerfModeState {
  const PerfModeUserOnPlace(
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
  PerfModeUserOnPlace copyWith({
    List<MapObject>? mapObjects,
    int? indexLocation,
    int? countLocations,
    String? performanceTitle,
    String? imagePerformanceLink,
  }) {
    return PerfModeUserOnPlace(
      mapObjects ?? this.mapObjects,
      indexLocation ?? this.indexLocation,
      countLocations ?? this.countLocations,
      performanceTitle ?? this.performanceTitle,
      imagePerformanceLink ?? this.imagePerformanceLink,
    );
  }
}

class PerfModeFailure extends PerfModeState {
  const PerfModeFailure(
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
  PerfModeFailure copyWith({
    List<MapObject>? mapObjects,
    int? indexLocation,
    int? countLocations,
    String? performanceTitle,
    String? imagePerformanceLink,
  }) {
    return PerfModeFailure(
      mapObjects ?? this.mapObjects,
      indexLocation ?? this.indexLocation,
      countLocations ?? this.countLocations,
      performanceTitle ?? this.performanceTitle,
      imagePerformanceLink ?? this.imagePerformanceLink,
    );
  }
}
