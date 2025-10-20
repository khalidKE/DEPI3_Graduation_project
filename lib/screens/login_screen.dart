import 'package:books/colors/colors.dart';
import 'package:books/cubits/login_cubit.dart';
import 'package:books/cubits/login_state.dart';
import 'package:books/models/user_model.dart';
import 'package:books/screens/home_screen.dart';
import 'package:books/screens/signup_screen.dart';
import 'package:books/widgets/email_text_field.dart';
import 'package:books/widgets/password_text_field.dart';
import 'package:books/widgets/rounded_purple_button.dart';
import 'package:books/widgets/rounded_white_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

TextEditingController loginPassword = TextEditingController();
TextEditingController loginEmail = TextEditingController();

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKeyLogin = GlobalKey<FormState>();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.sizeOf(context).height;
    final double screenWidth = MediaQuery.sizeOf(context).width;
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Get.snackbar(
              'Success',
              'login is done successfully',
              backgroundColor: AppColors.purple,
              colorText: AppColors.white,
            );
            Get.to(HomeScreen());
          } else if (state is LoginErrorState) {
            Get.snackbar(
              'Error',
              'login failed',
              backgroundColor: AppColors.purple,
              colorText: AppColors.white,
            );
          }
          // TODO: implement listener
        },
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 48, left: 24, right: 24),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKeyLogin,
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
                                'Welcome Back 👋',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.002),
                              Text(
                                'sign to your account',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: AppColors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.08),
                      Emailtextfield(enteredEmail: loginEmail),
                      SizedBox(height: screenHeight * 0.015),
                      Passwordtextfield(
                        enteredPassword: loginPassword,
                        validation: loginValidation,
                      ),
                      SizedBox(height: screenHeight * 0.005),

                      SizedBox(height: screenHeight * 0.03),
                      BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                          final cubit = context.read<LoginCubit>();
                          if (state is LoginLoadingState) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return Purplebuttun(
                            buttunText: 'Login',
                            onTapFunction: () {
                              _formKeyLogin.currentState!.validate();
                              setState(() {
                                UserModel.user.email = loginEmail.text;
                                UserModel.user.password = loginPassword.text;
                              });

                              cubit.loginWithFirebase(UserModel.user);

                              setState(() {});
                            },
                          );
                        },
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                            style: TextStyle(
                              color: AppColors.grey,
                              fontSize: 16,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(SignUpScreen());
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: AppColors.purple,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: AppColors.lightGray,
                              ),
                              height: 2,
                            ),
                          ),
                          Text(
                            'Or with',
                            style: TextStyle(color: AppColors.grey),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: AppColors.lightGray,
                              ),
                              height: 2,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      Center(
                        child: BlocBuilder<LoginCubit, LoginState>(
                          builder: (context, state) {
                            final cubit = context.read<LoginCubit>();
                            return Whitebuttun(
                              buttunText: 'Sign in with Google',
                              ontapFunction: () {
                                cubit.signInWithGoogleFirebase();
                              },
                              imagepath: 'assets/Google - Original.png',
                            );
                          },
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.012),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String? loginValidation(value) {
  if (value!.length < 6) return ('password should be more that 5 digits');
}

//-------------------------------------------------------------------------------
