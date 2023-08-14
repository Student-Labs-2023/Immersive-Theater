import 'package:api_client/api_client.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:performances_repository/performances_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shebalin/src/app.dart';
import 'package:shebalin/src/features/onbording/model/shared_preferences_model.dart';

bool? isFirstRun;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();

  await Firebase.initializeApp();
  final authenticationRepository = AuthenticationRepositoryImpl();
  await authenticationRepository.user.first;
  isFirstRun = preferences.getBool(
    SharedPreferencesKeys.isFirstRunName,
  );
  await dotenv.load();
  final apiKey = dotenv.env['API_KEY']!;
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ApiClient>(
          create: (context) => ApiClient(),
        ),
        RepositoryProvider<PerformancesRepository>(
          create: (context) => PerformancesRepositoryImpl(
            apiClient: RepositoryProvider.of<ApiClient>(context),
            apiKey: apiKey,
          ),
        ),
      ],
      child: App(
        authenticationRepository: authenticationRepository,
      ),
    ),
  );
}
