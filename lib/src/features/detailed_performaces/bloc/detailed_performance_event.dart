part of 'detailed_performance_bloc.dart';

abstract class DetailedPerformanceEvent extends Equatable {
  const DetailedPerformanceEvent();

  @override
  List<Object> get props => [];
}

class DetailedPerformanceStarted extends DetailedPerformanceEvent {
  const DetailedPerformanceStarted();
}

class DetailedPerformanceRefreshed extends DetailedPerformanceEvent {
  const DetailedPerformanceRefreshed();
}

class DetailedPerformanceInfoLoaded extends DetailedPerformanceEvent {
  final Performance performance;
  const DetailedPerformanceInfoLoaded({required this.performance});
}

class DetailedPerformancePay extends DetailedPerformanceEvent {
  final String userId;
  final int performanceId;
  const DetailedPerformancePay({
    required this.userId,
    required this.performanceId,
  });
}

class DetailedPerformanceDownload extends DetailedPerformanceEvent {
  const DetailedPerformanceDownload();
}
