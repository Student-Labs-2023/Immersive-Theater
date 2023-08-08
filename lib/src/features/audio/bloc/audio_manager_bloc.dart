import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';

part 'audio_manager_event.dart';
part 'audio_manager_state.dart';

class AudioManagerBloc extends Bloc<AudioManagerEvent, AudioManagerState> {
  final AudioPlayer player = AudioPlayer();
  late final List<AudioSource> playlist;
  late final ConcatenatingAudioSource audioSource;
  final List<Duration> duration = [];
  AudioManagerBloc() : super(const AudioManagerInitial(-1, 0)) {
    on<AudioManagerAddAudio>(_onAudioManagerAddAudio);
    on<AudioManagerChangeCurrentAudio>(_onAudioManagerChangeCurrentAudio);
    on<AudioManagerProgressChanged>(_onAudioManagerPositionChanged);
  }

  void _onAudioManagerAddAudio(
    AudioManagerAddAudio event,
    Emitter<AudioManagerState> emit,
  ) {
    playlist = event.audioLinks
        .map((audioLink) => AudioSource.uri(Uri.parse(audioLink)))
        .toList();
    audioSource = ConcatenatingAudioSource(
      useLazyPreparation: true,
      children: playlist,
    );
    player.setAudioSource(
      audioSource,
      initialIndex: 0,
      initialPosition: Duration.zero,
    );
    player.setVolume(1.0);
    player.setSpeed(1.0);
    player.setLoopMode(LoopMode.off);

    player.positionStream.listen(
      (position) {
        if (player.duration != null) {
          add(
            AudioManagerProgressChanged(
              progress: (position.inSeconds / player.duration!.inSeconds),
            ),
          );
        }
      },
    );
    emit(AudioManagerLoaded(-1, state.progress));
  }

  void _onAudioManagerChangeCurrentAudio(
    AudioManagerChangeCurrentAudio event,
    Emitter<AudioManagerState> emit,
  ) {
    if (state.index != event.indexAudio) {
      player.seek(Duration.zero, index: event.indexAudio);
    }

    if (state.index != event.indexAudio ||
        player.playerState == PlayerState(false, ProcessingState.ready)) {
      player.play();
    } else if (player.playerState == PlayerState(true, ProcessingState.ready)) {
      player.pause();
    }
    emit(
      AudioManagerPlaying(
        event.indexAudio,
        state.progress,
      ),
    );
  }

  void _onAudioManagerPositionChanged(
    AudioManagerProgressChanged event,
    Emitter<AudioManagerState> emit,
  ) {
    emit(AudioManagerLoaded(state.index, event.progress));
  }
}
