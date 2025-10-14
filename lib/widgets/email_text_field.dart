import 'package:books/colors/colors.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final TextEditingController enteredEmail = TextEditingController();

class Emailtextfield extends StatefulWidget {
  const Emailtextfield({super.key});

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
          'Email',
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
            controller: enteredEmail,
            validator: (value) {
              if (!value!.contains('@')) return ('the email must contain @');
            },
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: InputBorder.none,
              hint: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8),
                child: Text(
                  'Your email',
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
