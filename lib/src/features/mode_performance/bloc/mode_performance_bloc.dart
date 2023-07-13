import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'mode_performance_event.dart';
part 'mode_performance_state.dart';

class ModePerformanceBloc
    extends Bloc<ModePerformanceEvent, ModePerformanceState> {
  ModePerformanceBloc(
    int initialIndex,
    int countLocations,
    String performanceTitle,
    String imageLink,
  ) : super(
          ModePerformanceAudioInProcess(
            initialIndex,
            countLocations,
            performanceTitle,
            imageLink,
          ),
        ) {
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
        state.performanceTitle,
        state.imagePerformanceLink,
      ),
    );
  }
}
