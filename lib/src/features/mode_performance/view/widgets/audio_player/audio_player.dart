import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shebalin/src/features/mode_performance/bloc/mode_performance_bloc.dart';
import 'package:shebalin/src/features/mode_performance/view/widgets/audio_player/audio_info.dart';
import 'package:shebalin/src/features/mode_performance/view/widgets/audio_player/bloc/audio_player_bloc.dart';
import 'package:shebalin/src/features/mode_performance/view/widgets/continue_button.dart';
import 'package:shebalin/src/features/review/view/review_page.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:shebalin/src/theme/theme.dart';

class AudioPlayerPanel extends StatefulWidget {
  const AudioPlayerPanel({
    super.key,
  });

  @override
  State<AudioPlayerPanel> createState() => _AudioPlayerPanelState();
}

class _AudioPlayerPanelState extends State<AudioPlayerPanel> {
  late int currentIndex;
  @override
  void initState() {
    initializeDateFormatting();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    currentIndex = context.watch<ModePerformanceBloc>().state.indexLocation;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AudioPlayerBloc, AudioPlayerState>(
      listenWhen: (previous, current) {
        return current is AudioPlayerFinishedState;
      },
      listener: (context, state) {
        final int indexLastLocation =
            context.read<ModePerformanceBloc>().state.countLocations - 1;

        if (state is AudioPlayerFinishedState &&
            currentIndex == indexLastLocation) {
          Navigator.pushNamed(context, ReviewPage.routeName);
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  formatTime(state.position),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Expanded(
                  child: Slider(
                    thumbColor: accentTextColor,
                    activeColor: accentTextColor,
                    inactiveColor: secondaryTextColor,
                    min: 0,
                    max: state.duration.inSeconds.toDouble(),
                    value: state.position.inSeconds.toDouble(),
                    onChanged: state is AudioPlayerFinishedState ||
                            state is AudioPlayerFailureState
                        ? null
                        : (value) => context
                            .read<AudioPlayerBloc>()
                            .add(AudioPlayerChangeSliderEvent(value)),
                  ),
                ),
                Text(
                  formatTime(state.duration),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: BlocBuilder<ModePerformanceBloc, ModePerformanceState>(
                    builder: (context, state) {
                      return AudioInfoWidget(
                        performanceTitle: state.performanceTitle,
                        audioTitle: "Глава 1",
                        imageLink: state.imagePerformanceLink,
                      );
                    },
                  ),
                ),
                state is AudioPlayerFinishedState
                    ? ContinueButton(
                        title: "Продолжить",
                        onTap: () {
                          context.read<ModePerformanceBloc>().add(
                                ModePerformanceCurrentLocationUpdate(),
                              );
                        },
                      )
                    : buttons(),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () => context
              .read<AudioPlayerBloc>()
              .add(AudioPlayerWindBackButtonPressedEvent()),
          iconSize: 40.0,
          icon: Image.asset(ImagesSources.audioBackButton),
        ),
        IconButton(
          onPressed: () => context
              .read<AudioPlayerBloc>()
              .add(AudioPlayerPlayPauseButtonPressedEvent()),
          iconSize: 40.0,
          icon: context.watch<AudioPlayerBloc>().state.isPlaying
              ? Image.asset(ImagesSources.pauseButton)
              : Image.asset(ImagesSources.playButton),
        ),
        IconButton(
          onPressed: () => context
              .read<AudioPlayerBloc>()
              .add(AudioPlayerWindForwardButtonPressedEvent()),
          iconSize: 40.0,
          icon: Image.asset(ImagesSources.audioForwardButton),
        )
      ],
    );
  }
}

String formatTime(Duration duration) {
  return DateFormat.ms('ru')
      .format(DateTime.fromMillisecondsSinceEpoch(duration.inMilliseconds))
      .toString();
}
