import 'package:books/features/category_feature/presentation/view_model/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryViewModel extends Cubit<CategoryState> {
  CategoryViewModel({required List<String> categories})
      : super(CategoryState(categories: categories));

  void selectCategory(int index) {
    if (index == state.selectedIndex || index < 0 || index >= state.categories.length) return;
    emit(state.copyWith(selectedIndex: index));
  }
}
