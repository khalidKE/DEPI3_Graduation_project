import 'package:books/colors/colors.dart';
import 'package:books/cubits/login_cubit.dart';
import 'package:books/cubits/login_state.dart';
import 'package:books/models/user_model.dart';
import 'package:books/screens/login_screen.dart';
import 'package:books/widgets/email_text_field.dart';
import 'package:books/widgets/name_text_field.dart';
import 'package:books/widgets/password_text_field.dart';
import 'package:books/widgets/rounded_purple_button.dart';
import 'package:books/widgets/rounded_white_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool obscureText = true;

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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back, size: 24),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 40),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.002),
                          Text(
                            'Create account and choose favorite menu',
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  NameTextField(),
                  SizedBox(height: screenHeight * 0.015),
                  Emailtextfield(),
                  SizedBox(height: screenHeight * 0.015),
                  Passwordtextfield(),
                  SizedBox(height: screenHeight * 0.05),
                  Purplebuttun(buttunText: 'Sign Up', onTapFunction: () {}),

                  SizedBox(height: screenHeight * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Have an account? ',
                        style: TextStyle(color: AppColors.grey, fontSize: 16),
                      ),
                      InkWell(
                        onTap: () {
                          Get.off(LogInScreen());
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            color: AppColors.purple,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.08),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'By clicking Register, you agree to our  ',
                          style: TextStyle(color: AppColors.grey, fontSize: 16),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            'Terms and Data Policy.',
                            style: TextStyle(
                              color: AppColors.purple,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//-------------------------------------------------------------------------------
