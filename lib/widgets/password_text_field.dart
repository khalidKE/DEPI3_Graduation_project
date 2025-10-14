import 'package:books/colors/colors.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final TextEditingController enteredPassword = TextEditingController();

class Passwordtextfield extends StatefulWidget {
  const Passwordtextfield({super.key});

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
          'Password',
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
            controller: enteredPassword,
            validator: (value) {
              if (value!.length < 6)
                return ('password should be more that 5 digits');
            },
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
                  'Your password',
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
