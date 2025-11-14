import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomProfile extends StatelessWidget {
  const CustomProfile(
      {super.key, required this.imagePath, required this.title});
  final String imagePath;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: SizedBox(
        height: 72,
        child: Row(
          children: [
            Image.asset(imagePath),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.roboto(
                    color: Color(0XFF121212),
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
            ),
            Image.asset('assets/images/Vector.png')
          ],
        ),
      ),
    );
  }
}
