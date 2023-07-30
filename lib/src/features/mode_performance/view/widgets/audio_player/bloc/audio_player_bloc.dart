import 'dart:async';
import 'dart:developer';
import 'package:api_client/api_client.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';

part 'audio_player_event.dart';
part 'audio_player_state.dart';

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  final AudioPlayer player;
  AudioPlayerBloc(this.player)
      : super(
          const AudioPlayerInProgressState(
            duration: Duration.zero,
            position: Duration.zero,
            isPlaying: false,
          ),
        ) {
    on<AudioPlayerInitialEvent>(_onAudioPlayerInitialEvent);
    on<AudioPlayerAddPlaylistEvent>(_onAudioPlayerAddPlaylistEvent);
    on<AudioPlayerUpdateDurationEvent>(_onAudioPlayerUpdateDurationEvent);
    on<AudioPlayerUpdatePositionEvent>(_onAudioPlayerUpdatePositionEvent);
    on<AudioPlayerUpdatePlayerStateEvent>(_onAudioPlayerUpdatePlayerStateEvent);
    on<AudioPlayerPlayPauseButtonPressedEvent>(
      _onAudioPlayerPlayPauseButtonPressedEvent,
    );
    on<AudioPlayerWindForwardButtonPressedEvent>(
      _onAudioPlayerWindForwardButtonPressedEvent,
    );
    on<AudioPlayerWindBackButtonPressedEvent>(
      _onAudioPlayerWindBackButtonPressedEvent,
    );
    on<AudioPlayerChangeSliderEvent>(_onAudioPlayerChangeSliderEvent);
    on<AudioLocationFinishedEvent>(_onAudioLocationFinishedEvent);
  }

  Future<void> _onAudioPlayerAddPlaylistEvent(
    AudioPlayerAddPlaylistEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    log('_onAudioPlayerAddPlaylistEvent', name: 'Theater');
    AudioSource playlist = ConcatenatingAudioSource(
      useLazyPreparation: true,
      children: [AudioSource.uri(Uri.parse(ApiClient.baseUrl + event.audio))],
    );
    player.setAudioSource(
      playlist,
      initialIndex: 0,
      initialPosition: Duration.zero,
    );
  }

  FutureOr<void> _onAudioPlayerInitialEvent(
    AudioPlayerInitialEvent event,
    Emitter<AudioPlayerState> emit,
  ) {
    log('_onAudioPlayerInitialEvent', name: 'Theater');
    player.setVolume(1.0);
    player.setSpeed(1.0);
    player.setLoopMode(LoopMode.off);
    player.playerStateStream.listen((playerState) {
      add(
        AudioPlayerUpdatePlayerStateEvent(
          playerState.playing,
        ),
      );
    });

    player.durationStream.listen((newDuration) {
      add(AudioPlayerUpdateDurationEvent(newDuration!));
    });

    player.positionStream.listen((newPosition) {
      add(AudioPlayerUpdatePositionEvent(newPosition));
    });

    player.processingStateStream.listen(
      (processingState) {
        add(
          AudioLocationFinishedEvent(
            processingState != ProcessingState.completed,
          ),
        );
      },
    );
    emit(
      AudioPlayerLoadedState(
        duration: state.duration,
        position: state.position,
        isPlaying: state.isPlaying,
      ),
    );
  }

  void _onAudioPlayerUpdateDurationEvent(
    AudioPlayerUpdateDurationEvent event,
    Emitter<AudioPlayerState> emit,
  ) {
    emit(
      state.copyWith(duration: event.duration),
    );
  }

  void _onAudioPlayerUpdatePositionEvent(
    AudioPlayerUpdatePositionEvent event,
    Emitter<AudioPlayerState> emit,
  ) {
    emit(
      state.copyWith(
        position: event.position,
      ),
    );
  }

  void _onAudioPlayerUpdatePlayerStateEvent(
    AudioPlayerUpdatePlayerStateEvent event,
    Emitter<AudioPlayerState> emit,
  ) {
    log('_onAudioPlayerUpdatePlayerStateEvent', name: 'Theater');
    emit(
      state.copyWith(isPlaying: event.isPlaying),
    );
  }

  FutureOr<void> _onAudioPlayerPlayPauseButtonPressedEvent(
    AudioPlayerPlayPauseButtonPressedEvent event,
    Emitter<AudioPlayerState> emit,
  ) {
    log('_onAudioPlayerPlayPauseButtonPressedEvent', name: 'Theater');
    if (state.isPlaying) {
      player.pause();

      emit(
        AudioPlayerPauseState(
          duration: state.duration,
          position: state.position,
          isPlaying: false,
        ),
      );
    } else {
      player.play();
      emit(
        AudioPlayerPauseState(
          duration: state.duration,
          position: state.position,
          isPlaying: true,
        ),
      );
    }
  }

  FutureOr<void> _onAudioPlayerWindForwardButtonPressedEvent(
    AudioPlayerWindForwardButtonPressedEvent event,
    Emitter<AudioPlayerState> emit,
  ) {
    log('_onAudioPlayerWindForwardButtonPressedEvent', name: 'Theater');
    Duration position = state.position + const Duration(seconds: 10);
    if (position > state.duration) {
      position = state.duration;
    }
    state.copyWith(position: position);
    player.seek(position);
  }

  FutureOr<void> _onAudioPlayerWindBackButtonPressedEvent(
    AudioPlayerWindBackButtonPressedEvent event,
    Emitter<AudioPlayerState> emit,
  ) {
    log('_onAudioPlayerWindBackButtonPressedEvent', name: 'Theater');
    Duration position = state.position - const Duration(seconds: 10);
    if (position < Duration.zero) {
      position = Duration.zero;
    }
    state.copyWith(
      position: position,
    );
    player.seek(position);
  }

  Future<FutureOr<void>> _onAudioPlayerChangeSliderEvent(
    AudioPlayerChangeSliderEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    final position = Duration(seconds: event.value.toInt());
    await player.seek(position);
  }

  @override
  Future<void> close() async {
    player.dispose();
    super.close();
  }

  FutureOr<void> _onAudioLocationFinishedEvent(
    AudioLocationFinishedEvent event,
    Emitter<AudioPlayerState> emit,
  ) {
    log('_onAudioLocationFinishedEvent', name: 'Theater');
    if (!event.isCompleted) {
      emit(
        AudioPlayerFinishedState(
          duration: state.duration,
          position: state.position,
          isPlaying: state.isPlaying,
        ),
      );
    } else {
      emit(
        AudioPlayerInProgressState(
          duration: state.duration,
          position: state.position,
          isPlaying: true,
        ),
      );
    }
  }
}
