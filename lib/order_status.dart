import 'package:books/order_status2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


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
            Padding(
              padding: const EdgeInsets.only(left: 24,right: 24),
              child: Container(
                height: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color:Color(0XFFF5F5F5))
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 16,),
                          Text("1x ",style: TextStyle(fontSize: 15),),
                          SizedBox(width: 3,),
                          Text("Carrie Fisher",style: TextStyle(fontSize: 15)),
                          SizedBox(width:140,),
                          Text("19.99 USD",style: TextStyle(fontSize: 15))
                        ],
                      ),
                      SizedBox(height:8 ,),
                      Row(
                         children: [
                          SizedBox(width: 16,),
                          Text("1x ",style: TextStyle(fontSize: 15),),
                          SizedBox(width: 3,),
                          Text("The Da vinci Code",style: TextStyle(fontSize: 15)),
                          SizedBox(width:105,),
                          Text("39.99 USD",style: TextStyle(fontSize: 15))
                        ],                      
                      ),
                      SizedBox(height:8 ,),
                      Row(
                         children: [
                          SizedBox(width: 16,),
                          Text("1x ",style: TextStyle(fontSize: 15),),
                          SizedBox(width: 3,),
                          Text("Arcu ipsum feugiat leo odio ",style: TextStyle(fontSize: 15)),
                          SizedBox(width:36,),
                          Text("27.12 USD",style: TextStyle(fontSize: 15))
                        ],                      
                      ),
                      SizedBox(height: 16,),
                      Image.asset("assets/images/Line.png"),
                       SizedBox(height: 16,),
                     Row(
                      children: [
                        SizedBox(width:16 ,),
                        Text("Subtotal",style: TextStyle(fontSize: 14,fontWeight:FontWeight.bold),),
                        SizedBox(width:195,),
                        Text("87.10 USD",style: TextStyle(fontSize: 14,fontWeight:FontWeight.bold))
                      ],
                     ),
                     SizedBox(height: 16,),
                      Image.asset("assets/images/Line.png"),
                       SizedBox(height: 16,),
                       Row(
                      children: [
                        SizedBox(width:16 ,),
                        Text("Shipping",style: TextStyle(fontSize: 14,fontWeight:FontWeight.bold),),
                        SizedBox(width:220,),
                        Text("2 USD",style: TextStyle(fontSize: 14,fontWeight:FontWeight.bold))
                      ],
                     ),
                      SizedBox(height: 16,),
                      Image.asset("assets/images/Line.png"),
                       SizedBox(height: 16,),
                       Row(
                      children: [
                        SizedBox(width:16 ,),
                        Text("Total Payment",style: TextStyle(fontSize: 14,fontWeight:FontWeight.bold),),
                        SizedBox(width:160),
                        Text("89.10 USD",style: TextStyle(fontSize: 14,fontWeight:FontWeight.bold))
                      ],
                     ),
                     SizedBox(height:8 ,),
                     Row(
                      children: [
                        SizedBox(width:16 ,),
                        Text("Delivery in",style: TextStyle(fontSize: 14),),
                        SizedBox(width:185),
                        Text("10 - 15 mins",style: TextStyle(fontSize: 14))
                      ],
                     ),
                      SizedBox(height:8 ,),
                     Row(
                      children: [
                        SizedBox(width:16 ,),
                        Text("Time",style: TextStyle(fontSize: 14),),
                        SizedBox(width:217),
                        Text("15.24 - 15.39",style: TextStyle(fontSize: 14))
                      ],
                     ),
                    ],
                  ),
                ),
              ),
            ),
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