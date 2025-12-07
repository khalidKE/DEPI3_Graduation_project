import 'package:books/features/category_feature/presentation/view_model/search_state.dart';
import 'package:books/features/category_feature/presentation/view_model/search_view_model.dart';
import 'package:books/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'category_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchViewModel(
        initialRecent: const ['The Good Sister', 'Carrie Fisher'],
      ),
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: _SearchAppBar(),
        ),
        body: const Padding(
          padding: EdgeInsets.all(23),
          child: _SearchBody(),
        ),
      ),
    );
  }
}

class _SearchAppBar extends StatelessWidget {
  const _SearchAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        AppLocalizations.of(context)!.search,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_outlined),
        onPressed: () {
          Navigator.pop(
            context,
            MaterialPageRoute(builder: (context) => const CategoryScreen()),
          );
        },
      ),
    );
  }
}

class _SearchBody extends StatelessWidget {
  const _SearchBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          onChanged: context.read<SearchViewModel>().updateQuery,
          onSubmitted: (value) =>
              context.read<SearchViewModel>().addRecent(value),
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.search,
            hintStyle: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey[500]!
                  : Colors.grey[600]!,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey[400]!
                  : const Color(0xFF54408C),
            ),
            filled: true,
            fillColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[900]!
                : Colors.grey[50]!,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[700]!
                    : Colors.grey[300]!,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[700]!
                    : Colors.grey[300]!,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF6C47FF), width: 2),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            AppLocalizations.of(context)!.recent_searches,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF121212),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: BlocBuilder<SearchViewModel, SearchState>(
            builder: (context, state) {
              if (state.recentSearches.isEmpty) {
                return Text(
                  AppLocalizations.of(context)?.search ?? 'Search',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[600],
                  ),
                );
              }
              return ListView.separated(
                itemCount: state.recentSearches.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      state.recentSearches[index],
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF8B8B97),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
