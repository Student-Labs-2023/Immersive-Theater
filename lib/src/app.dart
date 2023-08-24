import 'package:api_client/api_client.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:payment_service/payment_service.dart';
import 'package:performances_repository/performances_repository.dart';
import 'package:shebalin/src/features/authentication/bloc/authentication_bloc.dart';
import 'package:shebalin/src/features/connectivity/bloc/connectivity_bloc.dart';
import 'package:shebalin/src/features/detailed_performaces/bloc/detailed_performance_bloc.dart';
import 'package:shebalin/src/features/detailed_performaces/view/detailed_performance_args.dart';
import 'package:shebalin/src/features/detailed_performaces/view/detailed_performance_page.dart';
import 'package:shebalin/src/features/login/bloc/login_bloc.dart';
import 'package:shebalin/src/features/login/view/login_page.dart';
import 'package:shebalin/src/features/login/view/widgets/verification_page.dart';
import 'package:shebalin/src/features/main_screen/view/main_screen.dart';
import 'package:shebalin/src/features/payment/view/payment_page.dart';
import 'package:shebalin/src/features/payment/view/payment_page_args.dart';
import 'package:shebalin/src/features/splash_screen/view/splash_screen.dart';
import 'package:shebalin/src/features/map/bloc/map_pin_bloc.dart';
import 'package:shebalin/src/features/mode_performance_flow/view/perf_mode_flow.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/onboarding_welcome.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/onboarding_welcome_args.dart';
import 'package:shebalin/src/features/onbording/view/onbording_screen.dart';
import 'package:shebalin/src/features/performances/bloc/performance_bloc.dart';
import 'package:shebalin/src/features/review/bloc/review_page_bloc.dart';
import 'package:shebalin/src/features/review/models/emoji.dart';
import 'package:shebalin/src/features/tickets/bloc/ticket_bloc.dart';
import 'package:shebalin/src/features/view_images/view/images_view_page.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/theme.dart';

import 'features/payment/bloc/payment_bloc.dart';

class App extends StatelessWidget {
  final AuthenticationRepositoryImpl _authenticationRepository;
  final bool hasConnection;
  const App({
    super.key,
    required AuthenticationRepositoryImpl authenticationRepository,
    required this.hasConnection,
  }) : _authenticationRepository = authenticationRepository;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InternetConnectionBloc(
        hasConnection
            ? InternetConnectionStatus.connected
            : InternetConnectionStatus.disconnected,
      ),
      child: RepositoryProvider.value(
        value: _authenticationRepository,
        child: BlocProvider(
          create: (_) => AuthenticationBloc(
            authRepository: _authenticationRepository,
          ),
          child: const AppView(),
        ),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  bool isShown = false;

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
          )..add(
              PerformancesStarted(
                context.read<AuthenticationRepositoryImpl>().currentUser.id,
              ),
            ),
        ),
        BlocProvider(
          create: (_) => TicketBloc(
            performancesRepository:
                RepositoryProvider.of<PerformancesRepository>(context),
          )..add(
              TicketStarted(
                context.read<AuthenticationRepositoryImpl>().currentUser.id,
              ),
            ),
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
      child: RepositoryProvider.value(
        value: PaymentServiceImpl(
          apiClient: RepositoryProvider.of<ApiClient>(context),
        ),
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
            } else if (routeSettings.name ==
                DetailedPerformancePage.routeName) {
              final args = routeSettings.arguments as DetailedPerformanceArgs;
              final String userId =
                  context.read<AuthenticationRepositoryImpl>().currentUser.id;
              page = BlocProvider(
                create: (context) => DetailedPerformanceBloc(
                  performance: args.performance,
                  performanceRepository:
                      RepositoryProvider.of<PerformancesRepository>(context),
                  paymentService:
                      RepositoryProvider.of<PaymentServiceImpl>(context),
                )..add(DetailedPerformanceStarted(userId)),
                child: const DetailedPerformancePage(),
              );
            } else if (routeSettings.name == PaymentPage.routeName) {
              final args = routeSettings.arguments as PaymentPageArgs;
              page = BlocProvider(
                create: (context) => PaymentBloc(
                  paymentService:
                      RepositoryProvider.of<PaymentServiceImpl>(context),
                )..add(
                    PaymentGetLink(
                      userId: context
                          .read<AuthenticationRepositoryImpl>()
                          .currentUser
                          .id,
                      perfId: args.perfid,
                    ),
                  ),
                child: const PaymentPage(),
              );
            } else if (routeSettings.name == ImagesViewPage.routeName) {
              page = const ImagesViewPage();
            } else if (routeSettings.name == LoginPage.routeName) {
              page = const LoginPage();
            } else if (routeSettings.name == VerificationPage.routeName) {
              page = const VerificationPage();
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
              builder: (BuildContext context) =>
                  BlocListener<InternetConnectionBloc, InternetConnectionState>(
                listener: (context, state) {
                  if (state.status == InternetConnectionStatus.disconnected &&
                      !isShown) {
                    isShown = true;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(days: 1),
                        backgroundColor: AppColor.destructiveAlertDialog,
                        content: Text(
                          'Нет соединения с интернетом',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  } else if (state.status ==
                          InternetConnectionStatus.connected &&
                      isShown) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    isShown = false;
                  }
                },
                child: page,
              ),
            );
          },
        ),
      ),
    );
  }
}
