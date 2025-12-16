import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomProfile extends StatelessWidget {
  const CustomProfile(
      {super.key, required this.imagePath, required this.title});
  final String imagePath;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        height: 72,
        child: Row(
          children: [
            _buildIcon(),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.roboto(
                  color: const Color(0XFF121212),
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Image.asset(
              'assets/images/Vector.png',
              width: 20,
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    if (imagePath.toLowerCase().endsWith('.svg')) {
      return SvgPicture.asset(
        imagePath,
        width: 36,
        height: 36,
      );
    }
    return Image.asset(
      imagePath,
      width: 36,
      height: 36,
      fit: BoxFit.cover,
    );
  }
}
