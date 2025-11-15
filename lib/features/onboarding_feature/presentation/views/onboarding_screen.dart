import 'package:books/core/colors/colors.dart';
import 'package:books/core/utils/responsive.dart';
import 'package:books/core/services/language_service.dart';
import 'package:books/features/onboarding_feature/presentation/manager/onboarding_cubit.dart';
import 'package:books/features/onboarding_feature/presentation/manager/onboarding_state.dart';
import 'package:books/features/authentication_feature/presentation/views/login_screen.dart';
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
        create: (context) {
          final cubit = OnboardingCubit();
          // Initialize after the widget tree is built
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              cubit.initialize(context);
            }
          });
          return cubit;
        },
        child: ValueListenableBuilder<Locale>(
            valueListenable: LanguageService.localeNotifier,
            builder: (context, currentLocale, child) {
              return BlocConsumer<OnboardingCubit, OnboardingState>(
                key: ValueKey(currentLocale.languageCode),
                listener: (context, state) {
                  if (state is onboardingGetToLogin) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted) {
                        Get.offAll(() => const LogInScreen());
                      }
                    });
                  }
                },
                builder: (context, state) {
                  return BlocBuilder<OnboardingCubit, OnboardingState>(
                    builder: (context, state) {
                      final cubit = context.watch<OnboardingCubit>();

                      // Update onboarding data when locale changes
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (!mounted) return;
                        try {
                          final localizations = AppLocalizations.of(context);
                          if (localizations != null && context.mounted) {
                            final currentCubit =
                                context.read<OnboardingCubit>();
                            final currentIndex = currentCubit.count;
                            if (currentIndex >= 0 && currentIndex <= 2) {
                              // Update localized data for current page
                              currentCubit.updateLocalizedData(
                                  localizations, currentIndex);
                            }
                          }
                        } catch (e) {
                          // Ignore errors if context is invalid
                          debugPrint('Error updating localized data: $e');
                        }
                      });

                      if (state is onboardingLoadingState) {
                        return Center(
                          child: CircularProgressIndicator(
                              color: AppColors.purple),
                        );
                      }

                      // Ensure onboardingData is initialized
                      if (cubit.onboardingData.highlight.isEmpty) {
                        return Center(
                          child: CircularProgressIndicator(
                              color: AppColors.purple),
                        );
                      }
                      return Scaffold(
                        backgroundColor: AppColors.white,
                        body: SafeArea(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final maxWidth =
                                  Responsive.maxContentWidth(context);
                              return Center(
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: maxWidth ?? double.infinity,
                                  ),
                                  child: SingleChildScrollView(
                                    padding:
                                        Responsive.responsivePadding(context),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Get.to(
                                                    () => const LogInScreen());
                                              },
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .skip,
                                                style: TextStyle(
                                                  color: AppColors.purple,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Responsive.responsiveSpacing(
                                              context, 20),
                                        ),
                                        Image.asset(
                                          cubit.onboardingData.imagePath,
                                          height:
                                              Responsive.responsiveImageSize(
                                                  context, 280),
                                          width: Responsive.responsiveImageSize(
                                              context, 280),
                                          fit: BoxFit.contain,
                                        ),
                                        SizedBox(
                                          height: Responsive.responsiveSpacing(
                                              context, 10),
                                        ),
                                        Padding(
                                          padding: Responsive.responsivePadding(
                                              context),
                                          child: Text(
                                            cubit.onboardingData.highlight,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  Responsive.responsiveFontSize(
                                                      context, 24),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        SizedBox(
                                          height: Responsive.responsiveSpacing(
                                              context, 8),
                                        ),
                                        Padding(
                                          padding: Responsive.responsivePadding(
                                              context),
                                          child: Text(
                                            cubit.onboardingData.description,
                                            style: TextStyle(
                                              fontSize:
                                                  Responsive.responsiveFontSize(
                                                      context, 14),
                                              color: AppColors.grey,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        SizedBox(
                                          height: Responsive.responsiveSpacing(
                                              context, 30),
                                        ),
                                        // Pagination indicators (dots)
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: List.generate(3, (index) {
                                            final isActive = cubit.count == index;
                                            return AnimatedContainer(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.easeInOut,
                                              margin: EdgeInsets.symmetric(
                                                horizontal: Responsive
                                                    .responsiveSpacing(context, 4),
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
                                          height: Responsive.responsiveSpacing(
                                              context, 30),
                                        ),
                                        ConstrainedBox(
                                          constraints: const BoxConstraints(
                                              maxWidth: 400),
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                cubit
                                                    .getOnbourdingData(context);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    AppColors.purple,
                                                padding: EdgeInsets.symmetric(
                                                  vertical: Responsive
                                                      .responsiveSpacing(
                                                          context, 16),
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    Responsive
                                                        .responsiveBorderRadius(
                                                            context, 12),
                                                  ),
                                                ),
                                              ),
                                              child: Text(
                                                cubit.onboardingData.buttunText,
                                                style: TextStyle(
                                                  color: AppColors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: Responsive
                                                      .responsiveFontSize(
                                                          context, 17),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: Responsive.responsiveSpacing(
                                              context, 16),
                                        ),
                                        ConstrainedBox(
                                          constraints: const BoxConstraints(
                                              maxWidth: 400),
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: OutlinedButton(
                                              onPressed: () {
                                                Get.to(
                                                    () => const LogInScreen());
                                              },
                                              style: OutlinedButton.styleFrom(
                                                side: BorderSide(
                                                    color: AppColors.purple),
                                                padding: EdgeInsets.symmetric(
                                                  vertical: Responsive
                                                      .responsiveSpacing(
                                                          context, 16),
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    Responsive
                                                        .responsiveBorderRadius(
                                                            context, 12),
                                                  ),
                                                ),
                                              ),
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .sign_in,
                                                style: TextStyle(
                                                  color: AppColors.purple,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: Responsive
                                                      .responsiveFontSize(
                                                          context, 17),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: Responsive.responsiveSpacing(
                                              context, 20),
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
              );
            }));
  }
}
