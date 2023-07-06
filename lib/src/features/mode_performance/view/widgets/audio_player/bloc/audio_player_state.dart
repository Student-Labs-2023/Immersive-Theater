part of 'audio_player_bloc.dart';

abstract class AudioPlayerState extends Equatable {
  final Duration duration;
  final Duration position;
  final bool isPlaying;
  const AudioPlayerState({
    required this.duration,
    required this.position,
    required this.isPlaying,
  });

  @override
  List<Object> get props => [duration, position, isPlaying];

  AudioPlayerState copyWith({
    Duration? duration,
    Duration? position,
    bool? isPlaying,
  });
}

class AudioPlayerFinishedState extends AudioPlayerState {
  const AudioPlayerFinishedState({
    required super.duration,
    required super.position,
    required super.isPlaying,
  });

  @override
  AudioPlayerState copyWith({
    Duration? duration,
    Duration? position,
    bool? isPlaying,
  }) {
    return AudioPlayerFinishedState(
      duration: duration ?? this.duration,
      position: position ?? this.position,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }

  @override
  List<Object> get props => [duration, position, isPlaying];
}

class AudioPlayerInProgressState extends AudioPlayerState {
  const AudioPlayerInProgressState({
    required super.duration,
    required super.position,
    required super.isPlaying,
  });

  @override
  AudioPlayerState copyWith({
    Duration? duration,
    Duration? position,
    bool? isPlaying,
  }) {
    return AudioPlayerInProgressState(
      duration: duration ?? this.duration,
      position: position ?? this.position,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }

  @override
  List<Object> get props => [duration, position, isPlaying];
}

class AudioPlayerLoadedState extends AudioPlayerState {
  const AudioPlayerLoadedState({
    required super.duration,
    required super.position,
    required super.isPlaying,
  });

  @override
  AudioPlayerState copyWith({
    Duration? duration,
    Duration? position,
    bool? isPlaying,
  }) {
    return AudioPlayerLoadedState(
      duration: duration ?? this.duration,
      position: position ?? this.position,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }

  @override
  List<Object> get props => [duration, position, isPlaying];
}

class AudioPlayerPlayingState extends AudioPlayerState {
  const AudioPlayerPlayingState({
    required super.duration,
    required super.position,
    required super.isPlaying,
  });
  @override
  AudioPlayerState copyWith({
    Duration? duration,
    Duration? position,
    bool? isPlaying,
  }) {
    return AudioPlayerPlayingState(
      duration: duration ?? this.duration,
      position: position ?? this.position,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }

  @override
  List<Object> get props => [duration, position, isPlaying];
}

class AudioPlayerPauseState extends AudioPlayerState {
  const AudioPlayerPauseState({
    required super.duration,
    required super.position,
    required super.isPlaying,
  });
  @override
  AudioPlayerState copyWith({
    Duration? duration,
    Duration? position,
    bool? isPlaying,
  }) {
    return AudioPlayerPauseState(
      duration: duration ?? this.duration,
      position: position ?? this.position,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }

  @override
  List<Object> get props => [duration, position, isPlaying];
}
