import 'package:books/features/category_feature/data/category_info.dart';

class CategoryState {
  final List<CategoryInfo> categories;
  final int selectedIndex;

  const CategoryState({
    required this.categories,
    this.selectedIndex = 0,
  });

  CategoryState copyWith({
    List<CategoryInfo>? categories,
    int? selectedIndex,
  }) {
    return CategoryState(
      categories: categories ?? this.categories,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}
