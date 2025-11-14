import 'package:books/core/colors/colors.dart';
import 'package:books/features/authentication_feature/data/user_model.dart';
import 'package:books/features/home_feature/presentation/views/home_screen.dart';
import 'package:books/l10n/app_localizations.dart';
import 'package:books/services/firestore_services.dart';
import 'package:books/features/authentication_feature/presentation/views/widgets/rounded_purple_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.sizeOf(context).height;
    final double screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 48, left: 24, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/Group.png'),
              SizedBox(height: screenHeight * 0.04),
              Text(
                AppLocalizations.of(context)!.congratulation,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: screenHeight * 0.002),
              Text(
                AppLocalizations.of(context)!.your_account_is_complete,
                style: TextStyle(fontSize: 18, color: AppColors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.04),
              Purplebuttun(
                buttunText: AppLocalizations.of(context)!.get_Started,
                onTapFunction: () {
                  FirestoreServices.addUser(UserModel.user.toJson());
                  Get.to(HomeScreen());
                  //get data from json
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
