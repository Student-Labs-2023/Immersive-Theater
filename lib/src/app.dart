import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locations_repository/locations_repository.dart';
import 'package:performances_repository/performances_repository.dart';
import 'package:shebalin/src/features/detailed_performaces/view/performance_double_screen.dart';
import 'package:shebalin/src/features/loading/view/loading_screen.dart';
import 'package:shebalin/src/features/locations/bloc/location_bloc.dart';
import 'package:shebalin/src/features/main_screen/view/main_screen.dart';
import 'package:shebalin/src/features/map/bloc/map_pin_bloc.dart';
import 'package:shebalin/src/features/mode_performance/view/performance_mode_page.dart';
import 'package:shebalin/src/features/onboarding_performance/view/onboarding_performance.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/onboarding_welcome.dart';
import 'package:shebalin/src/features/onbording/view/onbording_screen.dart';
import 'package:shebalin/src/features/performances/bloc/performance_bloc.dart';
import 'package:shebalin/src/features/photo_slider/view/vertical_sliding_screen.dart';
import 'package:shebalin/src/features/promocodes/view/own_promocodes_screen.dart';
import 'package:shebalin/src/features/promocodes/view/widgets/promocode_screen.dart';
import 'package:shebalin/src/features/review/bloc/review_page_bloc.dart';
import 'package:shebalin/src/features/review/view/review_page.dart';
import 'package:shebalin/src/features/review/models/emoji.dart';
import 'package:shebalin/src/features/ticket/view/ticket_page.dart';
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
          create: (_) => LocationBloc(
            locationRepository:
                RepositoryProvider.of<LocationsRepository>(context),
          )..add(LocationsStarted()),
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
        initialRoute: '/performance-mode-screen',
        routes: {
          '/loading-screen': (context) => const LoadingScreen(),
          '/onbording-screen': (context) => const OnbordingScreen(),
          '/main-screen': (context) => const MainScreen(),
          '/perfomance-description-screen': (context) =>
              const PerformanceDoubleScreen(),
          '/promocode-screen': (context) => PromocodeScreen(),
          '/promocode-screen/own': (context) => const OwnPromocodesScreen(),
          '/vertical-sliding-screen': (context) =>
              const VerticalSlidningScreen(),
          '/images-view-page': (context) => const ImagesViewPage(),
          '/onboarding-performance': (context) => const OnboardWelcome(),
          '/onboarding-rules': (context) => const OnboardingPerformance(),
          '/review-page': (context) => const ReviewPage(),
          '/performance-mode-screen': (context) => PerformanceModePage(),
        },
      ),
    );
  }
}
