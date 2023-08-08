import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';

part 'audio_manager_event.dart';
part 'audio_manager_state.dart';

class AudioManagerBloc extends Bloc<AudioManagerEvent, AudioManagerState> {
  final AudioPlayer player = AudioPlayer();
  final List<Duration> duration = [];
  AudioManagerBloc()
      : super(const AudioManagerNotSelected(index: -1, progress: 0)) {
    on<AudioManagerAddAudio>(_onAudioManagerAddAudio);
    on<AudioManagerSetAudio>(_onAudioManagerSetAudio);
    on<AudioManagerProgressChanged>(_onAudioManagerPositionChanged);
    on<AudioManagerAudioCompleted>(_onAudioManagerAudioCompleted);
  }

  void _onAudioManagerAddAudio(
    AudioManagerAddAudio event,
    Emitter<AudioManagerState> emit,
  ) async {
    for (var element in event.audioLinks) {
      duration.add(await player.setUrl(element) ?? Duration.zero);
    }

    emit(AudioManagerNotSelected(index: -1, progress: state.progress));
  }

  void _onAudioManagerSetAudio(
    AudioManagerSetAudio event,
    Emitter<AudioManagerState> emit,
  ) async {
    if (state.index != event.indexAudio) {
      player.setUrl(event.url);
    }

    player.positionStream.listen(
      (position) {
        if (player.duration != null && player.playerState.playing) {
          if (player.position == player.duration) {
            player.pause();
            add(const AudioManagerAudioCompleted());
          } else {
            add(
              AudioManagerProgressChanged(
                progress: (position.inSeconds / player.duration!.inSeconds),
              ),
            );
          }
        }
      },
    );

    if (state.index != event.indexAudio ||
        player.playerState == PlayerState(false, ProcessingState.ready)) {
      player.play();
    } else if (player.playerState == PlayerState(true, ProcessingState.ready)) {
      player.pause();
      return emit(const AudioManagerNotSelected(index: -1, progress: 0));
    }
    emit(
      AudioManagerSelected(
        index: event.indexAudio,
        progress: 0,
      ),
    );
  }

  void _onAudioManagerPositionChanged(
    AudioManagerProgressChanged event,
    Emitter<AudioManagerState> emit,
  ) {
    emit(state.copyWith(progress: event.progress));
  }

  void _onAudioManagerAudioCompleted(event, Emitter<AudioManagerState> emit) {
    player.pause();
    emit(const AudioManagerNotSelected(index: -1, progress: 0));
  }

  String getDuration(int index) {
    return _formatTime(duration[index]);
  }
}

String _formatTime(Duration duration) {
  return DateFormat.ms('ru')
      .format(DateTime.fromMillisecondsSinceEpoch(duration.inMilliseconds))
      .toString();
}
