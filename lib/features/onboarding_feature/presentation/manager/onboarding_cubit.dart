import 'package:books/features/onboarding_feature/presentation/manager/onboarding_state.dart';
import 'package:books/features/onboarding_feature/data/onboarding_data_model.dart';
import 'package:books/features/authentication_feature/presentation/views/login_screen.dart';
import 'package:books/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(onboardingInitialState());
  int count = 0;
  OnboardingData onboardingData = OnboardingData();
  
  void initialize(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    if (localizations != null) {
      onboardingData = _getLocalizedData(localizations, 0);
    } else {
      // If localizations are not available, initialize with empty data
      onboardingData = OnboardingData();
    }
  }
  
  OnboardingData _getLocalizedData(AppLocalizations localizations, int index) {
    final data = OnboardingData();
    switch (index) {
      case 0:
        data.highlight = localizations.onboarding_title_1;
        data.description = localizations.onboarding_desc_1;
        data.imagePath = 'assets/Frame.png';
        data.stagePath = 'assets/Auto Layout Horizontal.png';
        data.buttunText = localizations.continuee;
        break;
      case 1:
        data.highlight = localizations.onboarding_title_2;
        data.description = localizations.onboarding_desc_2;
        data.imagePath = 'assets/Frame (1).png';
        data.stagePath = 'assets/Auto Layout Horizontal (1).png';
        data.buttunText = localizations.get_started;
        break;
      case 2:
        data.highlight = localizations.onboarding_title_3;
        data.description = localizations.onboarding_desc_3;
        data.imagePath = 'assets/Frame (2).png';
        data.stagePath = 'assets/Auto Layout Horizontal (2).png';
        data.buttunText = localizations.get_started;
        break;
    }
    return data;
  }
  
  /// Update localized data for the current page
  void updateLocalizedData(AppLocalizations localizations, int index) {
    onboardingData = _getLocalizedData(localizations, index);
    // Emit current state to trigger rebuild
    if (count == 0) {
      emit(onboardingInitialState());
    } else if (count == 1) {
      emit(onboardingSecondState());
    } else if (count == 2) {
      emit(onboardingThirdState());
    }
  }
  
  void getOnbourdingData(BuildContext context) {
    count++;
    emit(onboardingLoadingState());
    final localizations = AppLocalizations.of(context);
    if (localizations != null) {
      if (count == 1) {
        emit(onboardingSecondState());
        onboardingData = _getLocalizedData(localizations, 1);
      } else if (count == 2) {
        emit(onboardingThirdState());
        onboardingData = _getLocalizedData(localizations, 2);
      } else if (count >= 3) {
        emit(onboardingGetToLogin());
        Get.to(() => const LogInScreen());
      }
    }
  }
}
