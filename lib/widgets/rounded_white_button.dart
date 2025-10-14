import 'package:books/colors/colors.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Whitebuttun extends StatefulWidget {
  late String buttunText;
  late String imagepath;
  late void Function() ontapFunction;

  Whitebuttun({
    super.key,
    required this.buttunText,
    required this.ontapFunction,
    required this.imagepath,
  });

  @override
  State<Whitebuttun> createState() => _WhitebuttunState();
}

class _WhitebuttunState extends State<Whitebuttun> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.ontapFunction,
      child: (Container(
        height: 50,
        width: 330,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.black),
          color: AppColors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(widget.imagepath),
            SizedBox(width: 8),
            Text(
              widget.buttunText,
              style: TextStyle(color: AppColors.black, fontSize: 17),
            ),
          ],
        ),
      )),
    );
  }
}
