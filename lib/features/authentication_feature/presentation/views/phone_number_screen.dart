import 'package:books/core/colors/colors.dart';
import 'package:books/core/utils/responsive.dart';
import 'package:books/core/widgets/language_toggle.dart';
import 'package:books/features/authentication_feature/data/user_model.dart';
import 'package:books/features/authentication_feature/presentation/views/success_screen.dart';
import 'package:books/features/authentication_feature/presentation/views/widgets/phone_text_field.dart';
import 'package:books/features/authentication_feature/presentation/views/widgets/rounded_purple_button.dart';
import 'package:books/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: Responsive.responsiveIconSize(context, 24),
          ),
          onPressed: () => Get.back(),
        ),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: Responsive.responsiveSpacing(context, 20),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.phone_number,
                          style: TextStyle(
                            fontSize: Responsive.responsiveFontSize(context, 28),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: Responsive.responsiveSpacing(context, 8)),
                      Text(
                        AppLocalizations.of(context)!.please_enter_your_phone_number,
                        style: TextStyle(
                          fontSize: Responsive.responsiveFontSize(context, 16),
                          color: AppColors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: Responsive.responsiveSpacing(context, 30)),
                      PhoneTextField(enteredNumber: _phoneNumberController),
                      SizedBox(height: Responsive.responsiveSpacing(context, 30)),
                      PurpleButton(
                        buttonText: AppLocalizations.of(context)!.continuee,
                        onTapFunction: () {
                          if (_phoneNumberController.text.length == 11) {
                            UserModel.user.phone = _phoneNumberController.text;
                            Get.off(() => const SuccessScreen());
                          } else {
                            Get.snackbar(
                              AppLocalizations.of(context)!.error,
                              AppLocalizations.of(context)!
                                  .phone_number_is_not_correct,
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

//-------------------------------------------------------------------------------
