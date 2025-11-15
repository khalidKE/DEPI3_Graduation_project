import 'package:books/core/colors/colors.dart';
import 'package:books/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class PhoneTextField extends StatefulWidget {
  final TextEditingController enteredNumber;

  const PhoneTextField({
    super.key,
    required this.enteredNumber,
  });

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
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
          AppLocalizations.of(context)!.phone_number,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocalizations.of(context)!.this_field_cant_be_empty;
            }
            return null;
          },
          controller: widget.enteredNumber,
          keyboardType: TextInputType.phone,
          style: TextStyle(color: textColor),
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.your_number,
            hintStyle: TextStyle(color: hintColor),
            prefixIcon: Icon(
              Icons.phone_outlined,
              color: AppColors.purple,
            ),
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
