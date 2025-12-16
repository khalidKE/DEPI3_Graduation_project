import 'package:books/features/category_feature/data/category_utils.dart';
import 'package:books/features/category_feature/presentation/view_model/category_state.dart';
import 'package:books/features/category_feature/presentation/view_model/category_view_model.dart';
import 'package:books/features/home_feature/data/app_data.dart';
import 'package:books/features/home_feature/data/book_inventory.dart';
import 'package:books/features/home_feature/data/home_models.dart';
import 'package:books/l10n/app_localizations.dart';
import 'package:books/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class CategoryScreen extends StatelessWidget {
  final String initialCategory;

  const CategoryScreen({super.key, this.initialCategory = 'All'});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.all(screenWidth * 0.02),
          child: Text(
            localizations.category,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
      ),
        body: ValueListenableBuilder<List<Book>>(
        valueListenable: BookInventory.booksNotifier,
        builder: (context, books, _) {
          final categories = buildCategoryInfo(books, localizations);
          final selectedIndex = categories.indexWhere((info) => info.value == initialCategory);
          return BlocProvider(
            create: (_) => CategoryViewModel(
              categories: categories,
              selectedIndex: selectedIndex >= 0 ? selectedIndex : 0,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: Responsive.responsiveSpacing(context, 20),
                  ),
                  child: BlocBuilder<CategoryViewModel, CategoryState>(
                    builder: (context, state) {
                      return Wrap(
                        spacing: screenWidth * 0.03,
                        runSpacing: screenWidth * 0.03,
                        alignment: WrapAlignment.center,
                        children: List.generate(state.categories.length, (index) {
                          final info = state.categories[index];
                          final selected = state.selectedIndex == index;
                          return GestureDetector(
                            onTap: () => context.read<CategoryViewModel>().selectCategory(index),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.05,
                                vertical: screenWidth * 0.02,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: selected ? const Color(0xFF6C47FF) : Colors.grey[400]!,
                                  width: 1.5,
                                ),
                                color: selected ? const Color(0xFF6C47FF) : Colors.white,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    info.label,
                                    style: TextStyle(
                                      color: selected ? Colors.white : Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Icon(
                                    Icons.library_books,
                                    size: 18,
                                    color: selected ? Colors.white : const Color(0xFF6C47FF),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: BlocBuilder<CategoryViewModel, CategoryState>(
                    builder: (context, state) {
                      final selected = state.categories[state.selectedIndex].value;
                      final filteredBooks = selected.toLowerCase() == 'all'
                          ? books
                          : books.where((book) => book.category == selected).toList();
                      if (filteredBooks.isEmpty) {
                        return Center(
                          child: Text(
                            localizations.empty_state_no_books,
                            style: const TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        );
                      }
                      return ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                        itemCount: filteredBooks.length,
                        separatorBuilder: (_, __) => SizedBox(height: screenWidth * 0.03),
                        itemBuilder: (context, index) {
                          final book = filteredBooks[index];
                          return _CategoryBookCard(book: book);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryBookCard extends StatelessWidget {
  const _CategoryBookCard({required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final imageUrl = AppData.resolveBookImage(book);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: width * 0.04,
      ),
          child: Row(
            children: [
              Container(
                width: width * 0.18,
                height: width * 0.24,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[100],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: _CategoryBookCover(imageUrl: imageUrl),
                ),
              ),
              SizedBox(width: width * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: width * 0.01),
                Text(
                  book.author,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                SizedBox(height: width * 0.02),
                Text(
                  '\$${book.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Color(0xFF6C47FF),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryBookCover extends StatelessWidget {
  const _CategoryBookCover({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final trimmed = imageUrl.trim();
    if (trimmed.isEmpty) {
      return const Icon(Icons.book, color: Colors.grey);
    }
    final isNetwork = trimmed.startsWith('http');
    final placeholder = const Icon(Icons.book, color: Colors.grey);
    return isNetwork
        ? Image.network(
            trimmed,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => placeholder,
          )
        : Image.asset(
            trimmed,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => placeholder,
          );
  }
}
