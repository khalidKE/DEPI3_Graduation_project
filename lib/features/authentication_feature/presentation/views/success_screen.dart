import 'package:books/core/colors/colors.dart';
import 'package:books/core/utils/responsive.dart';
import 'package:books/core/widgets/language_toggle.dart';
import 'package:books/features/authentication_feature/data/user_model.dart';
import 'package:books/features/home_feature/presentation/views/home_screen.dart';
import 'package:books/l10n/app_localizations.dart';
import 'package:books/services/firestore_services.dart';
import 'package:books/features/authentication_feature/presentation/views/widgets/rounded_purple_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: Padding(
                  padding: Responsive.responsivePadding(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/auth/success_group.png',
                        width: Responsive.responsiveImageSize(context, 200),
                        height: Responsive.responsiveImageSize(context, 200),
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: Responsive.responsiveSpacing(context, 30)),
                      Text(
                        AppLocalizations.of(context)!.congratulation,
                        style: TextStyle(
                          fontSize: Responsive.responsiveFontSize(context, 28),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: Responsive.responsiveSpacing(context, 8)),
                      Text(
                        AppLocalizations.of(context)!.your_account_is_complete,
                        style: TextStyle(
                          fontSize: Responsive.responsiveFontSize(context, 18),
                          color: AppColors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: Responsive.responsiveSpacing(context, 40)),
                      PurpleButton(
                        buttonText: AppLocalizations.of(context)!.get_Started,
                        onTapFunction: () async {
                          final localizations = AppLocalizations.of(context);
                          try {
                            await FirestoreServices.addUser(user);
                            Get.to(() => const HomeScreen());
                          } catch (e) {
                            Get.snackbar(
                              localizations?.error ?? 'Error',
                              localizations?.signup_failed ??
                                  'Could not complete signup',
                              backgroundColor: AppColors.purple,
                              colorText: AppColors.white,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
