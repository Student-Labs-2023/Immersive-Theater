import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferencesKeys {
  static const isFirstRunName = 'isFirstRun';
}

class OnboardingRunModel {
  final _storage = SharedPreferences.getInstance();

  Future<void> changeStatus() async {
    final storage = await _storage;
    storage.setBool(SharedPreferencesKeys.isFirstRunName, false);
  }

  Future<bool> getStatus() async {
    final storage = await _storage;
    return storage.getBool(SharedPreferencesKeys.isFirstRunName) ?? true;
  }
}
