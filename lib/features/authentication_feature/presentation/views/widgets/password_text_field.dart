import 'package:books/core/colors/colors.dart';
import 'package:books/l10n/app_localizations.dart';
import 'package:fancy_password_field/fancy_password_field.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class Passwordtextfield extends StatefulWidget {
  late TextEditingController enteredPassword;
  late String? Function(String?)? validation;

  Passwordtextfield({
    super.key,
    required this.enteredPassword,
    required this.validation,
  });

  @override
  State<Passwordtextfield> createState() => _PasswordtextfieldState();
}

class _PasswordtextfieldState extends State<Passwordtextfield> {
  @override
  bool obscureText = true;

  Widget build(BuildContext context) {
    return (Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.password,
          style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.lightGray,
          ),
          height: 55,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            controller: widget.enteredPassword,
            validator: widget.validation,
            obscureText: obscureText,
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                onTap: () {
                  obscureText = !obscureText;
                  setState(() {});
                },
                child: Icon(
                  obscureText
                      ? Icons.remove_red_eye
                      : Icons.remove_red_eye_outlined,
                ),
              ),
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
        ),
      ],
    ));
  }
}
