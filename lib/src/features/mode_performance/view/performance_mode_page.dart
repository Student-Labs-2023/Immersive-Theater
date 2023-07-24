import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:locations_repository/locations_repository.dart';
import 'package:shebalin/src/features/locations/bloc/location_bloc.dart';
import 'package:shebalin/src/features/main_screen/view/main_screen.dart';
import 'package:shebalin/src/features/map_performance/bloc/perf_mode_map_bloc.dart';
import 'package:shebalin/src/features/map_performance/view/map_page.dart';
import 'package:shebalin/src/features/mode_performance/view/widgets/audio_player/audio_player.dart';
import 'package:shebalin/src/features/mode_performance/view/widgets/audio_player/bloc/audio_player_bloc.dart';
import 'package:shebalin/src/features/mode_performance/view/widgets/dialog_window.dart';
import 'package:shebalin/src/features/mode_performance/view/widgets/panel_widget.dart';
import 'package:shebalin/src/features/mode_performance/view/widgets/progress_bar.dart';
import 'package:shebalin/src/features/mode_performance/view/widgets/tip.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:shebalin/src/theme/theme.dart';
import 'package:shebalin/src/theme/ui/animated_visibility.dart';
import 'package:shebalin/src/theme/ui/app_placeholer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class PerformanceModePage extends StatefulWidget {
  static const routeName = '/performance-mode-screen';
  const PerformanceModePage({
    super.key,
  });

  @override
  State<PerformanceModePage> createState() => _PerformanceModePageState();
}

class _PerformanceModePageState extends State<PerformanceModePage> {
  late double heightButton = 3.0;
  final panelController = PanelController();
  late List<Location> locations;
  final String performanceTitle = 'Шебалин в Омске';
  final String imageLink =
      '/uploads/1650699780207_58cb89ec46.jpg?updated_at=2023-03-30T05:51:54.127Z';

  final AudioPlayerBloc audioPlayerBloc = AudioPlayerBloc(AudioPlayer());
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double heightPanelOpened = height * 0.5;

    final double heightPanelClosed = height * 0.17;
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        if (state is LocationsLoadSuccess) {
          locations = state.locations;
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => PerfModeBloc(
                  [],
                  0,
                  locations.length,
                  performanceTitle,
                  imageLink,
                  audioPlayerBloc,
                ),
              ),
              BlocProvider(
                create: (context) {
                  return audioPlayerBloc
                    ..add(AudioPlayerInitialEvent())
                    ..add(
                      AudioPlayerAddPlaylistEvent(
                        listAudio: locations[0].paidAudioLink,
                      ),
                    );
                },
              ),
            ],
            child: Builder(
              builder: (context) {
                return Scaffold(
                  extendBodyBehindAppBar: true,
                  appBar: _appBar(),
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
                          locations: locations,
                        ),
                        body: MapPage(
                          locations: locations,
                          initialCoords: Point(
                            latitude: double.parse(locations[0].latitude),
                            longitude: double.parse(locations[0].longitude),
                          ),
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
                        left: 15,
                        bottom: heightButton + 175,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FloatingActionButton(
                              heroTag: "getUserLocation",
                              backgroundColor: Colors.white,
                              onPressed: () => context
                                  .read<PerfModeBloc>()
                                  .add(PerfModeGetUserLocationEvent(locations)),
                              child: const Image(
                                image: AssetImage(ImagesSources.locationIcon),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            BlocBuilder<PerfModeBloc, PerfModeState>(
                              builder: (context, perfModeState) {
                                return BlocBuilder<AudioPlayerBloc,
                                    AudioPlayerState>(
                                  builder: (context, audioPlayerState) {
                                    return AnimatedVisibility(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeIn,
                                      isVisible: ((audioPlayerState
                                              is AudioPlayerFinishedState) ^
                                          (perfModeState
                                              is PerfModeUserOnPlace)),
                                      child: Tip(
                                        title: audioPlayerState
                                                    is AudioPlayerFinishedState &&
                                                perfModeState
                                                    is! PerfModeUserOnPlace
                                            ? 'Глава спектакля уже завершилась, дойдите до контрольной точки'
                                            : 'Глава спектакля ещё не завершилась, подождите на контрольной точке',
                                        icon: audioPlayerState
                                                    is AudioPlayerFinishedState &&
                                                perfModeState
                                                    is! PerfModeUserOnPlace
                                            ? ImagesSources.tipIcon
                                            : ImagesSources.time,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  bottomNavigationBar:
                      BlocConsumer<PerfModeBloc, PerfModeState>(
                    listenWhen: (previous, current) {
                      return previous.indexLocation < current.indexLocation;
                    },
                    listener: (context, state) {
                      context.read<AudioPlayerBloc>().add(
                            AudioPlayerAddPlaylistEvent(
                              listAudio:
                                  locations[state.indexLocation].paidAudioLink,
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
        return const AppProgressBar();
      },
    );
  }

  AppBar _appBar() {
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
                countLocation: locations.length,
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
    onPressedApprove() => Navigator.pushNamedAndRemoveUntil(
          context,
          MainScreen.routeName,
          (route) => false,
        );
    showDialog(
      context: context,
      builder: (_) => DialogWindow(
        title: "Завершить спектакль?",
        subtitle: "Прогресс прохождения не будет\nсохранен.",
        onTapPrimary: onPressedApprove,
        titlePrimary: "Завершить",
        titleSecondary: "Отмена",
        onTapSecondary: onPressedCancel,
      ),
    );
  }
}
