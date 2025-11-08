import 'package:books/core/colors/colors.dart';
import 'package:books/features/authentication_feature/presentation/manager/login_cubit.dart';
import 'package:books/features/authentication_feature/presentation/manager/login_state.dart';
import 'package:books/features/authentication_feature/data/user_model.dart';
import 'package:books/features/home_feature/presentation/views/home_screen.dart';
import 'package:books/features/authentication_feature/presentation/views/signup_screen.dart';
import 'package:books/features/authentication_feature/presentation/views/widgets/email_text_field.dart';
import 'package:books/features/authentication_feature/presentation/views/widgets/password_text_field.dart';
import 'package:books/features/authentication_feature/presentation/views/widgets/rounded_purple_button.dart';
import 'package:books/features/authentication_feature/presentation/views/widgets/rounded_white_button.dart';
import 'package:books/l10n/app_localizations.dart';
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
              AppLocalizations.of(context)!.success,
              AppLocalizations.of(context)!.login_is_done_successfully,
              backgroundColor: AppColors.purple,
              colorText: AppColors.white,
            );
            Get.to(HomeScreen());
          } else if (state is LoginErrorState) {
            Get.snackbar(
              AppLocalizations.of(context)!.error,
              AppLocalizations.of(context)!.login_failed,
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
                                AppLocalizations.of(context)!.welcome_back,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.002),
                              Text(
                                AppLocalizations.of(context)!
                                    .sign_to_your_account,
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
                            buttunText: AppLocalizations.of(context)!.login,
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
                            AppLocalizations.of(context)!.dont_have_account,
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
                              AppLocalizations.of(context)!.sign_up,
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
                            AppLocalizations.of(context)!.or_with,
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
                              buttunText: AppLocalizations.of(context)!
                                  .sign_in_with_google,
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
