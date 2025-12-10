import 'dart:async';

import 'package:books/core/colors/colors.dart';
import 'package:books/core/utils/responsive.dart';
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = Responsive.screenWidth(context);
    
    // Get the current text direction from the context, defaulting to LTR
    final textDirection = Directionality.maybeOf(context) ?? TextDirection.ltr;
    
    return Directionality(
      textDirection: textDirection,
      child: Scaffold(
      backgroundColor: AppColors.purple,
      body: Stack(
        children: [
          // Responsive positioned SVG
          Positioned(
            top: Responsive.heightPercent(context, 60),
            left: 0,
            right: 0,
            child: Center(
              child: SvgPicture.asset(
                'assets/images/splash/splash_vector.svg',
                width: screenWidth,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Image.asset(
              'assets/images/splash/splash_logo_small_white.png',
              width: Responsive.responsiveImageSize(context, 200),
              height: Responsive.responsiveImageSize(context, 200),
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    ));
  }
}
