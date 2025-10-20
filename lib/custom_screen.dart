import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.imagePath,
    required this.book,
    required this.price,
  });
  final String imagePath;
  final String book;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 214,
          width: 158,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(8),
                child: Image.asset(imagePath, height: 158, fit: BoxFit.cover),
              ),
              SizedBox(height: 8),
              Text(
                book,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 4),
              Text(
                price,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xdd54408c),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
