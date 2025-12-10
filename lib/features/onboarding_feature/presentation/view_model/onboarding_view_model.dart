import 'package:books/core/base/view_state.dart';
import 'package:books/features/onboarding_feature/data/hive_helper.dart';
import 'package:books/features/onboarding_feature/data/onboarding_data_model.dart';
import 'package:books/features/onboarding_feature/presentation/view_model/onboarding_state.dart';
import 'package:books/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingViewModel extends Cubit<OnboardingState> {
  OnboardingViewModel() : super(OnboardingState.initial());

  static const int _totalSteps = 3;
  bool _initialized = false;

  void initialize(AppLocalizations? localizations) {
    if (_initialized || localizations == null) return;
    _initialized = true;
    final data = _getLocalizedData(localizations, 0);
    emit(
      state.copyWith(
        status: ViewStatus.success,
        data: data,
        currentIndex: 0,
        totalSteps: _totalSteps,
        shouldNavigateToLogin: false,
        message: null,
        resetMessage: true,
      ),
    );
  }

  void refreshLocalizedData(AppLocalizations? localizations) {
    if (localizations == null || !_initialized) return;
    final data = _getLocalizedData(localizations, state.currentIndex);
    emit(
      state.copyWith(
        data: data,
        status: ViewStatus.success,
        shouldNavigateToLogin: false,
        resetMessage: true,
      ),
    );
  }

  Future<void> skipOnboarding() async {
    await HiveHelper.changeShowOnboardingState();
    emit(
      state.copyWith(
        status: ViewStatus.success,
        shouldNavigateToLogin: true,
        resetMessage: true,
      ),
    );
  }

  Future<void> nextStep(AppLocalizations? localizations) async {
    if (localizations == null) return;
    final nextIndex = state.currentIndex + 1;

    if (nextIndex >= _totalSteps) {
      await HiveHelper.changeShowOnboardingState();
      emit(
        state.copyWith(
          status: ViewStatus.success,
          shouldNavigateToLogin: true,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: ViewStatus.loading,
        shouldNavigateToLogin: false,
        message: null,
        resetMessage: true,
      ),
    );

    final data = _getLocalizedData(localizations, nextIndex);
    emit(
      state.copyWith(
        status: ViewStatus.success,
        data: data,
        currentIndex: nextIndex,
        totalSteps: _totalSteps,
        shouldNavigateToLogin: false,
        resetMessage: true,
      ),
    );
  }

  OnboardingData _getLocalizedData(AppLocalizations localizations, int index) {
    switch (index) {
      case 0:
        return OnboardingData(
          highlight: localizations.onboarding_title_1,
          description: localizations.onboarding_desc_1,
          imagePath: 'assets/images/onboarding/onboarding_frame.png',
          stagePath: 'assets/images/onboarding/auto_layout_horizontal.png',
          buttonText: localizations.continuee,
        );
      case 1:
        return OnboardingData(
          highlight: localizations.onboarding_title_2,
          description: localizations.onboarding_desc_2,
          imagePath: 'assets/images/onboarding/onboarding_frame_1.png',
          stagePath: 'assets/images/onboarding/auto_layout_horizontal_1.png',
          buttonText: localizations.get_started,
        );
      case 2:
      default:
        return OnboardingData(
          highlight: localizations.onboarding_title_3,
          description: localizations.onboarding_desc_3,
          imagePath: 'assets/images/onboarding/onboarding_frame_2.png',
          stagePath: 'assets/images/onboarding/auto_layout_horizontal_2.png',
          buttonText: localizations.get_started,
        );
    }
  }
}
