import 'package:books/features/category_feature/presentation/view_model/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchViewModel extends Cubit<SearchState> {
  SearchViewModel({List<String>? initialRecent})
      : super(SearchState(recentSearches: initialRecent ?? const []));

  void updateQuery(String query) {
    emit(state.copyWith(query: query));
  }

  void addRecent(String term) {
    if (term.trim().isEmpty) return;
    final updated = [term, ...state.recentSearches.where((e) => e != term)];
    emit(state.copyWith(recentSearches: updated.take(10).toList()));
  }
}
