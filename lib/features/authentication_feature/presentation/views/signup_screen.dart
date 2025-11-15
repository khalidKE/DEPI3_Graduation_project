import 'package:books/core/colors/colors.dart';
import 'package:books/core/utils/responsive.dart';
import 'package:books/core/widgets/language_toggle.dart';
import 'package:books/features/authentication_feature/presentation/manager/signup_cubit.dart';
import 'package:books/features/authentication_feature/presentation/manager/signup_state.dart';
import 'package:books/features/authentication_feature/data/user_model.dart';
import 'package:books/features/authentication_feature/presentation/views/login_screen.dart';
import 'package:books/features/authentication_feature/presentation/views/phone_number_screen.dart';
import 'package:books/features/authentication_feature/presentation/views/widgets/custom_password_field_with_validate.dart';
import 'package:books/features/authentication_feature/presentation/views/widgets/email_text_field.dart';
import 'package:books/features/authentication_feature/presentation/views/widgets/name_text_field.dart';
import 'package:books/features/authentication_feature/presentation/views/widgets/rounded_purple_button.dart';
import 'package:books/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKeySignup = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: BlocListener<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state is SignupSuccessState) {
            Get.snackbar(
              AppLocalizations.of(context)!.success,
              AppLocalizations.of(context)!.signup_is_done_successfully,
              backgroundColor: AppColors.purple,
              colorText: AppColors.white,
            );
            Get.off(() => const PhoneScreen());
          } else if (state is SignupErrorState) {
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
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: const [
              LanguageToggleButton(),
            ],
          ),
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final maxWidth = Responsive.maxContentWidth(context);
                return Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: maxWidth ?? 600,
                    ),
                    child: SingleChildScrollView(
                      padding: Responsive.responsivePadding(context).copyWith(
                        top: Responsive.responsiveSpacing(context, 20),
                      ),
                      child: Form(
                        key: _formKeySignup,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(
                                Icons.arrow_back,
                                size: Responsive.responsiveIconSize(context, 24),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                top: Responsive.responsiveSpacing(context, 40),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.sign_up,
                                    style: TextStyle(
                                      fontSize: Responsive.responsiveFontSize(context, 28),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: Responsive.responsiveSpacing(context, 2)),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .create_account_and_choose_favorite_menu,
                                    style: TextStyle(
                                      fontSize: Responsive.responsiveFontSize(context, 18),
                                      color: AppColors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: Responsive.responsiveSpacing(context, 30)),
                            NameTextField(enteredName: _nameController),
                            SizedBox(height: Responsive.responsiveSpacing(context, 15)),
                            EmailTextField(enteredEmail: _emailController),
                            SizedBox(height: Responsive.responsiveSpacing(context, 15)),
                            CustomPasswordFieldWithValidate(
                              enteredPassword: _passwordController,
                            ),
                            SizedBox(height: Responsive.responsiveSpacing(context, 30)),
                            BlocBuilder<SignupCubit, SignupState>(
                              builder: (context, state) {
                                final cubit = context.read<SignupCubit>();
                                if (state is SignupLoadingState) {
                                  return const Center(child: CircularProgressIndicator());
                                }
                                return PurpleButton(
                                  buttonText: AppLocalizations.of(context)!.sign_up,
                                  onTapFunction: () {
                                    if (_formKeySignup.currentState!.validate()) {
                                      UserModel.user.name = _nameController.text;
                                      UserModel.user.email = _emailController.text;
                                      UserModel.user.password = _passwordController.text;
                                      cubit.signupWithFirebase(UserModel.user);
                                    }
                                  },
                                );
                              },
                            ),
                            SizedBox(height: Responsive.responsiveSpacing(context, 15)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.have_an_account,
                                  style: TextStyle(
                                    color: AppColors.grey,
                                    fontSize: Responsive.responsiveFontSize(context, 16),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.off(() => const LogInScreen());
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.sign_In,
                                    style: TextStyle(
                                      color: AppColors.purple,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Responsive.responsiveFontSize(context, 17),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Responsive.responsiveSpacing(context, 40)),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .by_clicking_Register_you_agree_to_our,
                                    style: TextStyle(
                                      color: AppColors.grey,
                                      fontSize: Responsive.responsiveFontSize(context, 16),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .terms_and_Data_Policy,
                                      style: TextStyle(
                                        color: AppColors.purple,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Responsive.responsiveFontSize(context, 16),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: Responsive.responsiveSpacing(context, 20)),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

//-------------------------------------------------------------------------------
