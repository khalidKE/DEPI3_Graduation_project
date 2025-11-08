import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:books/custom/custom_favorites.dart';


class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: width * 0.07,  
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        toolbarHeight: height * 0.12,
        title: Padding(
          padding: EdgeInsets.only(left: width * 0.15),
          child: Text(
            'Your Favorites',
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.w700,
              fontSize: width * 0.05, 
              color: Colors.black,
            ),
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height * 0.02),
              CustomFavorites(
                imagePath: 'assets/images/book1.png',
                price: '\$19.99',
                film: 'In in amet ultrices sit.',
              ),
             
              CustomFavorites(
                imagePath: 'assets/images/book2.png',
                price: '\$27.12',
                film: 'Bibendum facilisis.',
              ),
              
              CustomFavorites(
                imagePath: 'assets/images/book3.png',
                price: '\$13.52',
                film: 'Nulla et diam cras.',
              ),
              
              CustomFavorites(
                imagePath: 'assets/images/book4.png',
                price: '\$31.00',
                film: 'Risus malesuada in.',
              ),
              SizedBox(height: height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}