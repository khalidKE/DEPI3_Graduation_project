import 'package:books/core/colors/colors.dart';
import 'package:flutter/material.dart';

class WhiteButton extends StatelessWidget {
  final String buttonText;
  final String imagePath;
  final void Function() onTapFunction;

  const WhiteButton({
    super.key,
    required this.buttonText,
    required this.onTapFunction,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapFunction,
      child: Container(
        height: 50,
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 330),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.black),
          color: AppColors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath),
            const SizedBox(width: 8),
            Text(
              buttonText,
              style: TextStyle(color: AppColors.black, fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }
}
