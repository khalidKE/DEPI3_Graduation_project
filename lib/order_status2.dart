import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class OrderStatus2 extends StatefulWidget {
  const OrderStatus2({super.key});

  @override
  State<OrderStatus2> createState() => _OrderStatus2State();
}

class _OrderStatus2State extends State<OrderStatus2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 120,left:30,right: 24),
        child: Column(
          children: [
            SvgPicture.asset("assets/images/Verticall.svg"),
            SizedBox(height: 24,),
            Container(
              height: 232,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 248, 248, 251)
              ),
             child:  Image.asset("assets/images/Completed.png")
            ),
            SizedBox(height: 24,),
            InkWell(
              onTap: () {
                 //   Get.to(homepage);
              },
              child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(48),
                    color: Color(0XFFF54408C)
                  ),
                 child: Center(
                   child: InkWell(
                    onTap: () {
                   //   Get.to(homepage);
                    },
                     child: Text(" Done ",style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color:Colors.white)),
                   ),
                 )
                ),
            ),
          ],
        ),
      )
    );
  }
}
