import 'package:books/colors/colors.dart';
import 'package:books/models/user_model.dart';
import 'package:books/screens/home_screen.dart';
import 'package:books/services/firestore_services.dart';
import 'package:books/widgets/rounded_purple_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.sizeOf(context).height;
    final double screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 48, left: 24, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/Group.png'),
              SizedBox(height: screenHeight * 0.04),
              Text(
                'Congratulation!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: screenHeight * 0.002),
              Text(
                'your account is complete, please enjoy the best menu from us.',
                style: TextStyle(fontSize: 18, color: AppColors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.04),
              Purplebuttun(
                buttunText: 'Get Started',
                onTapFunction: () {
                  FirestoreServices.addUser(UserModel.user.toJson());
                  Get.to(HomeScreen());
                  //get data from json
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
