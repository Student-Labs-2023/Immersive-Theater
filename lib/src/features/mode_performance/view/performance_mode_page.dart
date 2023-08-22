import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:performances_repository/performances_repository.dart';
import 'package:shebalin/src/features/audio_player/view/audio_player.dart';
import 'package:shebalin/src/features/audio_player/bloc/audio_player_bloc.dart';
import 'package:shebalin/src/features/map_performance/bloc/perf_mode_map_bloc.dart';
import 'package:shebalin/src/features/map_performance/view/map_page.dart';
import 'package:shebalin/src/features/mode_performance/view/widgets/panel_widget.dart';
import 'package:shebalin/src/features/mode_performance/view/widgets/tip.dart';
import 'package:shebalin/src/features/mode_performance_flow/models/current_performance_provider.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:shebalin/src/theme/theme.dart';
import 'package:shebalin/src/theme/ui/app_animated_visibility.dart';
import 'package:shebalin/src/theme/ui/app_circle_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class PerformanceModePage extends StatefulWidget {
  static const routeName = 'mode';
  final VoidCallback onPerfModeComplete;
  final VoidCallback onPerfModeResume;
  final VoidCallback onClosePerformance;
  final void Function(List<String>, int) onImageOpen;
  const PerformanceModePage({
    super.key,
    required this.onPerfModeComplete,
    required this.onPerfModeResume,
    required this.onImageOpen,
    required this.onClosePerformance,
  });

  @override
  State<PerformanceModePage> createState() => _PerformanceModePageState();
}

class _PerformanceModePageState extends State<PerformanceModePage> {
  final panelController = PanelController();
  double _position = 0;
  late List<Chapter> chapters;
  @override
  void initState() {
    chapters = RepositoryProvider.of<CurrentPerformanceProvider>(context)
        .performance
        .info
        .chapters;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double heightPanelOpened = height * 0.5;

    final double heightPanelClosed = height * 0.21;

    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: AppCircleButton(
        tag: 'closePerformance',
        onPressed: widget.onClosePerformance,
        image: ImagesSources.closePerformance,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          SlidingUpPanel(
            backdropEnabled: true,
            controller: panelController,
            parallaxEnabled: true,
            parallaxOffset: .5,
            minHeight: heightPanelClosed,
            maxHeight: heightPanelOpened,
            borderRadius: panelRadius,
            panelBuilder: (scrollController) => PanelWidget(
              controller: panelController,
              chapters: chapters,
              onImageOpen: widget.onImageOpen,
            ),
            body: MapPage(
              locations: chapters.map((e) => e.place).toList(),
              initialCoords: Point(
                latitude: chapters[0].place.latitude,
                longitude: chapters[0].place.longitude,
              ),
            ),
            onPanelSlide: (position) {
              setState(() {
                _position = position;
              });
            },
          ),
          Positioned(
            right: 15,
            left: 15,
            bottom: ((heightPanelOpened - heightPanelClosed) * _position) +
                MediaQuery.of(context).size.height * 0.21,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                AppCircleButton(
                  onPressed: () => context.read<PerfModeBloc>().add(
                        PerfModeGetUserLocationEvent(
                          chapters.map((e) => e.place).toList(),
                        ),
                      ),
                  tag: 'getUserLocation',
                  image: ImagesSources.locationIcon,
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<PerfModeBloc, PerfModeState>(
                  builder: (context, perfModeState) {
                    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
                      builder: (context, audioPlayerState) {
                        return AppAnimatedVisibility(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                          isVisible:
                              ((audioPlayerState is AudioPlayerFinishedState) ^
                                  (perfModeState is PerfModeUserOnPlace)),
                          child: Tip(
                            title: audioPlayerState
                                        is AudioPlayerFinishedState &&
                                    perfModeState is! PerfModeUserOnPlace
                                ? 'Глава спектакля уже завершилась, дойдите до контрольной точки'
                                : 'Глава спектакля ещё не завершилась, подождите на контрольной точке',
                            icon:
                                audioPlayerState is AudioPlayerFinishedState &&
                                        perfModeState is! PerfModeUserOnPlace
                                    ? ImagesSources.tipIcon
                                    : ImagesSources.time,
                            backgroundColor: AppColor.whiteBackground,
                          ),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BlocConsumer<PerfModeBloc, PerfModeState>(
        listenWhen: (previous, current) {
          return previous.indexLocation < current.indexLocation;
        },
        listener: (context, state) {
          context.read<AudioPlayerBloc>().add(
                AudioPlayerAddPlaylistEvent(
                  audio: chapters[state.indexLocation].audioLink,
                ),
              );
        },
        builder: (context, state) {
          return Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            constraints: const BoxConstraints(maxHeight: 150, maxWidth: 400),
            child: AudioPlayerPanel(
              indexLocation: state.indexLocation,
            ),
          );
        },
      ),
    );
  }
}
