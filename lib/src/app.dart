import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:performances_repository/performances_repository.dart';
import 'package:shebalin/src/features/authentication/bloc/authentication_bloc.dart';
import 'package:shebalin/src/features/detailed_performaces/bloc/detailed_performance_bloc.dart';
import 'package:shebalin/src/features/detailed_performaces/view/detailed_performance_args.dart';
import 'package:shebalin/src/features/detailed_performaces/view/detailed_performance_page.dart';
import 'package:shebalin/src/features/login/bloc/login_bloc.dart';
import 'package:shebalin/src/features/login/view/login_page.dart';
import 'package:shebalin/src/features/login/view/widgets/verification_page.dart';
import 'package:shebalin/src/features/login/view/widgets/verification_page_args.dart';
import 'package:shebalin/src/features/main_screen/view/main_screen.dart';
import 'package:shebalin/src/features/splash_screen/view/splash_screen.dart';
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
  final AuthenticationRepositoryImpl _authenticationRepository;
  const App({
    super.key,
    required AuthenticationRepositoryImpl authenticationRepository,
  }) : _authenticationRepository = authenticationRepository;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authRepository: _authenticationRepository,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

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
        BlocProvider(
          create: (context) => LoginBloc(
            authenticationRepository:
                context.read<AuthenticationRepositoryImpl>(),
          ),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Shebalin",
        theme: defaultTheme(),
        initialRoute: SplashScreen.routeName,
        onGenerateRoute: (RouteSettings routeSettings) {
          late Widget page;
          if (routeSettings.name == MainScreen.routeName) {
            page = const MainScreen();
          } else if (routeSettings.name == SplashScreen.routeName) {
            page = SplashScreen(
              status: context.read<AuthenticationBloc>().state.status,
            );
          } else if (routeSettings.name == OnbordingScreen.routeName) {
            page = const OnbordingScreen();
          } else if (routeSettings.name == DetailedPerformancePage.routeName) {
            final args = routeSettings.arguments as DetailedPerformanceArgs;
            page = BlocProvider(
              create: (context) => DetailedPerformanceBloc(
                performance: args.performance,
                performanceRepository:
                    RepositoryProvider.of<PerformancesRepository>(context),
              )..add(const DetailedPerformanceStarted()),
              child: const DetailedPerformancePage(),
            );
          } else if (routeSettings.name == VerticalSlidningScreen.routeName) {
            page = const VerticalSlidningScreen();
          } else if (routeSettings.name == ImagesViewPage.routeName) {
            page = const ImagesViewPage();
          } else if (routeSettings.name == LoginPage.routeName) {
            page = const LoginPage();
          } else if (routeSettings.name == VerificationPage.routeName) {
            final args = routeSettings.arguments as VerificationPageArgs;
            page = VerificationPage(phoneNumber: args.phoneNumber);
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
