import 'package:books/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class PromotionPage extends StatelessWidget {
  const PromotionPage({super.key});

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
        title: Text(
          AppLocalizations.of(context)!.promotion,
          style: const TextStyle(fontWeight: FontWeight.bold),
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
            _PromoContainer(isTablet: isTablet),
            SizedBox(height: height * 0.03),
            Text(
              AppLocalizations.of(context)!.today_discount_chapter,
              style: TextStyle(
                fontSize: isTablet ? 22 : 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: height * 0.02),
            Text(
              AppLocalizations.of(context)!.discount_feast_phrase,
              style: TextStyle(
                fontSize: isTablet ? 18 : 14,
                color: const Color(0XFF7A7A7A),
              ),
            ),
            SizedBox(height: height * 0.02),
            Text(
              AppLocalizations.of(context)!.chapter_discount_announcement,
              style: TextStyle(
                fontSize: isTablet ? 18 : 14,
                color: const Color(0XFF7A7A7A),
              ),
            ),
            SizedBox(height: height * 0.02),
            Text(
              AppLocalizations.of(context)!.chapter_discount_details,
              style: TextStyle(
                fontSize: isTablet ? 18 : 14,
                color: const Color(0XFF7A7A7A),
              ),
            ),
            SizedBox(height: height * 0.02),
            Text(
              AppLocalizations.of(context)!.whats_your_pick,
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
}

class _PromoContainer extends StatelessWidget {
  const _PromoContainer({required this.isTablet});

  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

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
                  AppLocalizations.of(context)!.fifty_percent_discount,
                  style: TextStyle(
                    fontSize: isTablet ? 24 : 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0XFF54408C),
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.all_books,
                  style: TextStyle(
                    fontSize: isTablet ? 24 : 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0XFF54408C),
                  ),
                ),
                SizedBox(height: height * 0.008),
                Text(
                  AppLocalizations.of(context)!.grab_it_now,
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
                      onTap: () {},
                      child: Text(
                        AppLocalizations.of(context)!.shop_now,
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
