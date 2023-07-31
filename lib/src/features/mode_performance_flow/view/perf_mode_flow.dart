import 'package:flutter/material.dart';
import 'package:performances_repository/performances_repository.dart';
import 'package:shebalin/src/features/mode_performance/view/performance_mode_page.dart';
import 'package:shebalin/src/features/onboarding_performance/view/onboarding_performance.dart';
import 'package:shebalin/src/features/onboarding_performance/view/onboarding_performance_args.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/onboarding_welcome.dart';

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
    } else {
      _navigatorKey.currentState!.pushNamedAndRemoveUntil(
        PerformanceModePage.routeName,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      initialRoute: widget.perfModePageRoute,
      onGenerateRoute: _onGenerateRoute,
    );
  }

  Route _onGenerateRoute(RouteSettings routeSettings) {
    late Widget page;
    switch (routeSettings.name) {
      case OnboardWelcome.routeName:
        {
          page = OnboardWelcome(
            onOnboardWelcomeComplete: _onOnboardWelcomeComplete,
            performance: widget.performance,
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
        page = const PerformanceModePage();
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
