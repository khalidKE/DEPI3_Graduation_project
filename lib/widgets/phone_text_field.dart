import 'package:books/colors/colors.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhoneTextField extends StatefulWidget {
  TextEditingController enteredNumber;

  PhoneTextField({super.key, required this.enteredNumber});

  @override
  State<PhoneTextField> createState() => _EmailtextfieldState();
}

class _EmailtextfieldState extends State<PhoneTextField> {
  @override
  Widget build(BuildContext context) {
    return (Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phone Number',
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
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) return ('this field can\'t be empty');
            },
            controller: widget.enteredNumber,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              border: InputBorder.none,
              hint: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8),

                child: Row(
                  children: [
                    Icon(Icons.phone_outlined, color: AppColors.purple),
                    SizedBox(width: 1),
                    Text(
                      'Your number',
                      style: TextStyle(color: AppColors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
