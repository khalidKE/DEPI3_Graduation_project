import 'package:books/features/authentication_feature/presentation/views/signup_screen.dart';
import 'package:books/features/home_feature/presentation/views/home_screen.dart';
import 'package:books/l10n/app_localizations.dart';
import 'package:books/core/widgets/language_toggle.dart';
import 'package:books/core/utils/responsive.dart';
import 'package:books/features/cart_feature/presentation/views/cart_screen.dart';
import 'package:books/features/cart_feature/presentation/views/orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:books/features/profile_feature/presentation/views/custom/custom_profile.dart';
import 'package:books/features/profile_feature/presentation/views/account.dart';
import 'package:books/features/profile_feature/presentation/views/favorites.dart';
import 'package:books/features/profile_feature/presentation/views/help_center.dart';
import 'package:books/features/profile_feature/presentation/views/offers.dart';
import 'package:books/features/profile_feature/presentation/views/order_history.dart';
import 'package:books/features/authentication_feature/data/user_model.dart';
import 'package:books/services/firestore_services.dart';
import 'package:books/features/cart_feature/presentation/views/set_location_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return FutureBuilder<UserModel?>(
      future: FirestoreServices.getUserData(),
      builder: (context, snapshot) {
        final user = snapshot.data;
        final currentUser = FirebaseAuth.instance.currentUser;
        final displayName = (user?.name.trim().isNotEmpty ?? false)
            ? user!.name
            : (currentUser?.displayName?.isNotEmpty ?? false)
                ? currentUser!.displayName!
                : (currentUser?.email ?? 'Guest reader');
        final phone = (user?.phone.trim().isNotEmpty ?? false) &&
                (user?.phone != 'none')
            ? user!.phone
            : (currentUser?.phoneNumber?.isNotEmpty ?? false)
                ? currentUser!.phoneNumber!
                : 'Phone not set';
        final ImageProvider<Object> avatarImage =
            (user?.profilePic.trim().isNotEmpty ?? false)
                ? NetworkImage(user!.profilePic) as ImageProvider<Object>
                : const AssetImage('assets/images/profile.png')
                    as ImageProvider<Object>;

        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: Responsive.responsiveSpacing(context, 60,
                  tabletSpacing: 70, desktopSpacing: 80),
              title: Center(
                child: Text(
                  AppLocalizations.of(context)!.profile,
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w700,
                    fontSize: Responsive.responsiveFontSize(context, 20),
                  ),
                ),
              ),
              actions: const [
                LanguageToggleButton(),
              ],
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
                        top: BorderSide(color: Color(0XFFE8E8E8)),
                      ),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: screenWidth * 0.075,
                          backgroundColor: const Color(0XFFE8E8E8),
                          backgroundImage: avatarImage,
                        ),
                        SizedBox(width: screenWidth * 0.04),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                displayName,
                                style: TextStyle(
                                  color: const Color(0XFF121212),
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.w800,
                                  fontSize: screenWidth * 0.045,
                                ),
                              ),
                              Text(
                                phone,
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
                                                      const SignUpScreen()),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Account()),
                      );
                    },
                  ),
                  InkWell(
                    child: CustomProfile(
                      imagePath: 'assets/images/offer.png',
                      title: AppLocalizations.of(context)!.offers_and_promos,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Offers()),
                      );
                    },
                  ),
                  InkWell(
                    child: CustomProfile(
                      imagePath: 'assets/images/Heart.svg',
                      title: AppLocalizations.of(context)!.your_favorites,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Favorites()),
                      );
                    },
                  ),
                  InkWell(
                    child: CustomProfile(
                      imagePath: 'assets/images/order.png',
                      title: AppLocalizations.of(context)!.orders,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OrderHistory()),
                      );
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
                            builder: (context) => const HelpCenterScreen()),
                      );
                    },
                  ),
                  InkWell(
                    child: CustomProfile(
                      imagePath: 'assets/images/address.png',
                      title: 'Address',
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SetLocationScreen()),
                      );
                    },
                  ),
                  InkWell(
                    child: CustomProfile(
                      imagePath: 'assets/images/Document.png',
                      title: 'Policies',
                    ),
                    onTap: () {},
                  ),
                  InkWell(
                    child: CustomProfile(
                      imagePath: 'assets/images/offer.png',
                      title: 'Invite a friend',
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: 3,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: const Color(0XFF54408C),
              unselectedItemColor: const Color(0XFFA6A6A6),
              items: [
                BottomNavigationBarItem(
                  icon: InkWell(
                    onTap: () {
                      Get.off(() => const HomeScreen());
                    },
                    child: const Icon(
                      Icons.home_outlined,
                      size: 28,
                    ),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: InkWell(
                    onTap: () {
                      Get.to(() => const OrdersScreen());
                    },
                    child: Image.asset('assets/images/Buy.png',
                        color: Colors.grey[300],
                        width: Responsive.responsiveImageSize(context, 22),
                        height: Responsive.responsiveImageSize(context, 22)),
                  ),
                  label: AppLocalizations.of(context)!.order,
                ),
                BottomNavigationBarItem(
                  icon: InkWell(
                    onTap: () {
                      Get.to(() => const CartScreen());
                    },
                    child: Image.asset('assets/images/Frame.png',
                        color: Colors.grey[300],
                        width: Responsive.responsiveImageSize(context, 24),
                        height: Responsive.responsiveImageSize(context, 24)),
                  ),
                  label: AppLocalizations.of(context)!.cart,
                ),
                BottomNavigationBarItem(
                  icon: InkWell(
                    onTap: () {
                      Get.to(() => const Profile());
                    },
                    child: Image.asset('assets/images/profile_bottom.png',
                        color: const Color(0XFF54408C),
                        width: Responsive.responsiveImageSize(context, 24),
                        height: Responsive.responsiveImageSize(context, 24)),
                  ),
                  label: AppLocalizations.of(context)!.profile,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
