import 'package:books/order_status2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';

class OrderStatus extends StatefulWidget {
  const OrderStatus({super.key});

  @override
  State<OrderStatus> createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFFFFFFF),
      body: Column(
        children: [
          Padding(
             padding: const EdgeInsets.only(top: 77,left: 24,right: 24),
            child: Container(
              height: 132,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 248, 248, 251)
              ),
            child: Image.asset("assets/images/Photo.png")
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, right: 60,left: 60),
            child: Row(
              children: [
                Text("Do you want to cancel your order?",style: TextStyle(
                  fontSize: 14,
                  color: Color(0XFFA6A6A6)
                ),),
                Text(" Cancel",style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0XFF54408C)))
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 24,top: 24),
              child: Text("Order Details",style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            )),
            SizedBox(height: 16,),
            SvgPicture.asset("assets/images/Vertical.svg"),
            Padding(
              padding: const EdgeInsets.only(top:78,right: 24,left: 24),
              child: InkWell(
                onTap: () {
                   Get.to(OrderStatus2());
                },
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(48),
                    color: Color(0XFFFAF9FD)
                  ),
                 child: Center(
                   child: InkWell(
                    onTap: () {
                      Get.to(OrderStatus2());
                    },
                     child: Text(" Order Status",style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0XFF54408C))),
                   ),
                 )
                ),
              ),
            )
        ],
      ),
    );
  }
}
