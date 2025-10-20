import 'package:books/colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Purplebuttun extends StatefulWidget {
  late String buttunText;
  late void Function() onTapFunction;
  Purplebuttun({
    super.key,
    required this.buttunText,
    required this.onTapFunction,
  });

  @override
  State<Purplebuttun> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Purplebuttun> {
  @override
  Widget build(BuildContext context) {
    return (InkWell(
      onTap: widget.onTapFunction,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColors.purple,
        ),
        child: Center(
          child: Text(
            widget.buttunText,
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    ));
  }
}
