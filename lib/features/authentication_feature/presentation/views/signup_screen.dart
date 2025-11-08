import 'package:books/core/colors/colors.dart';
import 'package:books/features/authentication_feature/presentation/manager/login_cubit.dart';
import 'package:books/features/authentication_feature/presentation/manager/login_state.dart';
import 'package:books/features/authentication_feature/presentation/manager/signup_cubit.dart';
import 'package:books/features/authentication_feature/presentation/manager/signup_state.dart';
import 'package:books/features/authentication_feature/data/user_model.dart';
import 'package:books/features/authentication_feature/presentation/views/login_screen.dart';
import 'package:books/features/authentication_feature/presentation/views/phone_number_screen.dart';
import 'package:books/features/authentication_feature/presentation/views/widgets/custom_password_field_with_validate.dart';
import 'package:books/features/authentication_feature/presentation/views/widgets/email_text_field.dart';
import 'package:books/features/authentication_feature/presentation/views/widgets/name_text_field.dart';
import 'package:books/features/authentication_feature/presentation/views/widgets/password_text_field.dart';
import 'package:books/features/authentication_feature/presentation/views/widgets/rounded_purple_button.dart';
import 'package:books/features/authentication_feature/presentation/views/widgets/rounded_white_button.dart';
import 'package:books/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:fancy_password_field/fancy_password_field.dart';

TextEditingController signupPassword = TextEditingController();
TextEditingController signupEmail = TextEditingController();
TextEditingController signupName = TextEditingController();

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<SignUpScreen> {
  final _formKeySignup = GlobalKey<FormState>();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.sizeOf(context).height;
    final double screenWidth = MediaQuery.sizeOf(context).width;
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: BlocListener<SignupCubit, signupState>(
        listener: (context, state) {
          if (state is signupSuccessState) {
            Get.snackbar(
              AppLocalizations.of(context)!.success,
              AppLocalizations.of(context)!.signup_is_done_successfully,
              backgroundColor: AppColors.purple,
              colorText: AppColors.white,
            );
            Get.off(PhoneScreen());
          } else if (state is signupErrorState) {
            Get.snackbar(
              AppLocalizations.of(context)!.error,
              AppLocalizations.of(context)!.signup_failed,
              backgroundColor: AppColors.purple,
              colorText: AppColors.white,
            );
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 48, left: 24, right: 24),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKeySignup,
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
                                AppLocalizations.of(context)!.sign_up,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.002),
                              Text(
                                AppLocalizations.of(context)!
                                    .create_account_and_choose_favorite_menu,
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
                      NameTextField(enteredName: signupName),
                      SizedBox(height: screenHeight * 0.015),
                      Emailtextfield(enteredEmail: signupEmail),
                      SizedBox(height: screenHeight * 0.015),
                      customPasswordFieldWithValidate(
                        enteredPassword: signupPassword,
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      BlocBuilder<SignupCubit, signupState>(
                        builder: (context, state) {
                          final cubit = context.read<SignupCubit>();
                          if (state is LoginLoadingState) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return Purplebuttun(
                            buttunText: AppLocalizations.of(context)!.sign_up,
                            onTapFunction: () {
                              _formKeySignup.currentState!.validate();
                              setState(() {
                                UserModel.user.name = signupName.text;
                                UserModel.user.email = signupEmail.text;
                                UserModel.user.password = signupPassword.text;
                              });
                              cubit.signupWithFirebase(UserModel.user);
                              setState(() {});
                            },
                          );
                        },
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.have_an_account,
                            style: TextStyle(
                              color: AppColors.grey,
                              fontSize: 16,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.off(LogInScreen());
                            },
                            child: Text(
                              AppLocalizations.of(context)!.sign_In,
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
                              AppLocalizations.of(context)!
                                  .by_clicking_Register_you_agree_to_our,
                              style: TextStyle(
                                color: AppColors.grey,
                                fontSize: 16,
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Text(
                                AppLocalizations.of(context)!
                                    .terms_and_Data_Policy,
                                style: TextStyle(
                                  color: AppColors.purple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
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
        ),
      ),
    );
  }
}

//-------------------------------------------------------------------------------
