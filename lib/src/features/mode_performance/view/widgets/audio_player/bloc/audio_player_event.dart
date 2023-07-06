part of 'audio_player_bloc.dart';

abstract class AudioPlayerEvent extends Equatable {
  const AudioPlayerEvent();

  @override
  List<Object> get props => [];
}

class AudioPlayerInitialEvent extends AudioPlayerEvent {}

class AudioPlayerPlayPauseButtonPressedEvent extends AudioPlayerEvent {}

class AudioPlayerWindForwardButtonPressedEvent extends AudioPlayerEvent {}

class AudioPlayerWindBackButtonPressedEvent extends AudioPlayerEvent {}

class AudioPlayerAddPlaylistEvent extends AudioPlayerEvent {
  final List<String> listAudio;

  const AudioPlayerAddPlaylistEvent({
    required this.listAudio,
  });

  @override
  List<Object> get props => [listAudio];
}

class AudioPlayerChangeSliderEvent extends AudioPlayerEvent {
  final double value;

  const AudioPlayerChangeSliderEvent(
    this.value,
  );
  @override
  List<Object> get props => [value];
}

class AudioPlayerUpdateDurationEvent extends AudioPlayerEvent {
  final Duration duration;

  const AudioPlayerUpdateDurationEvent(
    this.duration,
  );
  @override
  List<Object> get props => [duration];
}

class AudioPlayerUpdatePositionEvent extends AudioPlayerEvent {
  final Duration position;

  const AudioPlayerUpdatePositionEvent(
    this.position,
  );
  @override
  List<Object> get props => [position];
}

class AudioLocationFinishedEvent extends AudioPlayerEvent {
  final bool isCompleted;

  const AudioLocationFinishedEvent(
    this.isCompleted,
  );
  @override
  List<Object> get props => [isCompleted];
}

class AudioPlayerUpdatePlayerStateEvent extends AudioPlayerEvent {
  final bool isPlaying;

  const AudioPlayerUpdatePlayerStateEvent(
    this.isPlaying,
  );
  @override
  List<Object> get props => [isPlaying];
}
