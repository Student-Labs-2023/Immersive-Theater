import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';

part 'mode_performance_event.dart';
part 'mode_performance_state.dart';

class ModePerformanceBloc
    extends Bloc<ModePerformanceEvent, ModePerformanceState> {
  final Stream<ProcessingState> processingPlayerStateStream;
  ModePerformanceBloc(
    int initialIndex,
    int countLocations,
    this.processingPlayerStateStream,
  ) : super(ModePerformanceAudioInProcess(initialIndex, countLocations)) {
    on<ModePerformanceCurrentLocationUpdate>(
      _onModePerformanceCurrentLocationUpdate,
    );
  }

  void _onModePerformanceCurrentLocationUpdate(
    ModePerformanceCurrentLocationUpdate event,
    Emitter<ModePerformanceState> emit,
  ) {
    if (state.indexLocation >= state.countLocations - 1) {
      return;
    }
    emit(
      ModePerformanceAudioInProcess(
        state.indexLocation + 1,
        state.countLocations,
      ),
    );
  }
}
