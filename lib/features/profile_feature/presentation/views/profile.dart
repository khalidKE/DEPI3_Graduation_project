import 'package:books/features/authentication_feature/presentation/views/signup_screen.dart';
import 'package:books/features/home_feature/presentation/views/home_screen.dart';
import 'package:books/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:books/features/profile_feature/presentation/views/custom/custom_profile.dart';
import 'package:books/features/profile_feature/presentation/views/account.dart';
import 'package:books/features/profile_feature/presentation/views/favorites.dart';
import 'package:books/features/profile_feature/presentation/views/help_center.dart';
import 'package:books/features/profile_feature/presentation/views/offers.dart';
import 'package:books/features/profile_feature/presentation/views/order_history.dart';
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
              AppLocalizations.of(context)!.profile,
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
                      top: BorderSide(color: Color(0XFFE8E8E8))),
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
                                    AppLocalizations.of(context)!.logout,
                                    style: TextStyle(
                                      color: const Color(0XFF121212),
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w700,
                                      fontSize: screenWidth * 0.05,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.015),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .lorem_ipsum_text,
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
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SignUpScreen()),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0XFF54408C),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(48),
                                        ),
                                      ),
                                      child: Text(
                                        AppLocalizations.of(context)!.logout,
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
                                        AppLocalizations.of(context)!.cancel,
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
                        AppLocalizations.of(context)!.logout,
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
              InkWell(
                child: CustomProfile(
                  imagePath: 'assets/images/Group.png',
                  title: AppLocalizations.of(context)!.my_account,
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Account()));
                },
              ),
              InkWell(
                child: CustomProfile(
                  imagePath: 'assets/images/offer.png',
                  title: AppLocalizations.of(context)!.offers_and_promos,
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Offers()));
                },
              ),
              InkWell(
                child: CustomProfile(
                  imagePath: 'assets/images/fav.png',
                  title: AppLocalizations.of(context)!.your_favorites,
                ),
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
                  title: AppLocalizations.of(context)!.order_history,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OrederHistory()));
                },
              ),
              InkWell(
                child: CustomProfile(
                  imagePath: 'assets/images/help.png',
                  title: AppLocalizations.of(context)!.help_center,
                ),
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
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF5B4DB5),
          unselectedItemColor: Colors.grey,
          currentIndex: 3,
          onTap: (index) {
            switch (index) {
              case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
                break;
              case 1:
                // Orders
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('category Screen - Coming Soon')),
                );
                break;
              case 2:
                // Cart
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Cart Screen - Coming Soon')),
                );
                break;
              case 3:
                // Profile

                break;
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
