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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? AppColors.black;
    final hintColor = isDark ? Colors.grey[500]! : AppColors.grey;
    final borderColor = isDark ? Colors.grey[700]! : Colors.grey[300]!;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.password,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        FancyPasswordField(
          controller: enteredPassword,
          style: TextStyle(color: textColor),
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
            hintText: AppLocalizations.of(context)!.your_password,
            hintStyle: TextStyle(color: hintColor),
            filled: true,
            fillColor: isDark ? Colors.grey[900]! : Colors.grey[50]!,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF6C47FF), width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
