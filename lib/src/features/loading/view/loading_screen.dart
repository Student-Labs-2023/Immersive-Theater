import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shebalin/main.dart';
import 'package:shebalin/src/features/onbording/model/shared_preferences_model.dart';
import 'package:shebalin/src/features/onbording/view/onbording_screen.dart';
import 'package:shebalin/src/features/main_screen/view/main_screen.dart';
import 'package:shebalin/src/theme/images.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);
  static const routeName = '/loading-screen';
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final Future<SharedPreferences> _onbordingRunModel =
      SharedPreferences.getInstance();

  _storeLoadingInfo() async {
    bool isFirstRun = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(SharedPreferencesKeys.isFirstRunName, isFirstRun);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      if (isFirstRun ?? true) {
        _storeLoadingInfo();
        Navigator.of(context).pushReplacementNamed(OnbordingScreen.routeName);
      } else {
        Navigator.of(context).popAndPushNamed(MainScreen.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(image: AssetImage(ImagesSources.loadingEmblem)),
      ),
    );
  }
}
