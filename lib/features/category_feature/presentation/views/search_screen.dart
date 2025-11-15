import 'package:books/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'category_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool obsecuretext = true;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.search,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_outlined),
            onPressed: () {
              Navigator.pop(
                context,
                MaterialPageRoute(builder: (context) => CategoryScreen()),
              );
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(23),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFE8E8E8),
                prefixIcon: Icon(Icons.search),
                iconColor: Color(0xFFA6A6A6),
                hintText: AppLocalizations.of(context)!.search,
                hintStyle: const TextStyle(color: Color(0xFFA6A6A6)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    AppLocalizations.of(context)!.recent_searches,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF121212),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    "The Good Sister",
                    style: TextStyle(fontSize: 15, color: Color(0xFF8B8B97)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    "Carries Fisher",
                    style: TextStyle(fontSize: 15, color: Color(0xFF8B8B97)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
