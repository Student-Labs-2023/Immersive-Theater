part of 'audio_manager_bloc.dart';

abstract class AudioManagerEvent extends Equatable {
  const AudioManagerEvent();

  @override
  List<Object> get props => [];
}

class AudioManagerAddAudio extends AudioManagerEvent {
  final List<String> audioLinks;

  const AudioManagerAddAudio({required this.audioLinks});
  @override
  List<Object> get props => [audioLinks];
}

class AudioManagerProgressChanged extends AudioManagerEvent {
  final double progress;

  const AudioManagerProgressChanged({required this.progress});
  @override
  List<Object> get props => [progress];
}

class AudioManagerSetAudio extends AudioManagerEvent {
  final int indexAudio;
  final String url;

  const AudioManagerSetAudio({
    required this.indexAudio,
    required this.url,
  });
  @override
  List<Object> get props => [indexAudio, url];
}

class AudioManagerAudioCompleted extends AudioManagerEvent {
  const AudioManagerAudioCompleted();
  @override
  List<Object> get props => [];
}
