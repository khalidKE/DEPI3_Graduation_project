import 'package:books/core/base/view_state.dart';
import 'package:books/features/onboarding_feature/data/onboarding_data_model.dart';

class OnboardingState {
  final ViewStatus status;
  final OnboardingData data;
  final int currentIndex;
  final int totalSteps;
  final String? message;
  final bool shouldNavigateToLogin;

  const OnboardingState({
    this.status = ViewStatus.idle,
    this.data = const OnboardingData(
      highlight: '',
      description: '',
      imagePath: '',
      stagePath: '',
      buttonText: '',
    ),
    this.currentIndex = 0,
    this.totalSteps = 3,
    this.message,
    this.shouldNavigateToLogin = false,
  });

  factory OnboardingState.initial() => const OnboardingState(
        status: ViewStatus.loading,
        currentIndex: 0,
        totalSteps: 3,
      );

  bool get isReady => data.highlight.isNotEmpty;
  bool get isLoading => status == ViewStatus.loading;
  bool get isLastStep => currentIndex >= totalSteps - 1;

  OnboardingState copyWith({
    ViewStatus? status,
    OnboardingData? data,
    int? currentIndex,
    int? totalSteps,
    String? message,
    bool? shouldNavigateToLogin,
    bool resetMessage = false,
  }) {
    return OnboardingState(
      status: status ?? this.status,
      data: data ?? this.data,
      currentIndex: currentIndex ?? this.currentIndex,
      totalSteps: totalSteps ?? this.totalSteps,
      message: resetMessage ? null : message ?? this.message,
      shouldNavigateToLogin:
          shouldNavigateToLogin ?? this.shouldNavigateToLogin,
    );
  }
}
