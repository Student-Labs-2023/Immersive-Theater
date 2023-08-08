part of 'audio_manager_bloc.dart';

abstract class AudioManagerState extends Equatable {
  final int index;
  final double progress;
  const AudioManagerState({required this.index, required this.progress});

  @override
  List<Object> get props => [index, progress];

  AudioManagerState copyWith({
    int? index,
    double? progress,
  });
}

class AudioManagerSelected extends AudioManagerState {
  const AudioManagerSelected({required super.index, required super.progress});

  @override
  List<Object> get props => [index, progress];

  @override
  AudioManagerSelected copyWith({int? index, double? progress}) {
    return AudioManagerSelected(
      index: index ?? this.index,
      progress: progress ?? this.progress,
    );
  }
}

class AudioManagerNotSelected extends AudioManagerState {
  const AudioManagerNotSelected({
    required super.index,
    required super.progress,
  });

  @override
  List<Object> get props => [index, progress];

  @override
  AudioManagerNotSelected copyWith({int? index, double? progress}) {
    return AudioManagerNotSelected(
      index: index ?? this.index,
      progress: progress ?? this.progress,
    );
  }
}
