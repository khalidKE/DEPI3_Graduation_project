import 'package:books/core/colors/colors.dart';
import 'package:books/l10n/app_localizations.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Emailtextfield extends StatefulWidget {
  TextEditingController enteredEmail;
  Emailtextfield({super.key, required this.enteredEmail});

  @override
  State<Emailtextfield> createState() => _EmailtextfieldState();
}

class _EmailtextfieldState extends State<Emailtextfield> {
  @override
  Widget build(BuildContext context) {
    return (Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.email,
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
            controller: widget.enteredEmail,
            validator: (value) {
              if (!value!.contains('@')) {
                return AppLocalizations.of(context)!.the_email_must_contain;
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: InputBorder.none,
              hint: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8),
                child: Text(
                  AppLocalizations.of(context)!.your_email,
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
