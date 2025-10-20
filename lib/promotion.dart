import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class PromotionPage extends StatefulWidget {
  const PromotionPage({super.key});

  @override
  State<PromotionPage> createState() => _PromotionPageState();
}

class _PromotionPageState extends State<PromotionPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final isTablet = width > 600;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            navigator?.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          "Promotion",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        titleSpacing: isTablet ? width * 0.25 : 71,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.06,
          vertical: height * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            promoContainer(context),
            SizedBox(height: height * 0.03),
            Text(
              "Today 50% discount on all books in Chapter with online orders",
              style: TextStyle(
                fontSize: isTablet ? 22 : 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: height * 0.02),
            Text(
              "Excuse me… Who could ever resist a discount feast? 👀",
              style: TextStyle(
                fontSize: isTablet ? 18 : 14,
                color: const Color(0XFF7A7A7A),
              ),
            ),
            SizedBox(height: height * 0.02),
            Text(
              "Hear me out. Today, October 24, 2025, Chapter has a 50% discount for any book. What are you waiting for, let's order now before it runs out.",
              style: TextStyle(
                fontSize: isTablet ? 18 : 14,
                color: const Color(0XFF7A7A7A),
              ),
            ),
            SizedBox(height: height * 0.02),
            Text(
              "All books are discounted, just order through the Chapter app to enjoy this discount. From bestsellers to timeless classics, we’ve prepared the best collection for you. Discover, read, and enjoy your next great book with Chapter.",
              style: TextStyle(
                fontSize: isTablet ? 18 : 14,
                color: const Color(0XFF7A7A7A),
              ),
            ),
            SizedBox(height: height * 0.02),
            Text(
              "So, what’s your pick? 📖 Don’t miss out—order your next read today 😉",
              style: TextStyle(
                fontSize: isTablet ? 18 : 14,
                color: const Color(0XFF7A7A7A),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget promoContainer(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final isTablet = width > 600;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(width * 0.05),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 247, 244, 255),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "50% Discount",
                  style: TextStyle(
                    fontSize: isTablet ? 24 : 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0XFF54408C),
                  ),
                ),
                Text(
                  "On All Books",
                  style: TextStyle(
                    fontSize: isTablet ? 24 : 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0XFF54408C),
                  ),
                ),
                SizedBox(height: height * 0.008),
                Text(
                  "Grab it now!",
                  style: TextStyle(
                    fontSize: isTablet ? 16 : 14,
                    color: const Color(0XFF54408C),
                  ),
                ),
                SizedBox(height: height * 0.03),
                Container(
                  height: isTablet ? 48 : 36,
                  width: isTablet ? width * 0.25 : width * 0.3,
                  decoration: BoxDecoration(
                    color: const Color(0XFF54408C),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        // navigate to home page
                      },
                      child: Text(
                        "Shop Now",
                        style: TextStyle(
                          fontSize: isTablet ? 16 : 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),

          SizedBox(width: width * 0.05),

          Flexible(
            child: Image.asset(
              "assets/images/Frame.png",
              width: isTablet ? width * 0.25 : width * 0.3,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
