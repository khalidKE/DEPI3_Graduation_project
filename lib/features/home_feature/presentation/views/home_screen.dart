import 'package:books/features/cart_feature/presentation/views/cart_screen.dart';
import 'package:books/features/cart_feature/presentation/views/orders_screen.dart';
import 'package:books/features/home_feature/data/app_data.dart';
import 'package:books/features/home_feature/data/home_models.dart';
import 'package:books/features/home_feature/presentation/view_model/home_state.dart';
import 'package:books/features/home_feature/presentation/view_model/home_view_model.dart';
import 'package:books/features/notification_feature/presentation/views/notification.dart';
import 'package:books/features/profile_feature/presentation/views/profile.dart';
import 'package:books/l10n/app_localizations.dart';
import 'package:books/core/utils/responsive.dart';
import 'package:books/core/widgets/language_toggle.dart';
import 'package:books/core/widgets/theme_toggle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeViewModel(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.home,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontWeight: FontWeight.w600,
            fontSize: Responsive.responsiveFontSize(context, 18),
          ),
        ),
        centerTitle: true,
        leading: const ThemeToggleButton(),
        actions: [
          const LanguageToggleButton(),
          IconButton(
            icon: Icon(
              Icons.notifications_outlined,
              size: Responsive.responsiveIconSize(context, 24),
            ),
            onPressed: () {
              Get.to(() => const NotificationPage());
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = Responsive.maxContentWidth(context);
          return SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth ?? double.infinity),
                child: Padding(
                  padding: Responsive.responsivePadding(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _SpecialOfferBanner(),
                      _SectionHeader(title: AppLocalizations.of(context)!.top_of_week),
                      const _TopOfWeekBooks(),
                      SizedBox(height: Responsive.responsiveSpacing(context, 12)),
                      _SectionHeader(
                        title: AppLocalizations.of(context)!.best_vendors,
                        showSeeAll: true,
                        onSeeAll: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const VendorsScreen()),
                        ),
                      ),
                      const _VendorsSection(),
                      SizedBox(height: Responsive.responsiveSpacing(context, 12)),
                      _SectionHeader(
                        title: AppLocalizations.of(context)!.authors,
                        showSeeAll: true,
                        onSeeAll: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const AuthorsScreen()),
                        ),
                      ),
                      const _AuthorsSection(),
                      SizedBox(height: Responsive.responsiveSpacing(context, 20)),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<HomeViewModel, HomeState>(
        builder: (context, state) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: const Color(0xFF6C47FF),
            unselectedItemColor: Colors.grey,
            currentIndex: state.currentIndex,
            onTap: (index) async {
              final viewModel = context.read<HomeViewModel>();

              if (index == 0) {
                viewModel.selectIndex(0);
                return;
              }

              switch (index) {
                case 0:
                  break;
                case 1:
                  await Get.to(() => const OrdersScreen());
                  break;
                case 2:
                  await Get.to(() => const CartScreen());
                  break;
                case 3:
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profile()),
                  );
                  break;
              }

              // Always return the highlight to "Home" after leaving other tabs
              viewModel.selectIndex(0);
            },
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: AppLocalizations.of(context)!.home,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.shopping_bag_outlined),
                label: AppLocalizations.of(context)!.order,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.shopping_cart_outlined),
                label: AppLocalizations.of(context)!.cart,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.person_outline),
                label: AppLocalizations.of(context)!.profile,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SpecialOfferBanner extends StatelessWidget {
  const _SpecialOfferBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Responsive.responsiveMargin(context),
      padding: Responsive.responsivePadding(context),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF5B4DB5), Color(0xFF7B6BC4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(
          Responsive.responsiveBorderRadius(context, 16),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.special_offer,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Responsive.responsiveFontSize(context, 20),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Responsive.responsiveSpacing(context, 4)),
                Text(
                  AppLocalizations.of(context)!.discover_25_percent,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: Responsive.responsiveFontSize(context, 14),
                  ),
                ),
                SizedBox(height: Responsive.responsiveSpacing(context, 12)),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF5B4DB5),
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.responsiveSpacing(context, 24),
                      vertical: Responsive.responsiveSpacing(context, 10),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        Responsive.responsiveBorderRadius(context, 20),
                      ),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.order_now,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: Responsive.responsiveFontSize(context, 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: Responsive.responsiveSpacing(context, 16)),
          ClipRRect(
            borderRadius: BorderRadius.circular(
              Responsive.responsiveBorderRadius(context, 8),
            ),
            child: Container(
              width: Responsive.responsiveImageSize(context, 90),
              height: Responsive.responsiveImageSize(context, 130),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(
                  Responsive.responsiveBorderRadius(context, 8),
                ),
              ),
              child: Icon(
                Icons.menu_book,
                size: Responsive.responsiveIconSize(context, 50),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    this.showSeeAll = false,
    this.onSeeAll,
  });

  final String title;
  final bool showSeeAll;
  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.responsiveSpacing(context, 16),
        vertical: Responsive.responsiveSpacing(context, 8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: Responsive.responsiveFontSize(context, 18),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (showSeeAll)
            TextButton(
              onPressed: onSeeAll,
              child: Text(
                AppLocalizations.of(context)!.see_all,
                style: TextStyle(
                  color: const Color(0xFF5B4DB5),
                  fontWeight: FontWeight.w500,
                  fontSize: Responsive.responsiveFontSize(context, 14),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _TopOfWeekBooks extends StatelessWidget {
  const _TopOfWeekBooks();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 3,
        itemBuilder: (context, index) {
          final book = AppData.books[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetailScreen(book: book),
                ),
              );
            },
            child: Container(
              width: 130,
              margin: const EdgeInsets.only(right: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 160,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: book.imageUrl.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              book.imageUrl,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.broken_image,
                                  size: 50,
                                  color: Colors.grey[400],
                                );
                              },
                            ),
                          )
                        : Icon(
                            Icons.menu_book_rounded,
                            size: 50,
                            color: Colors.grey[400],
                          ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    book.title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${book.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5B4DB5),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _VendorsSection extends StatelessWidget {
  const _VendorsSection();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: AppData.vendors.length,
        itemBuilder: (context, index) {
          final vendor = AppData.vendors[index];
          return Container(
            width: 90,
            margin: const EdgeInsets.only(right: 16),
            child: Column(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: vendor.imageUrl.isNotEmpty
                      ? ClipOval(
                          child: Image.asset(
                            vendor.imageUrl,
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Text(
                                  vendor.name[0],
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Center(
                          child: Text(
                            vendor.name[0],
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                ),
                const SizedBox(height: 8),
                Text(
                  vendor.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star,
                        size: 14, color: Colors.amber.withValues(alpha: 0.9)),
                    const SizedBox(width: 4),
                    Text(
                      vendor.rating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _AuthorsSection extends StatelessWidget {
  const _AuthorsSection();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: AppData.authors.length,
        itemBuilder: (context, index) {
          final author = AppData.authors[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AuthorDetailScreen(author: author),
                ),
              );
            },
            child: Container(
              width: 140,
              margin: const EdgeInsets.only(right: 12),
              child: Column(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                    ),
                    child: author.imageUrl.isNotEmpty
                        ? ClipOval(
                            child: Image.asset(
                              author.imageUrl,
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Text(
                                    author.name[0],
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Center(
                            child: Text(
                              author.name[0],
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    author.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    author.role,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class BookDetailScreen extends StatelessWidget {
  const BookDetailScreen({super.key, required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.book_details),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: Responsive.responsivePadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 220,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
              ),
              child: book.imageUrl.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        book.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Icon(Icons.menu_book, size: 80, color: Colors.grey[500]),
            ),
            SizedBox(height: Responsive.responsiveSpacing(context, 16)),
            Text(
              book.title,
              style: TextStyle(
                fontSize: Responsive.responsiveFontSize(context, 22),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Responsive.responsiveSpacing(context, 8)),
            Text(
              book.author,
              style: TextStyle(
                fontSize: Responsive.responsiveFontSize(context, 16),
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: Responsive.responsiveSpacing(context, 12)),
            Row(children: _buildStars(book.rating)),
            SizedBox(height: Responsive.responsiveSpacing(context, 16)),
            Text(
              book.description,
              style: TextStyle(
                fontSize: Responsive.responsiveFontSize(context, 14),
                color: Colors.grey[700],
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildStars(double rating) {
    return List.generate(5, (index) {
      if (index < rating.floor()) {
        return const Icon(Icons.star, size: 18, color: Colors.amber);
      } else if (index < rating) {
        return const Icon(Icons.star_half, size: 18, color: Colors.amber);
      } else {
        return const Icon(Icons.star_border, size: 18, color: Colors.amber);
      }
    });
  }
}

class VendorsScreen extends StatelessWidget {
  const VendorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppLocalizations.of(context)!.best_vendors,
          style: TextStyle(
            fontSize: Responsive.responsiveFontSize(context, 18),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GridView.builder(
        padding: Responsive.responsivePadding(context),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: AppData.vendors.length,
        itemBuilder: (context, index) {
          final vendor = AppData.vendors[index];
          return Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: Colors.grey[200],
                  backgroundImage:
                      vendor.imageUrl.isNotEmpty ? AssetImage(vendor.imageUrl) : null,
                  child: vendor.imageUrl.isEmpty
                      ? Text(
                          vendor.name[0],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                ),
                const SizedBox(height: 8),
                Text(
                  vendor.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.star, size: 16, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(vendor.rating.toStringAsFixed(1)),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class AuthorsScreen extends StatelessWidget {
  const AuthorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppLocalizations.of(context)!.authors,
          style: TextStyle(
            fontSize: Responsive.responsiveFontSize(context, 18),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        padding: Responsive.responsivePadding(context),
        itemCount: AppData.authors.length,
        itemBuilder: (context, index) {
          final author = AppData.authors[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey[200],
                backgroundImage:
                    author.imageUrl.isNotEmpty ? AssetImage(author.imageUrl) : null,
                child: author.imageUrl.isEmpty
                    ? Text(
                        author.name[0],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    : null,
              ),
              title: Text(author.name),
              subtitle: Text(author.role),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AuthorDetailScreen(author: author),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class AuthorDetailScreen extends StatelessWidget {
  const AuthorDetailScreen({super.key, required this.author});

  final Author author;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          author.name,
          style: TextStyle(
            fontSize: Responsive.responsiveFontSize(context, 18),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: Responsive.responsivePadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 48,
                backgroundColor: Colors.grey[200],
                backgroundImage:
                    author.imageUrl.isNotEmpty ? AssetImage(author.imageUrl) : null,
                child: author.imageUrl.isEmpty
                    ? Text(
                        author.name[0],
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : null,
              ),
            ),
            SizedBox(height: Responsive.responsiveSpacing(context, 12)),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: _buildStars(author.rating),
              ),
            ),
            SizedBox(height: Responsive.responsiveSpacing(context, 16)),
            Text(
              AppLocalizations.of(context)!.about,
              style: TextStyle(
                fontSize: Responsive.responsiveFontSize(context, 18),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Responsive.responsiveSpacing(context, 8)),
            Text(
              author.bio,
              style: TextStyle(
                fontSize: Responsive.responsiveFontSize(context, 14),
                color: Colors.grey[700],
                height: 1.6,
              ),
            ),
            SizedBox(height: Responsive.responsiveSpacing(context, 16)),
            Text(
              AppLocalizations.of(context)!.products,
              style: TextStyle(
                fontSize: Responsive.responsiveFontSize(context, 18),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Responsive.responsiveSpacing(context, 12)),
            author.books.isEmpty
                ? Text(
                    AppLocalizations.of(context)!.no_orders_in_category,
                    style: TextStyle(color: Colors.grey[600]),
                  )
                : Column(
                    children: author.books.map((book) {
                      return ListTile(
                        leading: const Icon(Icons.menu_book),
                        title: Text(book.title),
                        subtitle: Text('\$${book.price.toStringAsFixed(2)}'),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BookDetailScreen(book: book),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildStars(double rating) {
    return List.generate(5, (index) {
      if (index < rating.floor()) {
        return const Icon(Icons.star, size: 18, color: Colors.amber);
      } else if (index < rating) {
        return const Icon(Icons.star_half, size: 18, color: Colors.amber);
      } else {
        return const Icon(Icons.star_border, size: 18, color: Colors.amber);
      }
    });
  }
}
