import 'package:books/core/colors/colors.dart';
import 'package:flutter/material.dart';

class PurpleButton extends StatelessWidget {
  final String buttonText;
  final void Function() onTapFunction;

  const PurpleButton({
    super.key,
    required this.buttonText,
    required this.onTapFunction,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapFunction,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColors.purple,
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
