import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper {
  static const String boxName = 'box1';
  static const String onboardingStateKey = 'box1_key';
  static bool showEnboarding = true;
  static var box = Hive.box(boxName);

  static Future<void> GetShowenboardingState() async {
    showEnboarding = await box.get(onboardingStateKey) ?? true;
  }

  static void ChangeShowenboardingState() async {
    showEnboarding = false;
    await box.put(onboardingStateKey, showEnboarding);
  }
}
