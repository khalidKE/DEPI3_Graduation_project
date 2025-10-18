import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFavorites extends StatelessWidget {
  const CustomFavorites({
    super.key,
    required this.imagePath,
    required this.price,
    required this.film,
  });

  final String imagePath;
  final String price;
  final String film;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.11,
      width: double.infinity, 
      decoration: BoxDecoration(
        border: Border(
         bottom: BorderSide( color: const Color(0xffE8E8E8)),
        
        ),
       
      ),
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            width: screenWidth * 0.15, 
            fit: BoxFit.cover,
          ),
          SizedBox(width: screenWidth * 0.04),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  film,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    fontSize: screenWidth * 0.04,
                    color: const Color(0xff121212),
                  ),
                ),
                Text(
                  price,
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w700,
                    fontSize: screenWidth * 0.035,
                    color: const Color(0xff54408C),
                  ),
                ),
              ],
            ),
          ),
          SvgPicture.asset(
            'assets/images/Heart.svg',
            width: screenWidth * 0.05,
          ),
        ],
      ),
    );
  }
}