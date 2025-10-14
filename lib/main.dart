import 'package:books/helpers/dio_helper.dart';
import 'package:books/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show GetMaterialApp;
import 'package:google_sign_in/google_sign_in.dart';
import 'firebase_options.dart';

void main() async {
  DioHelper.initialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final google = await GoogleSignIn.instance.initialize(
    clientId:
        '682142070711-at8660uq8tf7fe6vmdegjsiejle2uv6d.apps.googleusercontent.com',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LogInScreen(),
    );
  }
}
