import 'package:books/features/home_feature/data/app_data.dart';
import 'package:books/features/home_feature/data/book_inventory.dart';
import 'package:books/features/home_feature/data/favorites_notifier.dart';
import 'package:books/features/home_feature/data/home_models.dart';
import 'package:books/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: width * 0.07,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        toolbarHeight: width * 0.16,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context)!.your_favorites,
              style: GoogleFonts.openSans(
                fontWeight: FontWeight.w700,
                fontSize: width * 0.045,
                color: Colors.black,
              ),
            ),
            SizedBox(width: width * 0.02),
            Container(
              width: width * 0.1,
              height: width * 0.1,
              decoration: const BoxDecoration(
                color: Color(0xFF6C47FF),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/Heart.svg',
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  width: width * 0.04,
                ),
              ),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: ValueListenableBuilder<Set<String>>(
        valueListenable: FavoritesNotifier.instance,
        builder: (context, favorites, _) {
          final books = BookInventory.booksNotifier.value
              .where((book) => favorites.contains(book.id))
              .toList();
          if (books.isEmpty) {
            return Center(
              child: Text(
                AppLocalizations.of(context)!.empty_state_no_favorites,
                style: GoogleFonts.roboto(
                  fontSize: width * 0.04,
                  color: Colors.grey[600],
                ),
              ),
            );
          }
          return ListView.separated(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.04,
              vertical: width * 0.03,
            ),
            itemBuilder: (context, index) {
              final book = books[index];
              return _FavoriteBookTile(book: book);
            },
            separatorBuilder: (_, __) => SizedBox(height: width * 0.04),
            itemCount: books.length,
          );
        },
      ),
    );
  }
}

class _FavoriteBookTile extends StatelessWidget {
  const _FavoriteBookTile({required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        border: Border.all(color: Colors.grey[200]!),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.15),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: width * 0.03,
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(width * 0.02),
            child: SvgPicture.asset(
              'assets/images/Heart.svg',
              colorFilter:
                  const ColorFilter.mode(Color(0xFF6C47FF), BlendMode.srcIn),
              width: width * 0.05,
            ),
          ),
          SizedBox(width: width * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.04,
                  ),
                ),
                Text(
                  book.author,
                  style: GoogleFonts.roboto(
                    color: Colors.grey[600],
                    fontSize: width * 0.033,
                  ),
                ),
                SizedBox(height: width * 0.01),
                Text(
                  '\$${book.price.toStringAsFixed(2)}',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w600,
                    fontSize: width * 0.035,
                    color: const Color(0xFF6C47FF),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: width * 0.02),
          _FavoriteCover(imageUrl: AppData.resolveBookImage(book)),
        ],
      ),
    );
  }
}

class _FavoriteCover extends StatelessWidget {
  const _FavoriteCover({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final trimmed = imageUrl.trim();
    final isNetwork = trimmed.startsWith('http');

    final child = isNetwork
        ? Image.network(
            trimmed,
            width: width * 0.2,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) =>
                const Icon(Icons.book, color: Colors.grey),
          )
        : Image.asset(
            trimmed,
            width: width * 0.2,
            fit: BoxFit.cover,
          );

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: child,
    );
  }
}
