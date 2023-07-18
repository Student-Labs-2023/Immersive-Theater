import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:locations_repository/locations_repository.dart';
import 'package:shebalin/src/features/locations/bloc/location_bloc.dart';
import 'package:shebalin/src/features/main_screen/view/main_screen.dart';
import 'package:shebalin/src/features/map_performance/bloc/perf_mode_map_bloc.dart';
import 'package:shebalin/src/features/map_performance/view/map_page.dart';
import 'package:shebalin/src/features/mode_performance/bloc/mode_performance_bloc.dart';
import 'package:shebalin/src/features/mode_performance/view/widgets/audio_player/audio_player.dart';
import 'package:shebalin/src/features/mode_performance/view/widgets/audio_player/bloc/audio_player_bloc.dart';
import 'package:shebalin/src/features/mode_performance/view/widgets/continue_button.dart';
import 'package:shebalin/src/features/mode_performance/view/widgets/dialog_window.dart';
import 'package:shebalin/src/features/mode_performance/view/widgets/panel_widget.dart';
import 'package:shebalin/src/features/mode_performance/view/widgets/progress_bar.dart';
import 'package:shebalin/src/features/mode_performance/view/widgets/tip.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:shebalin/src/theme/theme.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class PerformanceModePage extends StatefulWidget {
  final mapbloc = PerfModeMapBloc();
  static const routeName = '/performance-mode-screen';
  PerformanceModePage({
    super.key,
  });

  @override
  State<PerformanceModePage> createState() => _PerformanceModePageState();
}

class _PerformanceModePageState extends State<PerformanceModePage> {
  final AudioPlayer player = AudioPlayer();
  late double heightButton = 10.0;
  final panelController = PanelController();
  late List<Location> locations;
  final String performanceTitle = 'Шебалин в Омске';
  final String imageLink =
      '/uploads/1650699780207_58cb89ec46.jpg?updated_at=2023-03-30T05:51:54.127Z';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

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
                create: (context) => ModePerformanceBloc(
                  0,
                  locations.length,
                  performanceTitle,
                  imageLink,
                ),
              ),
              BlocProvider(
                create: (context) {
                  return AudioPlayerBloc(player)
                    ..add(AudioPlayerInitialEvent())
                    ..add(
                      AudioPlayerAddPlaylistEvent(
                        listAudio: locations[0].paidAudioLink,
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
                        body: BlocBuilder<ModePerformanceBloc,
                            ModePerformanceState>(
                          builder: (context, state) {
                            return MapPage(
                              locations: locations,
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
                        left: 15,
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
                                  child: ContinueButton(
                                    title:
                                        'Я уже добрался до следующей локации',
                                    onTap: () => {
                                      context.read<ModePerformanceBloc>().add(
                                            ModePerformanceCurrentLocationUpdate(),
                                          )
                                    },
                                  ),
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
        return CircularProgressIndicator();
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
