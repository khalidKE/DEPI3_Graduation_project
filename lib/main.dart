import 'package:books/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:books/screens/favorites.dart';
import 'package:books/screens/account.dart';
import 'package:books/screens/help_center.dart';
import 'package:books/screens/offers.dart';
import 'package:books/screens/order_history.dart';
import 'package:books/screens/profile.dart';



void main() {
  runApp(const MyWidget());
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Profile() ,
    );
  }
}