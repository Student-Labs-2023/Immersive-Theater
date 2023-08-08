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

class AudioManagerChangeCurrentAudio extends AudioManagerEvent {
  final int indexAudio;
  final String url;

  const AudioManagerChangeCurrentAudio({
    required this.indexAudio,
    required this.url,
  });
  @override
  List<Object> get props => [indexAudio, url];
}
