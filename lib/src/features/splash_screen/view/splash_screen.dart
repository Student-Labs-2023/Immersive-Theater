import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shebalin/main.dart';
import 'package:shebalin/src/features/authentication/bloc/authentication_bloc.dart';
import 'package:shebalin/src/features/authorization/auth_screen.dart';
import 'package:shebalin/src/features/onbording/model/shared_preferences_model.dart';
import 'package:shebalin/src/features/onbording/view/onbording_screen.dart';
import 'package:shebalin/src/features/main_screen/view/main_screen.dart';
import 'package:shebalin/src/theme/images.dart';

class SplashScreen extends StatefulWidget {
  final AuthenticationStatus status;
  const SplashScreen({Key? key, required this.status}) : super(key: key);
  static const routeName = '/loading-screen';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _storeLoadingInfo() async {
    bool isFirstRun = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(SharedPreferencesKeys.isFirstRunName, isFirstRun);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (isFirstRun ?? true) {
        _storeLoadingInfo();
        Navigator.of(context).pushReplacementNamed(OnbordingScreen.routeName);
      } else if (widget.status == AuthenticationStatus.authenticated) {
        Navigator.of(context).popAndPushNamed(MainScreen.routeName);
      } else {
        Navigator.of(context).popAndPushNamed(AuthScreen.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.29, -0.96),
            end: Alignment(-0.29, 0.96),
            colors: [Color(0xFF7A5BFF), Color(0xFFAA9DFF)],
          ),
        ),
        child: Center(
          child: SvgPicture.asset(
            ImagesSources.logo,
          ),
        ),
      ),
    );
  }
}
