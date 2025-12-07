class CategoryState {
  final List<String> categories;
  final int selectedIndex;

  const CategoryState({
    required this.categories,
    this.selectedIndex = 0,
  });

  CategoryState copyWith({
    List<String>? categories,
    int? selectedIndex,
  }) {
    return CategoryState(
      categories: categories ?? this.categories,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}
