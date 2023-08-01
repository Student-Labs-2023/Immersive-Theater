import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:performances_repository/performances_repository.dart';
import 'package:shebalin/src/features/audio_player/bloc/audio_player_bloc.dart';
import 'package:shebalin/src/features/main_screen/view/main_screen.dart';
import 'package:shebalin/src/features/map_performance/bloc/perf_mode_map_bloc.dart';
import 'package:shebalin/src/features/mode_perf_home/bloc/perf_home_mode_bloc.dart';
import 'package:shebalin/src/features/mode_perf_home/view/performance_home_mode_page.dart';
import 'package:shebalin/src/features/mode_performance/view/performance_mode_page.dart';
import 'package:shebalin/src/features/mode_performance_flow/models/current_performance_provider.dart';
import 'package:shebalin/src/features/onboarding_performance/view/onboarding_performance.dart';
import 'package:shebalin/src/features/onboarding_performance/view/onboarding_performance_args.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/onboarding_welcome.dart';
import 'package:shebalin/src/features/review/view/review_page.dart';
import 'package:shebalin/src/features/view_images/models/image_view_args.dart';
import 'package:shebalin/src/features/view_images/view/images_view_page.dart';

class PerfModeFlow extends StatefulWidget {
  final String perfModePageRoute;
  final Performance performance;
  static PerfModeFlowState of(BuildContext context) {
    return context.findAncestorStateOfType<PerfModeFlowState>()!;
  }

  const PerfModeFlow({
    super.key,
    required this.perfModePageRoute,
    required this.performance,
  });

  @override
  State<PerfModeFlow> createState() => PerfModeFlowState();
}

class PerfModeFlowState extends State<PerfModeFlow> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  void _onOnboardWelcomeComplete(bool listenAtHome) {
    _navigatorKey.currentState!.pushNamed(
      OnboardingPerformance.routeName,
      arguments: OnboardingPerformanceArgs(listenAtHome: listenAtHome),
    );
  }

  void _onOnboardingComplete(bool listenAtHome) {
    if (listenAtHome) {
      _navigatorKey.currentState!.pushNamedAndRemoveUntil(
        PerformanceAtHomeModePage.routeName,
        (route) => false,
      );
    } else {
      _navigatorKey.currentState!.pushNamedAndRemoveUntil(
        PerformanceModePage.routeName,
        (route) => false,
      );
    }
  }

  void _onPerfModeComplete() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(MainScreen.routeName, (builder) => false);
  }

  void _onImageOpen(List<String> imageLinks, int index) {
    _navigatorKey.currentState!.pushNamed(
      ImagesViewPage.routeName,
      arguments: ImageViewArgs(imageLinks, index),
    );
  }

  void _onPerfModeResume() {
    Navigator.of(context).pop(false);
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) =>
          CurrentPerformanceProvider(performance: widget.performance),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Navigator(
          key: _navigatorKey,
          initialRoute: widget.perfModePageRoute,
          onGenerateRoute: _onGenerateRoute,
        ),
      ),
    );
  }

  Route _onGenerateRoute(RouteSettings routeSettings) {
    late Widget page;

    switch (routeSettings.name) {
      case OnboardWelcome.routeName:
        {
          page = OnboardWelcome(
            onOnboardWelcomeComplete: _onOnboardWelcomeComplete,
          );
          break;
        }

      case OnboardingPerformance.routeName:
        {
          final args = routeSettings.arguments as OnboardingPerformanceArgs;
          page = OnboardingPerformance(
            listenAtHome: args.listenAtHome,
            onOnboardingComplete: _onOnboardingComplete,
          );
          break;
        }

      case PerformanceModePage.routeName:
        {
          final AudioPlayerBloc audioPlayerBloc =
              AudioPlayerBloc(AudioPlayer());
          page = MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => PerfModeBloc(
                  [],
                  0,
                  widget.performance.chapters.length,
                  widget.performance.title,
                  widget.performance.imageLink,
                  audioPlayerBloc,
                  widget.performance.chapters.map((e) => e.place).toList(),
                ),
              ),
              BlocProvider(
                create: (context) {
                  return audioPlayerBloc
                    ..add(AudioPlayerInitialEvent())
                    ..add(
                      AudioPlayerAddPlaylistEvent(
                        audio: widget.performance.chapters[0].audioLink,
                      ),
                    );
                },
              ),
            ],
            child: PerformanceModePage(
              onPerfModeComplete: _onPerfModeComplete,
              onPerfModeResume: _onPerfModeResume,
              onImageOpen: _onImageOpen,
            ),
          );
          break;
        }
      case PerformanceAtHomeModePage.routeName:
        {
          final AudioPlayerBloc audioPlayerBloc =
              AudioPlayerBloc(AudioPlayer());
          page = MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => PerfHomeModeBloc(
                  [],
                  0,
                  widget.performance.chapters.length,
                  widget.performance.title,
                  widget.performance.imageLink,
                  audioPlayerBloc,
                  widget.performance.chapters.map((e) => e.place).toList(),
                ),
              ),
              BlocProvider(
                create: (context) {
                  return audioPlayerBloc
                    ..add(AudioPlayerInitialEvent())
                    ..add(
                      AudioPlayerAddPlaylistEvent(
                        audio: widget.performance.chapters[0].audioLink,
                      ),
                    );
                },
              ),
            ],
            child: PerformanceAtHomeModePage(
              onPerfModeComplete: _onPerfModeComplete,
              onPerfModeResume: _onPerfModeResume,
              onImageOpen: _onImageOpen,
            ),
          );
          break;
        }
      case ImagesViewPage.routeName:
        {
          page = const ImagesViewPage();
        }
        break;
      case MainScreen.routeName:
        {
          page = const MainScreen();
        }
        break;
      case ReviewPage.routeName:
        {
          page = ReviewPage(
            onPerfModeComplete: _onPerfModeComplete,
          );
        }
        break;
    }

    return MaterialPageRoute<dynamic>(
      builder: (context) {
        return page;
      },
      settings: routeSettings,
    );
  }
}
