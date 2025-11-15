import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper {
  static const String boxName = 'onboarding_box';
  static const String onboardingStateKey = 'onboarding_state';
  static bool showOnboarding = true;
  static late Box _box;

  static Future<void> initialize() async {
    _box = await Hive.openBox(boxName);
  }

  static Future<void> getShowOnboardingState() async {
    showOnboarding = _box.get(onboardingStateKey, defaultValue: true) as bool;
  }

  static Future<void> changeShowOnboardingState() async {
    showOnboarding = false;
    await _box.put(onboardingStateKey, showOnboarding);
  }

  static Box get box => _box;
}
