import 'package:books/core/colors/colors.dart';
import 'package:books/core/utils/error_handler.dart';
import 'package:books/core/utils/responsive.dart';
import 'package:books/core/widgets/language_toggle.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKeyLogin = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            ErrorHandler.showSuccessSnackBar(
              context,
              AppLocalizations.of(context)!.login_is_done_successfully,
            );
            Get.to(() => const HomeScreen());
          } else if (state is LoginErrorState) {
            final errorMessage = state.error != null
                ? ErrorHandler.getAuthErrorMessage(context, state.error)
                : AppLocalizations.of(context)!.login_failed;
            ErrorHandler.showErrorSnackBar(context, errorMessage);
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
                        key: _formKeyLogin,
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
                                    AppLocalizations.of(context)!.welcome_back,
                                    style: TextStyle(
                                      fontSize: Responsive.responsiveFontSize(context, 28),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: Responsive.responsiveSpacing(context, 2)),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .sign_to_your_account,
                                    style: TextStyle(
                                      fontSize: Responsive.responsiveFontSize(context, 18),
                                      color: AppColors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: Responsive.responsiveSpacing(context, 40)),
                            EmailTextField(enteredEmail: _emailController),
                            SizedBox(height: Responsive.responsiveSpacing(context, 15)),
                            PasswordTextField(
                              enteredPassword: _passwordController,
                              validation: loginValidation,
                            ),
                            SizedBox(height: Responsive.responsiveSpacing(context, 35)),
                            BlocBuilder<LoginCubit, LoginState>(
                              builder: (context, state) {
                                final cubit = context.read<LoginCubit>();
                                if (state is LoginLoadingState) {
                                  return const Center(child: CircularProgressIndicator());
                                }
                                return PurpleButton(
                                  buttonText: AppLocalizations.of(context)!.login,
                                  onTapFunction: () {
                                    if (_formKeyLogin.currentState!.validate()) {
                                      UserModel.user.email = _emailController.text;
                                      UserModel.user.password = _passwordController.text;
                                      cubit.loginWithFirebase(UserModel.user);
                                    }
                                  },
                                );
                              },
                            ),
                            SizedBox(height: Responsive.responsiveSpacing(context, 30)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.dont_have_account,
                                  style: TextStyle(
                                    color: AppColors.grey,
                                    fontSize: Responsive.responsiveFontSize(context, 16),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(() => const SignUpScreen());
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.sign_up,
                                    style: TextStyle(
                                      color: AppColors.purple,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Responsive.responsiveFontSize(context, 17),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Responsive.responsiveSpacing(context, 30)),
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
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    AppLocalizations.of(context)!.or_with,
                                    style: TextStyle(color: AppColors.grey),
                                  ),
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
                            SizedBox(height: Responsive.responsiveSpacing(context, 30)),
                            Center(
                              child: BlocBuilder<LoginCubit, LoginState>(
                                builder: (context, state) {
                                  final cubit = context.read<LoginCubit>();
                                  return WhiteButton(
                                    buttonText: AppLocalizations.of(context)!
                                        .sign_in_with_google,
                                    onTapFunction: () {
                                      cubit.signInWithGoogleFirebase();
                                    },
                                    imagePath: 'assets/Google - Original.png',
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: Responsive.responsiveSpacing(context, 12)),
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

String? loginValidation(value) {
  if (value!.length < 6) return ('password should be more that 5 digits');
  return null;
}

//-------------------------------------------------------------------------------
