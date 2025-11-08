import 'package:books/features/notification_feature/presentation/views/promotion.dart';
import 'package:books/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final isTablet = width > 600;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: appbar(width, isTablet),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05,
                  vertical: height * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.03),
                    Text(
                      AppLocalizations.of(context)!.current,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isTablet ? 22 : 18,
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    delievryContainer(
                      context,
                      film: 'The Da vinci Code',
                      status: 'On the way',
                      quantity: '1 item',
                      poster: 'assets/images/Image.png',
                    ),
                    SizedBox(height: height * 0.03),
                    Text(
                      AppLocalizations.of(context)!.october_2021,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isTablet ? 22 : 18,
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    delievryContainer(context,
                        film: 'Carrie Fisher',
                        status: 'Delivered',
                        quantity: '1 item',
                        poster: 'assets/images/Rectangle.png'),
                    delievryContainer(context,
                        film: 'The Waiting',
                        status: 'Delivered',
                        quantity: '5 items',
                        poster: 'assets/images/Rectanglee.png'),
                    delievryContainer(context,
                        film: 'Bright Young',
                        status: 'Cancelled',
                        quantity: '2 items',
                        poster: 'assets/images/Ractangleee.png'),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05,
                  vertical: height * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.03),
                    Text(
                      AppLocalizations.of(context)!.october_2021,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isTablet ? 22 : 18,
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    InkWell(
                      onTap: () {
                        Get.to(const PromotionPage());
                      },
                      child: newsPromotionRow(
                          text: AppLocalizations.of(context)!.promotion, date: 'Oct 24', time: '08.00'),
                    ),
                    SizedBox(height: height * 0.01),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Colors.black, fontSize: 14),
                        children: [
                          TextSpan(text: AppLocalizations.of(context)!.october_2021,),
                          TextSpan(
                            text: AppLocalizations.of(context)!.fifty_percent_discount,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text:
                                AppLocalizations.of(context)!.novel_discount_description,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    Image.asset("assets/images/Line.png"),
                    SizedBox(height: height * 0.02),
                    newsPromotionRow(
                        text: AppLocalizations.of(context)!.promotion, date: 'Oct 08', time: '20.30'),
                    SizedBox(height: height * 0.01),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black, fontSize: 14),
                        children: [
                          TextSpan(
                            text: AppLocalizations.of(context)!.buy_2_get_1_free,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: AppLocalizations.of(context)!.books_offer_date,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                    Text(
                      AppLocalizations.of(context)!.september_2021,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isTablet ? 22 : 18,
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    newsPromotionRow(
                        text: AppLocalizations.of(context)!.information, date: 'Sept 16', time: '11.00'),
                    SizedBox(height: height * 0.01),
                    Text(
                      AppLocalizations.of(context)!.new_book_available,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar appbar(double width, bool isTablet) {
    return AppBar(
      leading: InkWell(
        onTap: () {
          Get.back();
        },
        child: const Icon(Icons.arrow_back),
      ),
      title: Text(
        AppLocalizations.of(context)!.notification,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      titleSpacing: isTablet ? width * 0.25 : 71,
      bottom: TabBar(
        tabs: [
          Tab(text: AppLocalizations.of(context)!.delivery,),
          Tab(text:AppLocalizations.of(context)!.news,),
        ],
      ),
    );
  }

  Widget delievryContainer(BuildContext context,
      {required String film,
      required String status,
      required String quantity,
      required String poster}) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final isTablet = width > 600;

    final Map<String, Color> statusColors = {
      "on the way": const Color(0xFF3784FB),
      "delivered": const Color(0XFF18A057),
      "cancelled": const Color(0XFFEF5A56),
    };
    final statusColor = statusColors[status.toLowerCase()] ?? Colors.black;

    return Container(
      margin: EdgeInsets.only(bottom: height * 0.02),
      padding: EdgeInsets.all(width * 0.03),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE1DEDE)),
      ),
      child: Row(
        children: [
          Image.asset(
            poster,
            width: isTablet ? width * 0.08 : width * 0.18,
            fit: BoxFit.cover,
          ),
          SizedBox(width: width * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  film,
                  style: TextStyle(
                    fontSize: isTablet ? 18 : 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: height * 0.005),
                Row(
                  children: [
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: isTablet ? 16 : 14,
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: width * 0.015),
                    Container(
                      height: 5,
                      width: 5,
                      decoration: const BoxDecoration(
                        color: Color(0XFFE8E8E8),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: width * 0.015),
                    Text(
                      quantity,
                      style: TextStyle(
                        fontSize: isTablet ? 16 : 14,
                        color: const Color(0XFF7A7A7A),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row newsPromotionRow({
    required String text,
    required String date,
    required String time,
  }) {
    final Map<String, Color> textColors = {
      "promotion": const Color(0XFF54408C),
      "information": const Color(0XFF3784FB),
    };
    final textColor = textColors[text.toLowerCase()] ?? Colors.black;

    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: textColor,
          ),
        ),
        const Spacer(),
        Text(
          date,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: Color(0XFFA6A6A6),
          ),
        ),
        const SizedBox(width: 6),
        Container(
          height: 5,
          width: 5,
          decoration: const BoxDecoration(
            color: Color(0XFFA6A6A6),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          time,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: Color(0XFFA6A6A6),
          ),
        ),
      ],
    );
  }
}