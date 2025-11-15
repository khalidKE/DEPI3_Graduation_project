import 'package:books/core/colors/colors.dart';
import 'package:books/l10n/app_localizations.dart';
import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:flutter/material.dart';

class CustomPasswordFieldWithValidate extends StatelessWidget {
  final TextEditingController enteredPassword;
  
  const CustomPasswordFieldWithValidate({
    super.key,
    required this.enteredPassword,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.password,
          style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold),
        ),
        Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 55,
              width: screenWidth,
              margin: EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.lightGray,
              ),
            ),
            FancyPasswordField(
              controller: enteredPassword,
              validationRules: {
                UppercaseValidationRule(),
                LowercaseValidationRule(),
                MinCharactersValidationRule(6),
              },
              validationRuleBuilder: (rules, value) {
                if (value.isEmpty) {
                  return const SizedBox.shrink();
                }
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: rules
                      .map(
                        (rule) => Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                rule.validate(value)
                                    ? Icons.check
                                    : Icons.close,
                                color: rule.validate(value)
                                    ? Colors.green
                                    : Colors.red,
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                rule.name,
                                style: TextStyle(
                                  color: rule.validate(value)
                                      ? Colors.green
                                      : Colors.red,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                );
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hint: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8),
                  child: Text(
                    AppLocalizations.of(context)!.your_password,
                    style: TextStyle(color: AppColors.grey),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
