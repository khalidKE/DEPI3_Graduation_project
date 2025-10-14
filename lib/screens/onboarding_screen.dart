import 'package:books/colors/colors.dart';
import 'package:books/cubit/onboarding_cubit.dart';
import 'package:books/cubit/onboarding_state.dart';
import 'package:books/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  String highlight = 'Now reading books will be easier';
  String description =
      ' Discover new worlds, join a vibrant reading community. Start your reading adventure effortlessly with us.';
  String imagePath = 'assets/Frame.png';
  String stagePath = 'assets/Auto Layout Horizontal.png';
  String buttunText = 'Continue';
  int count = 0;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.sizeOf(context).height;
    final double screenWidth = MediaQuery.sizeOf(context).width;
    return (BlocProvider(
      create: (context) => OnboardingCubit(),
      child: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          final cubit = context.read<OnboardingCubit>();
          if (state is onboardingLoadingState) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.purple),
            );
          }
          if (state is onboardingGetToLogin) {
            Get.to(LogInScreen());
          }
          return Scaffold(
            backgroundColor: AppColors.white,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 27, right: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(LogInScreen());
                          },
                          child: Text(
                            'Skip',
                            style: TextStyle(
                              color: AppColors.purple,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: screenHeight * 0.025),
                    Image.asset(
                      cubit.onboardingData.imagePath,
                      height: 320,
                      width: 320,
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Container(
                      height: screenHeight * 0.1,
                      width: screenWidth * 0.9,
                      padding: EdgeInsets.only(
                        left: screenWidth * 0.1,
                        right: screenWidth * 0.1,
                      ),
                      child: Text(
                        cubit.onboardingData.highlight,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.007),
                    Container(
                      padding: EdgeInsets.only(
                        left: screenWidth * 0.1,
                        right: screenWidth * 0.1,
                      ),
                      child: Text(
                        cubit.onboardingData.description,
                        style: TextStyle(fontSize: 14, color: AppColors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.035),
                    Image.asset(cubit.onboardingData.stagePath),
                    SizedBox(height: screenHeight * 0.035),
                    InkWell(
                      onTap: () {
                        cubit.getOnbourdingData();
                      },
                      child: Container(
                        width: screenWidth * 0.9,
                        height: screenHeight * 0.075,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.purple,
                        ),
                        child: Center(
                          child: Text(
                            cubit.onboardingData.buttunText,
                            style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Container(
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.075,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.white,
                      ),
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            Get.to(LogInScreen());
                          },
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                              color: AppColors.purple,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ));
  }

  void getOnBourding() {
    count++;
    if (count == 1) {
      highlight = 'Your Bookish Soulmate Awaits';
      description =
          'Let us be your guide to the perfect read. Discover books tailored to your tastes for a truly rewarding experience.';
      imagePath = 'assets/Frame (1).png';
      stagePath = 'assets/Auto Layout Horizontal (1).png';
      buttunText = 'Get Started';
    } else if (count == 2) {
      highlight = 'Start Your Adventure';
      description =
          'Ready to embark on a quest for inspiration and knowledge? Your adventure begins now. Let\'s go!';
      imagePath = 'assets/Frame (2).png';
      stagePath = 'assets/Auto Layout Horizontal (2).png';
      buttunText = 'Get Started';
    } else if (count >= 3) {
      Get.to(LogInScreen());
    }
    setState(() {});
  }
}
