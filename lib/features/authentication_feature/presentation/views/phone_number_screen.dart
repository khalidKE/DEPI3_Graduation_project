import 'package:books/core/colors/colors.dart';
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
    final double screenHeight = MediaQuery.sizeOf(context).height;
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
                    AppLocalizations.of(context)!.phone_number,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: screenHeight * 0.002),
                Text(
                  AppLocalizations.of(context)!.please_enter_your_phone_number,
                  style: TextStyle(fontSize: 16, color: AppColors.grey),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.05),
                PhoneTextField(enteredNumber: _phoneNumberController),
                SizedBox(height: screenHeight * 0.05),
                Purplebuttun(
                  buttunText: AppLocalizations.of(context)!.continuee,
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
      ),
    );
  }
}

//-------------------------------------------------------------------------------
