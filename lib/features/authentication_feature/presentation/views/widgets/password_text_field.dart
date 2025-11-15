import 'package:books/core/colors/colors.dart';
import 'package:books/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController enteredPassword;
  final String? Function(String?)? validation;

  const PasswordTextField({
    super.key,
    required this.enteredPassword,
    required this.validation,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? AppColors.black;
    final hintColor = isDark ? Colors.grey[500]! : AppColors.grey;
    final borderColor = isDark ? Colors.grey[700]! : Colors.grey[300]!;
    final iconColor = isDark ? Colors.grey[400]! : Colors.grey[600]!;
    
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
        TextFormField(
          controller: widget.enteredPassword,
          validator: widget.validation,
          obscureText: obscureText,
          style: TextStyle(color: textColor),
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.your_password,
            hintStyle: TextStyle(color: hintColor),
            filled: true,
            fillColor: isDark ? Colors.grey[900]! : Colors.grey[50]!,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              child: Icon(
                obscureText
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: iconColor,
              ),
            ),
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
