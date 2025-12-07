import 'package:books/features/category_feature/presentation/view_model/category_state.dart';
import 'package:books/features/category_feature/presentation/view_model/category_view_model.dart';
import 'package:books/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'search_screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final categories = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.novel,
      AppLocalizations.of(context)!.self_love,
      AppLocalizations.of(context)!.science,
      AppLocalizations.of(context)!.romantic,
    ];

    return BlocProvider(
      create: (_) => CategoryViewModel(categories: categories),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.search_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
          ),
          title: Padding(
            padding: EdgeInsets.all(screenWidth * 0.02),
            child: Text(
              AppLocalizations.of(context)!.category,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.03),
              child: IconButton(
                icon: const Icon(Icons.notification_add_outlined),
                onPressed: () {},
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.03),
                child: BlocBuilder<CategoryViewModel, CategoryState>(
                  builder: (context, state) {
                    return Wrap(
                      spacing: screenWidth * 0.03,
                      runSpacing: screenHeight * 0.01,
                      alignment: WrapAlignment.center,
                      children: List.generate(state.categories.length, (index) {
                        return GestureDetector(
                          onTap: () => context.read<CategoryViewModel>().selectCategory(index),
                          child: Column(
                            children: [
                              Text(
                                state.categories[index],
                                style: TextStyle(
                                  fontSize: screenWidth * 0.04,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                height: 2,
                                width: state.selectedIndex == index ? 20 : 0,
                                decoration: BoxDecoration(
                                  color: const Color(0xff54408c),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                child: Column(
                  children: [
                    bookRow(screenWidth),
                    SizedBox(height: screenHeight * 0.02),
                    bookRow(screenWidth, startIndex: 2),
                    SizedBox(height: screenHeight * 0.02),
                    bookRow(screenWidth, startIndex: 4),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bookRow(double screenWidth, {int startIndex = 0}) {
    final books = [
      {'image': 'assets/images/image1.png', 'title': 'The Da Vinci Code', 'price': '\$19.99'},
      {'image': 'assets/images/image2.png', 'title': 'Carrie Fisher', 'price': '\$27.12'},
      {'image': 'assets/images/image3.png', 'title': 'The Good Sister', 'price': '\$27.12'},
      {'image': 'assets/images/image4.png', 'title': 'The Waiting', 'price': '\$27.12'},
      {'image': 'assets/images/image5.png', 'title': 'Where Are You', 'price': '\$15'},
      {'image': 'assets/images/image6.png', 'title': 'Bright', 'price': '\$12'},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildBookItem(books[startIndex]['image']!, books[startIndex]['title']!, books[startIndex]['price']!),
        buildBookItem(books[startIndex + 1]['image']!, books[startIndex + 1]['title']!, books[startIndex + 1]['price']!),
      ],
    );
  }

  Widget buildBookItem(String imagePath, String book, String price) {
    return Container(
      height: 214,
      width: 158,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(imagePath, height: 158, fit: BoxFit.cover),
          ),
          const SizedBox(height: 8),
          Text(
            book,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 4),
          Text(
            price,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xdd54408c),
            ),
          ),
        ],
      ),
    );
  }
}
