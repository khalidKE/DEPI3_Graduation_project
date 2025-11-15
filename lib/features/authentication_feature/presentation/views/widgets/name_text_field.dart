import 'package:books/core/colors/colors.dart';
import 'package:books/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class NameTextField extends StatefulWidget {
  final TextEditingController enteredName;

  const NameTextField({
    super.key,
    required this.enteredName,
  });

  @override
  State<NameTextField> createState() => _NameTextFieldState();
}

class _NameTextFieldState extends State<NameTextField> {
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
          AppLocalizations.of(context)!.name,
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
          controller: widget.enteredName,
          style: TextStyle(color: textColor),
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.your_name,
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
