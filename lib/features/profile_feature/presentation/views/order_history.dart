import 'package:books/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:books/features/profile_feature/presentation/views/custom/delivery_containers.dart';

class OrederHistory extends StatelessWidget {
  const OrederHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          toolbarHeight: screenHeight * 0.1,
          title: Center(
            child: Text(
              AppLocalizations.of(context)!.order_history,
              style: GoogleFonts.openSans(
                fontWeight: FontWeight.w700,
                fontSize: screenWidth * 0.055,
                color: const Color(0xFF121212),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.02),
                Text(
                 AppLocalizations.of(context)!.october_2021,
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w700,
                    fontSize: screenWidth * 0.045,
                    color: const Color(0xff121212),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                DeliveryContainers(
                  film: 'Carrie Fisher',
                  status: 'Delivered',
                  quantity: '1 item',
                  poster: 'assets/images/book1.png',
                ),
                DeliveryContainers(
                  film: 'The Waiting',
                  status: 'Delivered',
                  quantity: '5 items',
                  poster: 'assets/images/book2.png',
                ),
                DeliveryContainers(
                  film: 'Bright Young',
                  status: 'Cancelled',
                  quantity: '2 items',
                  poster: 'assets/images/book3.png',
                ),
                SizedBox(height: screenHeight * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
