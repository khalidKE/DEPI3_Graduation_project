import 'package:flutter/material.dart';

class DeliveryContainers extends StatelessWidget {
  const DeliveryContainers({
    super.key,
    required this.film,
    required this.status,
    required this.quantity,
    required this.poster,
  });

  final String film;
  final String status;
  final String quantity;
  final String poster;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final Map<String, Color> statusColors = {
      "on the way": const Color(0xFF3784FB),
      "delivered": const Color(0XFF18A057),
      "cancelled": const Color(0XFFEF5A56),
    };
    Color statusColor = statusColors[status.toLowerCase()] ?? Colors.black;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      height: width * 0.22,
      width: width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width * 0.02),
        border: Border.all(color: const Color(0xffebebeb)),
      ),
      child: Row(
        children: [
          
          Image.asset(
            poster,
            width: width * 0.15,
            height: width * 0.15,
            fit: BoxFit.cover,
          ),
          SizedBox(width: width * 0.04),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: width * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    film,
                    style: TextStyle(
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: width * 0.01),
                  Row(
                    children: [
                      Text(
                        status,
                        style: TextStyle(
                          fontSize: width * 0.035,
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: width * 0.02),
                      Container(
                        height: width * 0.012,
                        width: width * 0.012,
                        decoration: BoxDecoration(
                          color: const Color(0XFFE8E8E8),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      SizedBox(width: width * 0.02),
                      Text(
                        quantity,
                        style: TextStyle(
                          fontSize: width * 0.035,
                          color: const Color(0XFF7A7A7A),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}