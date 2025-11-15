import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:books/features/home_feature/presentation/views/home_screen.dart';
import 'package:books/core/utils/responsive.dart';
import 'package:books/l10n/app_localizations.dart';

class OrderReceivedScreen extends StatefulWidget {
  const OrderReceivedScreen({super.key});

  @override
  State<OrderReceivedScreen> createState() => _OrderReceivedScreenState();
}

class _OrderReceivedScreenState extends State<OrderReceivedScreen> {
  int _rating = 4;
  final TextEditingController _feedbackController = TextEditingController();

  late int _orderNumber; // رقم الأوردر العشوائي

  @override
  void initState() {
    super.initState();
    // توليد رقم عشوائي من 7 أرقام
    _orderNumber = 1000000 + Random().nextInt(9000000);
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = Responsive.maxContentWidth(context);
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: maxWidth ?? double.infinity,
              ),
              child: SingleChildScrollView(
                padding: Responsive.responsivePadding(context),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: Responsive.responsiveSpacing(context, 20)),

                    // Gift Box Image from assets
                    Container(
                      padding: EdgeInsets.all(Responsive.responsiveSpacing(context, 20)),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C47FF).withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(
                          Responsive.responsiveBorderRadius(context, 60),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          Responsive.responsiveBorderRadius(context, 40),
                        ),
                        child: Image.asset(
                          'lib/image/img1.jpg',
                          width: Responsive.responsiveImageSize(context, 80),
                          height: Responsive.responsiveImageSize(context, 80),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    SizedBox(height: Responsive.responsiveSpacing(context, 24)),

                    // Order Confirmation Text
                    Text(
                      AppLocalizations.of(context)!.you_received_the_order,
                      style: TextStyle(
                        fontSize: Responsive.responsiveFontSize(context, 24),
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: Responsive.responsiveSpacing(context, 8)),

                    // 🔢 رقم الأوردر العشوائي
                    Text(
                      AppLocalizations.of(context)!.order_number(_orderNumber),
                      style: TextStyle(
                        fontSize: Responsive.responsiveFontSize(context, 16),
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: Responsive.responsiveSpacing(context, 32)),

                    // Feedback Card
                    Container(
                      padding: EdgeInsets.all(Responsive.responsiveSpacing(context, 20)),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C47FF).withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(
                          Responsive.responsiveBorderRadius(context, 16),
                        ),
                        border: Border.all(
                          color: const Color(0xFF6C47FF).withValues(alpha: 0.1),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.tell_us_your_feedback,
                            style: TextStyle(
                              fontSize: Responsive.responsiveFontSize(context, 18),
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF6C47FF),
                            ),
                          ),

                          SizedBox(height: Responsive.responsiveSpacing(context, 8)),

                          // ⭐ Star Rating - Click to select
                          Row(
                            children: List.generate(5, (index) {
                              final isSelected = index < _rating;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _rating = index + 1;
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    right: Responsive.responsiveSpacing(context, 8),
                                  ),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    child: Icon(
                                      Icons.star,
                                      color: isSelected
                                          ? Colors.amber
                                          : Colors.grey.withValues(alpha: 0.3),
                                      size: Responsive.responsiveIconSize(context, 32),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                          SizedBox(height: Responsive.responsiveSpacing(context, 8)),
                          Text(
                            AppLocalizations.of(context)!.out_of_5_stars(_rating),
                            style: TextStyle(
                              fontSize: Responsive.responsiveFontSize(context, 14),
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          SizedBox(height: Responsive.responsiveSpacing(context, 16)),

                          // Feedback Text Field
                          TextFormField(
                            controller: _feedbackController,
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.write_something_for_us,
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: Responsive.responsiveFontSize(context, 14),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  Responsive.responsiveBorderRadius(context, 8),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.grey.withValues(alpha: 0.2),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  Responsive.responsiveBorderRadius(context, 8),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.grey.withValues(alpha: 0.2),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  Responsive.responsiveBorderRadius(context, 8),
                                ),
                                borderSide: const BorderSide(
                                  color: Color(0xFF6C47FF),
                                  width: 1,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: Responsive.responsiveSpacing(context, 12),
                                vertical: Responsive.responsiveSpacing(context, 12),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: Responsive.responsiveSpacing(context, 32)),

                    // Done Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to home and clear all previous routes
                          Get.offAll(() => const HomeScreen());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6C47FF),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            vertical: Responsive.responsiveSpacing(context, 16),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              Responsive.responsiveBorderRadius(context, 12),
                            ),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.done,
                          style: TextStyle(
                            fontSize: Responsive.responsiveFontSize(context, 16),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Responsive.responsiveSpacing(context, 20)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
