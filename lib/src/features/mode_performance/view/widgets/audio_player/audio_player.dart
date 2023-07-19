import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shebalin/src/features/map_performance/bloc/perf_mode_map_bloc.dart';
import 'package:shebalin/src/theme/ui/animated_icon.dart';
import 'package:shebalin/src/features/mode_performance/view/widgets/audio_player/audio_info.dart';
import 'package:shebalin/src/features/mode_performance/view/widgets/audio_player/bloc/audio_player_bloc.dart';
import 'package:shebalin/src/features/review/view/review_page.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/images.dart';

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
    currentIndex = context.watch<PerfModeBloc>().state.indexLocation;
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
            context.read<PerfModeBloc>().state.countLocations - 1;

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
                    thumbColor: AppColor.purplePrimary,
                    activeColor: AppColor.purplePrimary,
                    inactiveColor: AppColor.grey,
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
                  child: BlocBuilder<PerfModeBloc, PerfModeState>(
                    builder: (context, state) {
                      return AudioInfoWidget(
                        performanceTitle: state.performanceTitle,
                        audioTitle: "Глава 1",
                        imageLink: state.imagePerformanceLink,
                      );
                    },
                  ),
                ),
                buttons(state is AudioPlayerFinishedState),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget buttons(bool isNotActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: isNotActive
              ? null
              : () => context
                  .read<AudioPlayerBloc>()
                  .add(AudioPlayerWindBackButtonPressedEvent()),
          iconSize: 40.0,
          icon: Image.asset(ImagesSources.audioBackButton),
        ),
        IconButton(
          onPressed: isNotActive
              ? null
              : () => context
                  .read<AudioPlayerBloc>()
                  .add(AudioPlayerPlayPauseButtonPressedEvent()),
          iconSize: 40.0,
          icon: TAnimatedIcon(
            condition: () => context.watch<AudioPlayerBloc>().state.isPlaying,
            animatedIconData: AnimatedIcons.play_pause,
            color: AppColor.blackText,
            duration: const Duration(milliseconds: 300),
          ),
        ),
        IconButton(
          onPressed: isNotActive
              ? null
              : () => context
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
