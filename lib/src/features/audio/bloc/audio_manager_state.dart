part of 'audio_manager_bloc.dart';

abstract class AudioManagerState extends Equatable {
  final int index;
  final double progress;
  const AudioManagerState(this.index, this.progress);

  @override
  List<Object> get props => [index, progress];
}

class AudioManagerInitial extends AudioManagerState {
  const AudioManagerInitial(super.index, super.duration);

  @override
  List<Object> get props => [index, progress];
}

class AudioManagerPlaying extends AudioManagerState {
  const AudioManagerPlaying(super.index, super.duration);

  @override
  List<Object> get props => [index, progress];
}

class AudioManagerLoaded extends AudioManagerState {
  const AudioManagerLoaded(super.index, super.duration);

  @override
  List<Object> get props => [index, progress];
}
