import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class PromotionPage extends StatefulWidget {
  const PromotionPage({super.key});

  @override
  State<PromotionPage> createState() => _PromotionPageState();
}

class _PromotionPageState extends State<PromotionPage> {
  @override
  Widget build(BuildContext context) {
     var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
        onTap: () {
         navigator?.pop(context);
        },
        child: Icon(Icons.arrow_back)),
    title: Text("Promotion",style: TextStyle(fontWeight: FontWeight.bold),),
    titleSpacing: 71,
      ),
     body: SingleChildScrollView(
           child: Padding(
             padding: const EdgeInsets.only(left: 30,top: 30),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                promoContainer(),
                SizedBox(height: height*.03,),
                Text("Today 50% discount on all books in Chapter with online orders", style:TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),),
                SizedBox(height:height*.02,),
                Text("Excuse me… Who could ever resist a discount feast?   👀",style: TextStyle(
                  fontSize: 14,
                  color: Color(0XFF7A7A7A)
                ),),
                SizedBox(height:height*.02,),
                Text("Hear me out. Today, October 24, 2025, Chapter has a 50% discount for any book. What are you waiting for, let's order now before it runs out.",style: TextStyle(
                  fontSize: 14,
                  color: Color(0XFF7A7A7A)
                ),),
                SizedBox(height:height*.02,),
                Text("All books are discounted, just order through the Chapter app to enjoy this discount. From bestsellers to timeless classics, we’ve prepared the best collection for you. Discover, read, and enjoy your next great book with Chapter.",style: TextStyle(
                  fontSize: 14,
                  color: Color(0XFF7A7A7A)
                ),),
                SizedBox(height:height*.02,),
                 Text("So, what’s your pick? 📖 Don’t miss out—order your next read today 😉",style: TextStyle(
                  fontSize: 14,
                  color: Color(0XFF7A7A7A)
                ),),
                 ],
             ),
           ),
           ),
    );
  }


  
  Container promoContainer() {
    var width = MediaQuery.sizeOf(context).width;
    return Container(
            height: 210,
            width: 360,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 247, 244, 255),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30,top: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("50% Discount",style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0XFF54408C)
                      ),),
                      Text("On All Books",style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0XFF54408C)
                      ),),
                      SizedBox(height: 4,),
                      Text("Grab it now!",style: TextStyle(
                        fontSize: 14,
                        color: Color(0XFF54408C),
                      ),),
                      SizedBox(height: 32,),
                      Container(
                        height: 36,
                        width: 118,
                        decoration: BoxDecoration(
                          color: Color(0XFF54408C),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Center(child: InkWell(
                          onTap: () {
                            // navigate to home page 
                          },
                          child: Text("Shop Now",style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                          ),),
                        )),
                      )  
                    ],
                  ),
                ),
                SizedBox(width: width*.06,),
                Image.asset("assets/images/Frame.png"),
              ],
            ),
          );
  }

}