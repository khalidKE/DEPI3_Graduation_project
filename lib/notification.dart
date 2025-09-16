import 'package:books/promotion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

  class NotificationPage extends StatefulWidget {
    const NotificationPage({super.key});

    @override
    State<NotificationPage> createState() => _NotificationPageState();
  }

  class _NotificationPageState extends State<NotificationPage> {
    @override
    Widget build(BuildContext context) {
      return DefaultTabController(
        length: 2
      , child: Scaffold(
        appBar: appbar(),
        body: TabBarView(
          children:[
           SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 24,right: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 42,),
                  Text("Current",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  SizedBox(height: 16,),
                  delievryContainers(film: 'The Da vinci Code', status: 'On the way', quantity: '1 itmes', poster: 'assets/images/Image.png'),
                  SizedBox(height: 24,),
                  Text("October 2024",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  SizedBox(height: 16,),
                  delievryContainers(film: 'Carrie Fisher', status: 'Delivered', quantity: '1 itmes', poster: 'assets/images/Rectangle.png'),
                  delievryContainers(film: 'The Waiting', status: 'Delivered', quantity: '5 items', poster: 'assets/images/Rectanglee.png'),
                  delievryContainers(film: 'Bright Young', status: 'Cancelled', quantity: '2 items', poster: 'assets/images/Recatngleee.png')
                ],
                ),
              ),
            ),
           SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(right: 24,left: 24),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              SizedBox(height: 42,),
              Text("October 2025",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),     
              SizedBox(height: 16,),
              InkWell(
                onTap: () {
                  Get.to(PromotionPage());
                },
                child: newsPromotionRow(text: 'Promotion', date: 'Oct 24', time: '08.00')), 
              SizedBox(height: 8,),
              InkWell(
                onTap: () {
                  Get.to(PromotionPage());
                },
                child: RichText(
                text: TextSpan(
                  style: TextStyle(color:Colors.black,fontSize:14 ),
                  children: [
                    TextSpan(text: "Today "),
                    TextSpan(text: "50% discount ",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: "on all Books in Novel category with online orders worldwide.")
                  ])),
              ),

                  SizedBox(height:16 ,),
                  Image.asset("assets/images/Line.png"),
                  SizedBox(height: 16,),

                  newsPromotionRow(text: 'Promotion', date: 'Oct 08', time: '20.30'),
              SizedBox(height: 8,),
               RichText(
                             text: TextSpan(
                style: TextStyle(color:Colors.black,fontSize:14 ),
                children: [
                  TextSpan(text: "Buy 2 get 1 free ",
                  style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: "or since books from 08 - 10 October 2025.")
                ])),
              
              SizedBox(height: 24,),
                         Text("September 2025",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),     
                         SizedBox(height: 16,),   
              
                         newsPromotionRow(text: 'Information', date: 'Sept 16', time: '11.00'),
                         SizedBox(height: 8,),
                         Text("There is a new book now available ")
                     ],
                     ),
            ),
       ),
          ]) ,
      )
      );
    }



 
 Row newsPromotionRow({
    required String text,
    required String date,
    required String time,
  }) {
      final Map<String, Color> textColors = {
    "promotion":Color(0XFF54408C), 
    "information": Color(0XFF3784FB),
  };
  Color textColor = textColors[text.toLowerCase()] ?? Colors.black;

    return Row(
           children: [
             Text(text,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: textColor,)),
            Spacer(),
             Text(date,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Color(0XFFA6A6A6)),),
             SizedBox(width: 6,),
             Container(
                      height: 5,
                      width: 5,
                      decoration: BoxDecoration(
                        color:Color(0XFFA6A6A6) ,
                        borderRadius: BorderRadius.circular(100)
                      ),
                     ),
          SizedBox(width: 6,),
          Text(time,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Color(0XFFA6A6A6)),),
           ],
         );
  }


  Container delievryContainers({
    required String film,
    required String status,
    required String quantity,
    required String poster,
  }) {
      final Map<String, Color> statusColors = {
    "on the way": Color(0xFF3784FB), 
    "delivered": Color(0XFF18A057),
    "cancelled": Color(0XFFEF5A56),
  };
  Color statusColor = statusColors[status.toLowerCase()] ?? Colors.black; 
  
      return Container(
            padding: EdgeInsets.only(left:16),
            height: 80,
            width:327,
            decoration: BoxDecoration( 
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color.fromARGB(255, 225, 222, 222))
            ),
          child: Row(
            children: [
             Image.asset(poster,),
             SizedBox(width: 16,),
             Padding(
               padding: const EdgeInsets.only(top:16),
               child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(film,
                   style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold),),
                   Row(
                     children: [
                       Text(status,
                       style: TextStyle(
                        fontSize: 14,
                        color: statusColor,
                        fontWeight: FontWeight.bold),),
                       SizedBox(width: 8,),
                       Container(
                        height: 5,
                        width: 5,
                        decoration: BoxDecoration(
                          color:Color(0XFFE8E8E8) ,
                          borderRadius: BorderRadius.circular(100)
                        ),
                       ),
                       SizedBox(width: 8,),
                       Text(quantity,
                       style: TextStyle(
                        color: Color(0XFF7A7A7A),
                        fontWeight: FontWeight.bold,
                        fontSize: 14),)
                     ],
                   )
                 ],
               ),
             )
            ],
          ),
          );
  }


  AppBar appbar() {
    return AppBar(
      leading: InkWell(
        onTap: () {
         // navigate to home page
        },
        child: Icon(Icons.arrow_back)),
    title: Text("Notification",style: TextStyle(fontWeight: FontWeight.bold),),
    titleSpacing: 71,
    bottom: TabBar( 
      tabs: [
        Tab(text: "Delievry",),
        Tab(text: "News",),
      ]
    ),
    );
  }
}