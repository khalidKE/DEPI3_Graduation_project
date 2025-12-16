import 'package:books/features/category_feature/data/category_info.dart';
import 'package:books/features/category_feature/presentation/view_model/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryViewModel extends Cubit<CategoryState> {
  CategoryViewModel({
    required List<CategoryInfo> categories,
    int selectedIndex = 0,
  }) : super(
          CategoryState(
            categories: categories,
            selectedIndex: selectedIndex.clamp(
              0,
              categories.isEmpty ? 0 : categories.length - 1,
            ),
          ),
        );

  void selectCategory(int index) {
    if (index == state.selectedIndex || index < 0 || index >= state.categories.length) return;
    emit(state.copyWith(selectedIndex: index));
  }
}
