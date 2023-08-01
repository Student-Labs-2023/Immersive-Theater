import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:performances_repository/performances_repository.dart';
import 'package:shebalin/src/features/detailed_performaces/view/performance_double_screen.dart';
import 'package:shebalin/src/features/loading/view/loading_screen.dart';
import 'package:shebalin/src/features/main_screen/view/main_screen.dart';
import 'package:shebalin/src/features/map/bloc/map_pin_bloc.dart';
import 'package:shebalin/src/features/mode_performance_flow/view/perf_mode_flow.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/onboarding_welcome.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/onboarding_welcome_args.dart';
import 'package:shebalin/src/features/onbording/view/onbording_screen.dart';
import 'package:shebalin/src/features/performances/bloc/performance_bloc.dart';
import 'package:shebalin/src/features/photo_slider/view/vertical_sliding_screen.dart';
import 'package:shebalin/src/features/review/bloc/review_page_bloc.dart';
import 'package:shebalin/src/features/review/models/emoji.dart';
import 'package:shebalin/src/features/view_images/view/images_view_page.dart';
import 'package:shebalin/src/theme/theme.dart';

class App extends StatelessWidget {
  final bool? isFirstRun;
  const App({Key? key, required this.isFirstRun}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => MapPinBloc(),
        ),
        BlocProvider(
          create: (_) => PerformanceBloc(
            performanceRepository:
                RepositoryProvider.of<PerformancesRepository>(context),
          )..add(PerformancesStarted()),
        ),
        BlocProvider(
          create: (_) => ReviewPageBloc(Emoji.emotions),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Shebalin",
        theme: defaultTheme(),
        onGenerateRoute: (RouteSettings routeSettings) {
          late Widget page;
          if (routeSettings.name == MainScreen.routeName) {
            if (isFirstRun == null) {
              page = const OnbordingScreen();
            } else {
              page = const MainScreen();
            }
          } else if (routeSettings.name == LoadingScreen.routeName) {
            page = const LoadingScreen();
          } else if (routeSettings.name == PerformanceDoubleScreen.routeName) {
            page = const PerformanceDoubleScreen();
          } else if (routeSettings.name == VerticalSlidningScreen.routeName) {
            page = const VerticalSlidningScreen();
          } else if (routeSettings.name == ImagesViewPage.routeName) {
            page = const ImagesViewPage();
          } else if (routeSettings.name!.startsWith(routePrefixPerfMode)) {
            final subRoute =
                routeSettings.name!.substring(routePrefixPerfMode.length);
            final args = routeSettings.arguments as OnboardingWelcomeArgs;
            page = PerfModeFlow(
              perfModePageRoute: subRoute,
              performance: args.performance,
            );
          } else {
            throw Exception('Unknown route: ${routeSettings.name}');
          }
          return MaterialPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => page,
          );
        },
      ),
    );
  }
}
