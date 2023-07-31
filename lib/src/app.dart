import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:performances_repository/performances_repository.dart';
import 'package:shebalin/src/features/detailed_performaces/view/performance_double_screen.dart';
import 'package:shebalin/src/features/loading/view/loading_screen.dart';
import 'package:shebalin/src/features/main_screen/view/main_screen.dart';
import 'package:shebalin/src/features/map/bloc/map_pin_bloc.dart';
import 'package:shebalin/src/features/mode_performance/view/performance_mode_page.dart';
import 'package:shebalin/src/features/onboarding_performance/view/onboarding_performance.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/onboarding_welcome.dart';
import 'package:shebalin/src/features/onbording/view/onbording_screen.dart';
import 'package:shebalin/src/features/performances/bloc/performance_bloc.dart';
import 'package:shebalin/src/features/photo_slider/view/vertical_sliding_screen.dart';
import 'package:shebalin/src/features/review/bloc/review_page_bloc.dart';
import 'package:shebalin/src/features/review/view/review_page.dart';
import 'package:shebalin/src/features/review/models/emoji.dart';
import 'package:shebalin/src/features/view_images/view/images_view_page.dart';
import 'package:shebalin/src/theme/theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
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
          return MaterialPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) {
              switch (routeSettings.name) {
                case MainScreen.routeName:
                  {
                    return const MainScreen();
                  }
                case LoadingScreen.routeName:
                  {
                    return const LoadingScreen();
                  }
                case PerformanceDoubleScreen.routeName:
                  {
                    return const PerformanceDoubleScreen();
                  }

                case VerticalSlidningScreen.routeName:
                  {
                    return const VerticalSlidningScreen();
                  }
                case ImagesViewPage.routeName:
                  {
                    return const ImagesViewPage();
                  }
                case OnboardWelcome.routeName:
                  {
                    return const OnboardWelcome();
                  }
                case OnboardingPerformance.routeName:
                  {
                    return const OnboardingPerformance();
                  }
                case OnbordingScreen.routeName:
                  {
                    return const OnbordingScreen();
                  }
                case ReviewPage.routeName:
                  {
                    return const ReviewPage();
                  }
                case PerformanceModePage.routeName:
                  {
                    return const PerformanceModePage();
                  }

                default:
                  throw ('Undefined route');
              }
            },
          );
        },
        routes: {
          '/loading-screen': (context) => const LoadingScreen(),
          '/onbording-screen': (context) => const OnbordingScreen(),
          '/main-screen': (context) => const MainScreen(),
          '/perfomance-description-screen': (context) =>
              const PerformanceDoubleScreen(),
          '/vertical-sliding-screen': (context) =>
              const VerticalSlidningScreen(),
          '/images-view-page': (context) => const ImagesViewPage(),
          '/onboarding-performance': (context) => const OnboardWelcome(),
          '/onboarding-rules': (context) => const OnboardingPerformance(),
          '/review-page': (context) => const ReviewPage(),
          '/performance-mode-screen': (context) => const PerformanceModePage(),
        },
      ),
    );
  }
}
