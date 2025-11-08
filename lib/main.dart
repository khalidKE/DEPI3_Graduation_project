import 'package:books/features/cart_feature/presentation/views/order_recieved_screen.dart';
import 'package:books/l10n/app_localizations.dart';
import 'features/cart_feature/presentation/views/confirm_order_screen.dart';
import 'features/cart_feature/presentation/views/set_location_screen.dart';
import 'package:books/features/authentication_feature/presentation/views/login_screen.dart';
import 'package:books/features/authentication_feature/presentation/views/phone_number_screen.dart';
import 'package:books/features/authentication_feature/presentation/views/signup_screen.dart';
import 'package:books/features/authentication_feature/presentation/views/success_screen.dart';
import 'package:books/secrets/secrets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show GetMaterialApp;
import 'package:google_sign_in/google_sign_in.dart';
import 'firebase_options.dart';
import 'package:books/features/onboarding_feature/data/onboarding_data.dart';
import 'package:books/features/onboarding_feature/data/hive_helper.dart';
import 'package:books/features/splash_feature/presentation/views/splash_screen.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:books/features/notification_feature/presentation/views/notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:books/features/category_feature/presentation/views/category_screen.dart';

Future<void> _backgroundHandler(RemoteMessage message) async {
  // Handle background message
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Message data: ${message.data}');
    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Message clicked! ${message.messageId}');
  });

  await Hive.openBox(HiveHelper.boxName);
  await HiveHelper.GetShowenboardingState();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase initialized successfully');
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
  final google = await GoogleSignIn.instance.initialize(
    clientId: Secrets.clientID,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale("ar"),
      home: SplashScreen(),
    );
  }
}
