import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:books/custom/custom_copon.dart';

class Offers extends StatelessWidget {
  const Offers({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: screenHeight * 0.12,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Text(
            'Offers',
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.w700,
              fontSize: screenWidth * 0.05,
              color: const Color(0xff121212),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'You Have 5 Coupons to use',
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w700,
                    fontSize: screenWidth * 0.045,
                    color: const Color(0xff121212),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomCopon(
                      sale: '50%\nOff',
                      color: const Color(0xff54408C),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  Expanded(
                    child: CustomCopon(
                      sale: '23%\nOff',
                      color: const Color(0xffF5BE00),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.03),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomCopon(
                      sale: '50%\nOff',
                      color: const Color(0xff3784FB),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  Expanded(
                    child: CustomCopon(
                      sale: '23%\nOff',
                      color: const Color(0xffFF8C39),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.03),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomCopon(
                      sale: '50%\nOff',
                      color: const Color(0xff121212),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  Expanded(
                    child: CustomCopon(
                      sale: '23%\nOff',
                      color: const Color(0xff34A853),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}