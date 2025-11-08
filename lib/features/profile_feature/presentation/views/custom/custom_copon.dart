import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCopon extends StatelessWidget {
  const CustomCopon({super.key, required this.sale, required this.color});

  final String sale;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.20,
      width: screenWidth * 0.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            sale,
            style: GoogleFonts.openSans(
              fontSize: screenWidth * 0.08,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 0.9,
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Container(
            height: screenHeight * 0.05,
            width: screenWidth * 0.25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.white,
            ),
            child: Center(
              child: Text(
                'Copy',
                style: GoogleFonts.roboto(
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}