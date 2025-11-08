import 'package:books/core/colors/colors.dart';
import 'package:books/features/authentication_feature/data/user_model.dart';
import 'package:books/features/home_feature/presentation/views/home_screen.dart';
import 'package:books/features/authentication_feature/presentation/views/login_screen.dart';
import 'package:books/features/authentication_feature/presentation/views/success_screen.dart';
import 'package:books/features/authentication_feature/presentation/views/widgets/custom_password_field_with_validate.dart';
import 'package:books/features/authentication_feature/presentation/views/widgets/email_text_field.dart';
import 'package:books/features/authentication_feature/presentation/views/widgets/name_text_field.dart';
import 'package:books/features/authentication_feature/presentation/views/widgets/phone_text_field.dart';
import 'package:books/features/authentication_feature/presentation/views/widgets/rounded_purple_button.dart';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

TextEditingController phoneNumber = TextEditingController();

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<PhoneScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.sizeOf(context).height;
    final double screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 48, left: 24, right: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(Icons.arrow_back, size: 24),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 47.0),
                  child: Text(
                    'Phone Number',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: screenHeight * 0.002),
                Text(
                  'Please enter your phone number, so we can more easily deliver your order',
                  style: TextStyle(fontSize: 16, color: AppColors.grey),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.05),
                PhoneTextField(enteredNumber: phoneNumber),
                SizedBox(height: screenHeight * 0.05),
                Purplebuttun(
                  buttunText: 'Continue',
                  onTapFunction: () {
                    if (phoneNumber.text.length == 11) {
                      setState(() {
                        UserModel.user.phone = phoneNumber.text;
                      });
                      Get.off(SuccessScreen());
                    } else {
                      Get.snackbar(
                        'Error',
                        'phone number is not correct',
                        backgroundColor: AppColors.purple,
                        colorText: AppColors.white,
                      );
                    }
                    print('=====================================');
                    print(UserModel.user.phone);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//-------------------------------------------------------------------------------
