import 'dart:developer';

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
import 'package:shebalin/src/features/mode_performance/view/widgets/dialog_window.dart';
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

  String currentRouteName = '';

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
    Navigator.of(context).popUntil(ModalRoute.withName(MainScreen.routeName));
  }

  void _onImageOpen(List<String> imageLinks, int index) {
    Navigator.of(context).pushNamed(
      ImagesViewPage.routeName,
      arguments: ImageViewArgs(imageLinks, index),
    );
  }

  void _onPerfModeResume() {
    Navigator.of(context).pop(false);
  }

  Future<bool> _showDialogWindow() async {
    return await showDialog(
          context: context,
          builder: (_) => DialogWindow(
            title: "Завершить спектакль?",
            subtitle: "Прогресс прохождения не будет\nсохранен.",
            onTapPrimary: _onPerfModeComplete,
            titlePrimary: "Завершить",
            titleSecondary: "Отмена",
            onTapSecondary: _onPerfModeResume,
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) =>
          CurrentPerformanceProvider(performance: widget.performance),
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Navigator(
          observers: [MyNavigatorObserver()],
          key: _navigatorKey,
          initialRoute: widget.perfModePageRoute,
          onGenerateRoute: _onGenerateRoute,
        ),
      ),
    );
  }

  Route _onGenerateRoute(RouteSettings routeSettings) {
    late Widget page;
    currentRouteName = routeSettings.name ?? '';
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
                  widget.performance.info.chapters.length,
                  widget.performance.title,
                  widget.performance.imageLink,
                  audioPlayerBloc,
                  widget.performance.info.chapters.map((e) => e.place).toList(),
                ),
              ),
              BlocProvider(
                create: (context) {
                  return audioPlayerBloc
                    ..add(AudioPlayerInitialEvent())
                    ..add(
                      AudioPlayerAddPlaylistEvent(
                        audio: widget.performance.info.chapters[0].audioLink,
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
                  widget.performance.info.chapters.length,
                  widget.performance.title,
                  widget.performance.imageLink,
                  audioPlayerBloc,
                  widget.performance.info.chapters.map((e) => e.place).toList(),
                ),
              ),
              BlocProvider(
                create: (context) {
                  return audioPlayerBloc
                    ..add(AudioPlayerInitialEvent())
                    ..add(
                      AudioPlayerAddPlaylistEvent(
                        audio: widget.performance.info.chapters[0].audioLink,
                      ),
                    );
                },
              ),
            ],
            child: PerformanceAtHomeModePage(
              closePerformance: _showDialogWindow,
              onImageOpen: _onImageOpen,
            ),
          );
          break;
        }

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

  Future<bool> _onWillPop() async {
    if (currentRouteName == PerformanceAtHomeModePage.routeName ||
        currentRouteName == PerformanceModePage.routeName) {
      return await _showDialogWindow();
    } else if (currentRouteName == OnboardWelcome.routeName ||
        currentRouteName == OnboardingPerformance.routeName) {
      return true;
    } else if (currentRouteName == ReviewPage.routeName) {
      _onPerfModeComplete();
      return true;
    } else if (currentRouteName == ImagesViewPage.routeName) {
      return true;
    }

    return false;
  }
}

class MyNavigatorObserver extends NavigatorObserver {
  List<String> routeStack = [];

  @override
  void didPop(Route route, Route? previousRoute) {
    routeStack.removeLast();
    log(
      'didppop: ${route.settings.name}- ${previousRoute!.settings.name}',
      name: 'nest',
    );
    // log(routeStack.toString(), name: 'nest');

    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    routeStack.add(route.settings.name!);
    log(
      'didPush: $route.settings.name- ${previousRoute?.settings.name}',
      name: 'nest',
    );
    // log(routeStack.toString(), name: 'nest');
    super.didPush(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    routeStack.removeLast();
    log(
      'didRemove: ${route.settings.name}- ${previousRoute?.settings.name}',
      name: 'nest',
    );
    // log(routeStack.toString(), name: 'nest');
    super.didRemove(
      route,
      previousRoute,
    );
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    routeStack.removeLast();
    routeStack.add(newRoute!.settings.name!);
    log(
      'didReplace: ${newRoute.settings.name}- ${oldRoute?.settings.name}',
      name: 'nest',
    );
    // log(routeStack.toString(), name: 'nest');
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}
