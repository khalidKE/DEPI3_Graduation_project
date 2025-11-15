import 'dart:async';

import 'package:books/core/colors/colors.dart';
import 'package:books/features/onboarding_feature/data/hive_helper.dart';
import 'package:books/features/authentication_feature/presentation/views/login_screen.dart';
import 'package:books/features/onboarding_feature/presentation/views/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (HiveHelper.showOnboarding) {
        HiveHelper.changeShowOnboardingState();
        Get.off(() => const OnboardingScreen());
      } else {
        Get.off(() => const LogInScreen());
      }
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      backgroundColor: AppColors.purple,
      body: Stack(
        children: [
          Positioned(top: 495, child: SvgPicture.asset('assets/Vector.svg')),
          Center(
            child: Image.asset('assets/Property 1=Small, Property 2=White.png'),
          ),
        ],
      ),
    ));
  }
}
