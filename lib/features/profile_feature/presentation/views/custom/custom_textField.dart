import 'package:flutter/material.dart';
import 'package:books/core/colors/colors.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    required this.controller,
    required this.hintText,
    required this.labelText,
    this.textCapitalization = TextCapitalization.none,
  });

  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final String hintText;
  final String labelText;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lightGray = isDark ? Colors.grey[800]! : const Color(0xFFF4F1F1);
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? AppColors.black;
    final hintColor = isDark ? Colors.grey[500]! : Colors.grey[600]!;
    final iconColor = isDark ? Colors.grey[400]! : AppColors.purple;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 42),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            enabled: true,
            textCapitalization: textCapitalization,
            controller: controller,
            maxLines: 1,
            textAlign: TextAlign.start,
            obscureText: obscureText,
            style: TextStyle(color: textColor),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: hintColor),
              prefixIcon: prefixIcon != null
                  ? Icon(prefixIcon, color: iconColor)
                  : null,
              suffixIcon: suffixIcon != null
                  ? Icon(suffixIcon, color: isDark ? Colors.grey[400]! : Colors.grey[600]!)
                  : null,
              filled: true,
              fillColor: isDark ? Colors.grey[900]! : Colors.grey[50]!,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF6C47FF), width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}