part of 'audio_manager_bloc.dart';

abstract class AudioManagerState extends Equatable {
  final int index;
  final Duration duration;
  const AudioManagerState(this.index, this.duration);

  @override
  List<Object> get props => [index, duration];
}

class AudioManagerInitial extends AudioManagerState {
  const AudioManagerInitial(super.index, super.duration);

  @override
  List<Object> get props => [index, duration];
}

class AudioManagerPlaying extends AudioManagerState {
  const AudioManagerPlaying(super.index, super.duration);

  @override
  List<Object> get props => [index, duration];
}

class AudioManagerLoaded extends AudioManagerState {
  const AudioManagerLoaded(super.index, super.duration);

  @override
  List<Object> get props => [index, duration];
}
