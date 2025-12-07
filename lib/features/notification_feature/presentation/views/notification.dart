import 'package:books/core/utils/responsive.dart';
import 'package:books/features/notification_feature/presentation/view_model/notification_state.dart';
import 'package:books/features/notification_feature/presentation/view_model/notification_view_model.dart';
import 'package:books/features/notification_feature/presentation/views/promotion.dart';
import 'package:books/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isTablet = width > 600;

    return BlocProvider(
      create: (_) => NotificationViewModel(),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: _AppBar(width: width, isTablet: isTablet),
          body: const _NotificationTabs(),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({required this.width, required this.isTablet});

  final double width;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
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
          Tab(
            text: AppLocalizations.of(context)!.delivery,
          ),
          Tab(
            text: AppLocalizations.of(context)!.news,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 48);
}

class _NotificationTabs extends StatelessWidget {
  const _NotificationTabs();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final isTablet = width > 600;

    return BlocBuilder<NotificationViewModel, NotificationState>(
      builder: (context, state) {
        return TabBarView(
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
                    ...state.deliveries.map(
                      (delivery) => Padding(
                        padding:
                            EdgeInsets.only(bottom: Responsive.responsiveSpacing(context, 12)),
                        child: _DeliveryCard(
                          data: delivery,
                          isTablet: isTablet,
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                    Text(
                      AppLocalizations.of(context)!.october_2021,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isTablet ? 22 : 18,
                      ),
                    ),
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
                      child: _NewsRow(
                        item: state.news.first,
                        isTablet: isTablet,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Text(
                      AppLocalizations.of(context)!.fifty_percent_discount,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: height * 0.02),
                    Image.asset("assets/images/Line.png"),
                    SizedBox(height: height * 0.02),
                    ...state.news.skip(1).map((item) => Padding(
                          padding: EdgeInsets.only(
                            bottom: Responsive.responsiveSpacing(context, 16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _NewsRow(item: item, isTablet: isTablet),
                              SizedBox(height: height * 0.01),
                              Text(
                                _newsDescription(context, item.description),
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        )),
                    SizedBox(height: height * 0.03),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String _newsDescription(BuildContext context, String key) {
    final loc = AppLocalizations.of(context)!;
    switch (key) {
      case 'fifty_percent_discount':
        return '${loc.october_2021}${loc.fifty_percent_discount}${loc.novel_discount_description}';
      case 'buy_2_get_1_free':
        return '${loc.buy_2_get_1_free}${loc.books_offer_date}';
      case 'new_book_available':
        return loc.new_book_available;
      default:
        return key;
    }
  }
}

class _DeliveryCard extends StatelessWidget {
  const _DeliveryCard({required this.data, required this.isTablet});

  final NotificationTabData data;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final Map<String, Color> statusColors = {
      "on the way": const Color(0xFF3784FB),
      "delivered": const Color(0XFF18A057),
      "cancelled": const Color(0XFFEF5A56),
    };
    final statusColor = statusColors[data.status.toLowerCase()] ?? Colors.black;

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
            data.poster,
            width: isTablet ? width * 0.08 : width * 0.18,
            fit: BoxFit.cover,
          ),
          SizedBox(width: width * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.film,
                  style: TextStyle(
                    fontSize: isTablet ? 18 : 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: height * 0.005),
                Row(
                  children: [
                    Text(
                      data.status,
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
                      data.quantity,
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
}

class _NewsRow extends StatelessWidget {
  const _NewsRow({required this.item, required this.isTablet});

  final NewsItem item;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    final Map<String, Color> textColors = {
      "promotion": const Color(0XFF54408C),
      "information": const Color(0XFF3784FB),
    };
    final textColor = textColors[item.type.toLowerCase()] ?? Colors.black;

    return Row(
      children: [
        Text(
          item.type,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: isTablet ? 16 : 14,
            color: textColor,
          ),
        ),
        const Spacer(),
        Text(
          item.date,
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
          item.time,
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
