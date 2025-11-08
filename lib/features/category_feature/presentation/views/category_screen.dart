import 'package:flutter/material.dart';
import '../../../../const.dart';
import '../../../../custom_screen.dart';
import 'search_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool obsecuretext = true;
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.search_outlined),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchScreen()),
            );
          },
        ),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Text(
            'Category',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: IconButton(
              icon: Icon(Icons.notification_add_outlined),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const <Widget>[
                    Text(
                      'All',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationThickness: 2,
                      ),
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Novel',
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                    SizedBox(width: 6),
                    Text(
                      'SelfLove',
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Science',
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Romantic',
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    CustomContainer(
                      imagePath: 'assets/images/image1.png',
                      book: 'The Da vinci Code',
                      price: '\$19.99',
                    ),
                    CustomContainer(
                      imagePath: 'assets/images/image2.png',
                      book: 'Carrie Fisher',
                      price: '\$27.12',
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    CustomContainer(
                      imagePath: 'assets/images/image3.png',
                      book: 'The Good Sister',
                      price: '\$27.12',
                    ),
                    CustomContainer(
                      imagePath: 'assets/images/image4.png',
                      book: 'The Waiting',
                      price: '\$27.12',
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    CustomContainer(
                      imagePath: 'assets/images/image5.png',
                      book: 'where are you',
                      price: '\$15',
                    ),
                    CustomContainer(
                      imagePath: 'assets/images/image6.png',
                      book: 'Bright',
                      price: '\$12',
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
