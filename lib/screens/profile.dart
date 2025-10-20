import 'package:flutter/material.dart';
import 'package:books/custom/custom_profile.dart';
import 'package:books/screens/account.dart';
import 'package:books/screens/favorites.dart';
import 'package:books/screens/help_center.dart';
import 'package:books/screens/offers.dart';
import 'package:books/screens/order_history.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: screenHeight * 0.1,
          title: Center(
            child: Text(
              'Profile',
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w700,
                fontSize: screenWidth * 0.06,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: screenHeight * 0.015),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0XFFE8E8E8)),
                    top:  BorderSide(color: Color(0XFFE8E8E8))
                  ),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/profile.png',
                      width: screenWidth * 0.15,
                      height: screenWidth * 0.15,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: screenWidth * 0.04),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'John Doe',
                            style: TextStyle(
                              color: const Color(0XFF121212),
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.w800,
                              fontSize: screenWidth * 0.045,
                            ),
                          ),
                          Text(
                            '(+1) 234 567 890',
                            style: GoogleFonts.roboto(
                              color: const Color(0XFFA6A6A6),
                              fontWeight: FontWeight.w400,
                              fontSize: screenWidth * 0.035,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(32),
                            ),
                          ),
                          builder: (BuildContext context) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.06,
                                  vertical: screenHeight * 0.02),
                              height: screenHeight * 0.4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Container(
                                      height: 5,
                                      width: screenWidth * 0.15,
                                      color: const Color(0XFFE8E8E8),
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.03),
                                  Text(
                                    'Logout',
                                    style: TextStyle(
                                      color: const Color(0XFF121212),
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w700,
                                      fontSize: screenWidth * 0.05,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.015),
                                  Text(
                                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                                    style: GoogleFonts.roboto(
                                      color: const Color(0XFF121212),
                                      fontWeight: FontWeight.w400,
                                      fontSize: screenWidth * 0.04,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.03),
                                  SizedBox(
                                    width: double.infinity,
                                    height: screenHeight * 0.06,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0XFF54408C),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(48),
                                        ),
                                      ),
                                      child: Text(
                                        'Logout',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'OpenSans',
                                          fontWeight: FontWeight.w700,
                                          fontSize: screenWidth * 0.045,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.02),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: screenHeight * 0.06,
                                      decoration: BoxDecoration(
                                        color: const Color(0xffFAF9FD),
                                        borderRadius: BorderRadius.circular(48),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(
                                          color: const Color(0XFF54408C),
                                          fontSize: screenWidth * 0.04,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Text(
                        'Logout',
                        style: GoogleFonts.roboto(
                          color: const Color(0XFFEF5A56),
                          fontWeight: FontWeight.w700,
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Options List
              InkWell(
                child: CustomProfile(
                    imagePath: 'assets/images/Group.png',
                    title: 'My Account'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Account()));
                },
              ),
              InkWell(
                child: CustomProfile(
                    imagePath: 'assets/images/offer.png',
                    title: 'Offers & Promos'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Offers()));
                },
              ),
              InkWell(
                child: CustomProfile(
                    imagePath: 'assets/images/fav.png',
                    title: 'Your Favorites'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Favorites()));
                },
              ),
              InkWell(
                child: CustomProfile(
                    imagePath: 'assets/images/order.png',
                    title: 'Order History'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OrederHistory()));
                },
              ),
              InkWell(
                child: CustomProfile(
                    imagePath: 'assets/images/help.png', title: 'Help Center'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HelpCenterScreen()));
                },
              ),
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
       
      ),
    );
  }
}