import 'package:books/features/onboarding_feature/data/onboarding_data.dart';
import 'package:books/features/onboarding_feature/presentation/manager/onboarding_state.dart';
import 'package:books/features/onboarding_feature/data/onboarding_data_model.dart';
import 'package:books/features/authentication_feature/presentation/views/login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(onboardingInitialState());
  int count = 0;
  OnboardingData onboardingData = OnboardingData.getData(onboardingDataList[0]);
  void getOnbourdingData() {
    count++;
    emit(onboardingLoadingState());
    if (count == 1) {
      emit(onboardingSecondState());
      onboardingData = OnboardingData.getData(onboardingDataList[1]);
    } else if (count == 2) {
      emit(onboardingThirdState());
      onboardingData = OnboardingData.getData(onboardingDataList[2]);
    } else if (count >= 3) {
      emit(onboardingGetToLogin());
      Get.to(LogInScreen());
    }
  }
}
