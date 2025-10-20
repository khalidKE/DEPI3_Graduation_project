import 'dart:math';
import 'package:flutter/material.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Spacer(),

            // Gift Box Image from assets
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF6C47FF).withOpacity(0.08),
                borderRadius: BorderRadius.circular(60),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.asset(
                  'lib/image/img1.jpg',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Order Confirmation Text
            const Text(
              'You Received The Order!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            // 🔢 رقم الأوردر العشوائي
            Text(
              'Order #$_orderNumber',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),

            // Feedback Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF6C47FF).withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFF6C47FF).withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tell us your feedback ✨',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6C47FF),
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Lorem ipsum dolor sit amet consectetur. Dignissim magna vitae.',
                    style: TextStyle(fontSize: 14, color: Color(0xFF6C47FF)),
                  ),

                  const SizedBox(height: 16),

                  // ⭐ تقييم النجوم
                  Row(
                    children: List.generate(5, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _rating = index + 1;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.star,
                            color: index < _rating
                                ? Colors.amber
                                : Colors.grey.withOpacity(0.3),
                            size: 24,
                          ),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 16),

                  // Feedback Text Field
                  TextFormField(
                    controller: _feedbackController,
                    decoration: InputDecoration(
                      hintText: 'Write something for us!',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(
                          color: Color(0xFF6C47FF),
                          width: 1,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    maxLines: 3,
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Done Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate back to home (pop until first route)
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C47FF),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Done',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
