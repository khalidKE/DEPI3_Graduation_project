class SearchState {
  final String query;
  final List<String> recentSearches;

  const SearchState({
    this.query = '',
    this.recentSearches = const [],
  });

  SearchState copyWith({
    String? query,
    List<String>? recentSearches,
  }) {
    return SearchState(
      query: query ?? this.query,
      recentSearches: recentSearches ?? this.recentSearches,
    );
  }
}
