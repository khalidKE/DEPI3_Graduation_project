import 'package:books/core/colors/colors.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NameTextField extends StatefulWidget {
  TextEditingController enteredName;

  NameTextField({super.key, required this.enteredName});

  @override
  State<NameTextField> createState() => _EmailtextfieldState();
}

class _EmailtextfieldState extends State<NameTextField> {
  @override
  Widget build(BuildContext context) {
    return (Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Name',
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
              if (value!.isEmpty) return ('this field can\'t be empty');
            },
            controller: widget.enteredName,
            decoration: InputDecoration(
              border: InputBorder.none,
              hint: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8),
                child: Text(
                  'Your name',
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
