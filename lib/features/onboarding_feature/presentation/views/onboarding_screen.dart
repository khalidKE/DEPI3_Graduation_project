import 'package:books/core/colors/colors.dart';
import 'package:books/core/services/language_service.dart';
import 'package:books/core/utils/responsive.dart';
import 'package:books/features/authentication_feature/presentation/views/login_screen.dart';
import 'package:books/features/onboarding_feature/presentation/view_model/onboarding_view_model.dart';
import 'package:books/features/onboarding_feature/presentation/view_model/onboarding_state.dart';
import 'package:books/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingViewModel(),
      child: ValueListenableBuilder<Locale>(
        valueListenable: LanguageService.localeNotifier,
        builder: (context, currentLocale, _) {
          final viewModel = context.read<OnboardingViewModel>();
          final localizations = AppLocalizations.of(context);

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;
            viewModel.initialize(localizations);
            viewModel.refreshLocalizedData(localizations);
          });

          return BlocConsumer<OnboardingViewModel, OnboardingState>(
            key: ValueKey(currentLocale.languageCode),
            listener: (context, state) {
              if (state.shouldNavigateToLogin) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    Get.offAll(() => const LogInScreen());
                  }
                });
              }
            },
            builder: (context, state) {
              if (state.isLoading || !state.isReady) {
                return Scaffold(
                  backgroundColor: AppColors.white,
                  body: Center(
                    child: CircularProgressIndicator(color: AppColors.purple),
                  ),
                );
              }

              final data = state.data;

              return Scaffold(
                backgroundColor: AppColors.white,
                body: SafeArea(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final maxWidth = Responsive.maxContentWidth(context);
                      return Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: maxWidth ?? double.infinity,
                          ),
                          child: SingleChildScrollView(
                            padding: Responsive.responsivePadding(context),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        viewModel.skipOnboarding();
                                      },
                                      child: Text(
                                        localizations?.skip ?? 'Skip',
                                        style: TextStyle(
                                          color: AppColors.purple,
                                          fontWeight: FontWeight.bold,
                                          fontSize: Responsive.responsiveFontSize(
                                              context, 15),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Responsive.responsiveSpacing(context, 20),
                                ),
                                Image.asset(
                                  data.imagePath,
                                  height: Responsive.responsiveImageSize(
                                      context, 280),
                                  width: Responsive.responsiveImageSize(
                                      context, 280),
                                  fit: BoxFit.contain,
                                ),
                                SizedBox(
                                  height: Responsive.responsiveSpacing(context, 10),
                                ),
                                Padding(
                                  padding:
                                      Responsive.responsivePadding(context),
                                  child: Text(
                                    data.highlight,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Responsive.responsiveFontSize(
                                          context, 24),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  height: Responsive.responsiveSpacing(context, 8),
                                ),
                                Padding(
                                  padding:
                                      Responsive.responsivePadding(context),
                                  child: Text(
                                    data.description,
                                    style: TextStyle(
                                      fontSize: Responsive.responsiveFontSize(
                                          context, 14),
                                      color: AppColors.grey,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  height: Responsive.responsiveSpacing(context, 30),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(state.totalSteps, (index) {
                                    final isActive =
                                        state.currentIndex == index;
                                    return AnimatedContainer(
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                      margin: EdgeInsets.symmetric(
                                        horizontal: Responsive.responsiveSpacing(
                                            context, 4),
                                      ),
                                      width: Responsive.responsiveSpacing(
                                          context, 8),
                                      height: Responsive.responsiveSpacing(
                                          context, 8),
                                      decoration: BoxDecoration(
                                        color: isActive
                                            ? AppColors.purple
                                            : AppColors.purple
                                                .withValues(alpha: 0.3),
                                        shape: BoxShape.circle,
                                      ),
                                    );
                                  }),
                                ),
                                SizedBox(
                                  height: Responsive.responsiveSpacing(context, 30),
                                ),
                                ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxWidth: 400),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: state.isLoading
                                          ? null
                                          : () {
                                              viewModel
                                                  .nextStep(localizations);
                                            },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.purple,
                                        padding: EdgeInsets.symmetric(
                                          vertical: Responsive.responsiveSpacing(
                                              context, 16),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            Responsive.responsiveBorderRadius(
                                                context, 12),
                                          ),
                                        ),
                                      ),
                                      child: state.isLoading
                                          ? SizedBox(
                                              height: 22,
                                              width: 22,
                                              child: CircularProgressIndicator(
                                                color: AppColors.white,
                                                strokeWidth: 2,
                                              ),
                                            )
                                          : Text(
                                              data.buttonText,
                                              style: TextStyle(
                                                color: AppColors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    Responsive.responsiveFontSize(
                                                        context, 17),
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Responsive.responsiveSpacing(context, 16),
                                ),
                                ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxWidth: 400),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: OutlinedButton(
                                      onPressed: () {
                                        Get.to(() => const LogInScreen());
                                      },
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                            color: AppColors.purple),
                                        padding: EdgeInsets.symmetric(
                                          vertical: Responsive.responsiveSpacing(
                                              context, 16),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            Responsive.responsiveBorderRadius(
                                                context, 12),
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        localizations?.sign_in ?? 'Sign In',
                                        style: TextStyle(
                                          color: AppColors.purple,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              Responsive.responsiveFontSize(
                                                  context, 17),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Responsive.responsiveSpacing(context, 20),
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
            },
          );
        },
      ),
    );
  }
}
