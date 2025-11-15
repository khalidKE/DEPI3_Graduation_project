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
    return (Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.name,
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.this_field_cant_be_empty;
              }
              return null;
            },
            controller: widget.enteredName,
            decoration: InputDecoration(
              border: InputBorder.none,
              hint: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8),
                child: Text(
                  AppLocalizations.of(context)!.your_name,
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
