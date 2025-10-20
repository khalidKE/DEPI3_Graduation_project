import 'package:books/helpers/dio_helper.dart';
import 'package:books/screens/login_screen.dart';
import 'package:books/screens/phone_number_screen.dart';
import 'package:books/screens/signup_screen.dart';
import 'package:books/screens/success_screen.dart';
import 'package:books/secrets/secrets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show GetMaterialApp;
import 'package:google_sign_in/google_sign_in.dart';
import 'firebase_options.dart';
import 'package:books/const/onboarding_data.dart';
import 'package:books/helper/hive_helper.dart';
import 'package:books/screens/splash_screen.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.initialized();
  await Hive.initFlutter();
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


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}