import 'package:books/core/utils/responsive.dart';
import 'package:books/features/category_feature/data/category_info.dart';
import 'package:books/features/category_feature/data/category_utils.dart';
import 'package:books/features/category_feature/presentation/views/category_screen.dart';
import 'package:books/features/home_feature/data/book_inventory.dart';
import 'package:books/features/home_feature/data/home_models.dart';
import 'package:books/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  void _openCategoryScreen(BuildContext context, String categoryValue) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CategoryScreen(initialCategory: categoryValue),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.category,
          style: TextStyle(
            fontSize: Responsive.responsiveFontSize(context, 20),
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: const [],
      ),
      body: ValueListenableBuilder<List<Book>>(
        valueListenable: BookInventory.booksNotifier,
        builder: (context, books, _) {
          final categories = buildCategoryInfo(books, localizations);
          return Padding(
            padding: Responsive.responsivePadding(context),
            child: _CategoriesOverview(
              categories: categories,
              onCategoryTap: (value) => _openCategoryScreen(context, value),
            ),
          );
        },
      ),
    );
  }
}

class _CategoriesOverview extends StatefulWidget {
  const _CategoriesOverview({
    required this.categories,
    required this.onCategoryTap,
  });

  final List<CategoryInfo> categories;
  final ValueChanged<String> onCategoryTap;

  @override
  State<_CategoriesOverview> createState() => _CategoriesOverviewState();
}

class _CategoriesOverviewState extends State<_CategoriesOverview> {
  int _selectedIndex = 0;

  void _handleTap(int index) {
    setState(() => _selectedIndex = index);
    widget.onCategoryTap(widget.categories[index].value);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.responsiveSpacing(context, 20),
            vertical: Responsive.responsiveSpacing(context, 16),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              Responsive.responsiveBorderRadius(context, 16),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(
                Icons.book_outlined,
                size: Responsive.responsiveIconSize(context, 48),
                color: const Color(0xFF6C47FF),
              ),
              SizedBox(height: Responsive.responsiveSpacing(context, 8)),
              Text(
                localizations.browse_categories,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Responsive.responsiveFontSize(context, 18),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: Responsive.responsiveSpacing(context, 24)),
        LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
            final spacing = Responsive.responsiveSpacing(context, 10);
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: spacing,
                mainAxisSpacing: spacing,
                childAspectRatio: 2.6,
              ),
              itemCount: widget.categories.length,
              itemBuilder: (context, index) {
                final info = widget.categories[index];
                final selected = index == _selectedIndex;
                return _CategoryTile(
                  label: info.label,
                  selected: selected,
                  onTap: () => _handleTap(index),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = selected ? const Color(0xFF6C47FF) : Colors.grey[300]!;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: 1.4),
          color: selected ? const Color(0xFF6C47FF) : Colors.white,
          boxShadow: [
            if (!selected)
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.15),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: selected ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(width: 7),
            Icon(
              Icons.menu_book_outlined,
              size: 18,
              color: selected ? Colors.white : const Color(0xFF6C47FF),
            ),
          ],
        ),
      ),
    );
  }
}
