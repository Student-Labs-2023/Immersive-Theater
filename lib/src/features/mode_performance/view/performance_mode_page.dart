import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:locations_repository/locations_repository.dart';
import 'package:shebalin/src/features/active_performance/bloc/perf_mode_map_bloc.dart';
import 'package:shebalin/src/features/mode_performance/bloc/mode_performance_bloc.dart';
import 'package:shebalin/src/features/mode_performance/view/widgets/audio_player/audio_player.dart';
import 'package:shebalin/src/features/mode_performance/view/widgets/audio_player/bloc/audio_player_bloc.dart';
import 'package:shebalin/src/features/mode_performance/view/widgets/dialog_window.dart';
import 'package:shebalin/src/features/mode_performance/view/widgets/map_page.dart';
import 'package:shebalin/src/features/mode_performance/view/widgets/panel_widget.dart';
import 'package:shebalin/src/features/mode_performance/view/widgets/progress_bar.dart';
import 'package:shebalin/src/features/mode_performance/view/widgets/tip.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:shebalin/src/theme/theme.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class PerformanceModePage extends StatefulWidget {
  final List<Location> locations;
  final String performanceTitle;
  final String imageLink;
  final mapbloc = PerfModeMapBloc();

  PerformanceModePage({
    super.key,
    required this.locations,
    required this.performanceTitle,
    required this.imageLink,
  });

  @override
  State<PerformanceModePage> createState() => _PerformanceModePageState();
}

class _PerformanceModePageState extends State<PerformanceModePage> {
  final AudioPlayer player = AudioPlayer();
  late double heightButton = 10.0;
  final panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double heightPanelOpened = height * 0.5;

    final double heightPanelClosed = height * 0.17;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ModePerformanceBloc(
            0,
            widget.locations.length,
            widget.performanceTitle,
            widget.imageLink,
          ),
        ),
        BlocProvider(
          create: (context) {
            return AudioPlayerBloc(player)
              ..add(AudioPlayerInitialEvent())
              ..add(
                AudioPlayerAddPlaylistEvent(
                  listAudio: widget.locations[0].paidAudioLink,
                ),
              );
          },
        ),
        BlocProvider<PerfModeMapBloc>(
          create: (context) {
            return widget.mapbloc;
          },
        ),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: appBar(),
            body: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                SlidingUpPanel(
                  controller: panelController,
                  parallaxEnabled: true,
                  parallaxOffset: .5,
                  minHeight: heightPanelClosed,
                  maxHeight: heightPanelOpened,
                  borderRadius: panelRadius,
                  panelBuilder: (scrollController) => PanelWidget(
                    controller: panelController,
                    locations: widget.locations,
                  ),
                  body: BlocBuilder<ModePerformanceBloc, ModePerformanceState>(
                    builder: (context, state) {
                      return MapPage(
                        locations: widget.locations,
                        initialCoords: const Point(
                          latitude: 54.988707,
                          longitude: 73.368659,
                        ),
                      );
                    },
                  ),
                  onPanelSlide: (position) {
                    setState(() {
                      final double panelMaxScrollEffect =
                          heightPanelOpened - heightPanelClosed;
                      heightButton = position * panelMaxScrollEffect;
                    });
                  },
                ),
                Positioned(
                  right: 15,
                  bottom: heightButton + 160,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FloatingActionButton(
                        heroTag: "getUserLocation",
                        backgroundColor: Colors.white,
                        onPressed: _getUserBloc,
                        child: const Image(
                          image: AssetImage(ImagesSources.locationIcon),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
                        builder: (context, state) {
                          return Visibility(
                            visible: state is AudioPlayerFinishedState,
                            child: const Tip(),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ],
            ),
            bottomNavigationBar:
                BlocConsumer<ModePerformanceBloc, ModePerformanceState>(
              listenWhen: (previous, current) {
                return previous.indexLocation < current.indexLocation;
              },
              listener: (context, state) {
                context.read<AudioPlayerBloc>().add(
                      AudioPlayerAddPlaylistEvent(
                        listAudio:
                            widget.locations[state.indexLocation].paidAudioLink,
                      ),
                    );
              },
              builder: (context, state) {
                return Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  constraints:
                      const BoxConstraints(maxHeight: 150, maxWidth: 400),
                  child: const AudioPlayerPanel(),
                );
              },
            ),
          );
        },
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      toolbarHeight: 100,
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ProgressLocationsBar(
                countLocation: widget.locations.length,
                durationPerformance: 45,
              ),
              FloatingActionButton(
                heroTag: "closePerformance",
                backgroundColor: Colors.white,
                onPressed: () => _closePerformance(context),
                child: const Image(
                  image: AssetImage(ImagesSources.closePerformance),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _closePerformance(BuildContext context) {
    onPressedCancel() => Navigator.pop(
          context,
        );
    onPressedApprove() => Navigator.pop(
          context,
        );
    showDialog(
      context: context,
      builder: (_) => DialogWindow(
        title: "Завершить спектакль?",
        subtitle: "Прогресс прохождения не будет сохранен.",
        onPressedCancel: onPressedCancel,
        titleApprove: "Завершить",
        titleCancel: "Отмена",
        onPressedApprove: onPressedApprove,
      ),
    );
  }

  void _getUserBloc() {
    widget.mapbloc.add(PerfModeMapGetUserLocationEvent());
  }
}
