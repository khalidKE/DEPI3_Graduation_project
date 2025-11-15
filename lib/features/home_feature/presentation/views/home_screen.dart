import 'package:books/features/notification_feature/presentation/views/notification.dart';
import 'package:books/l10n/app_localizations.dart';
import 'package:books/core/widgets/language_toggle.dart';
import 'package:books/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:books/features/profile_feature/presentation/views/profile.dart';
import 'package:books/features/cart_feature/presentation/views/cart_screen.dart';
import 'package:books/features/cart_feature/presentation/views/orders_screen.dart';
import 'package:get/get.dart';

// Models
class Book {
  final String id;
  final String title;
  final String author;
  final double price;
  final double rating;
  final String description;
  final String imageUrl;
  bool isFavorite;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.price,
    required this.rating,
    required this.description,
    required this.imageUrl,
    this.isFavorite = false,
  });
}

class Author {
  final String id;
  final String name;
  final String role;
  final String bio;
  final double rating;
  final String imageUrl;
  final List<Book> books;

  Author({
    required this.id,
    required this.name,
    required this.role,
    required this.bio,
    required this.rating,
    required this.imageUrl,
    required this.books,
  });
}

class Vendor {
  final String id;
  final String name;
  final double rating;
  final String imageUrl;

  Vendor({
    required this.id,
    required this.name,
    required this.rating,
    required this.imageUrl,
  });
}

// Sample Data
class AppData {
  static List<Book> books = [
    Book(
      id: '1',
      title: 'The Kite Runner',
      author: 'Khaled Hosseini',
      price: 39.99,
      rating: 4.0,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque dignissim sit amet nisl vel eleifend.',
      imageUrl: 'assets/b1.png',
    ),
    Book(
      id: '2',
      title: 'The Subtle Art',
      author: 'Mark Manson',
      price: 19.99,
      rating: 4.5,
      description: 'A counterintuitive approach to living a good life.',
      imageUrl: 'assets/b2.png',
    ),
    Book(
      id: '3',
      title: 'The Da Vinci Code',
      author: 'Dan Brown',
      price: 14.95,
      rating: 4.2,
      description: 'A gripping mystery thriller novel.',
      imageUrl: 'assets/b3.png',
    ),
    Book(
      id: '4',
      title: 'Game Fisher',
      author: 'Tess Gunty',
      price: 27.12,
      rating: 4.3,
      description: 'An exciting adventure novel.',
      imageUrl: '',
    ),
    Book(
      id: '5',
      title: 'The Good Sister',
      author: 'Tess Gunty',
      price: 27.12,
      rating: 4.1,
      description: 'A compelling family drama.',
      imageUrl: '',
    ),
    Book(
      id: '6',
      title: 'The Waiting',
      author: 'Tess Gunty',
      price: 27.12,
      rating: 4.4,
      description: 'A suspenseful thriller.',
      imageUrl: '',
    ),
  ];

  static List<Vendor> vendors = [
    Vendor(id: '1', name: 'Wattpad', rating: 4.0, imageUrl: 'assets/v1.png'),
    Vendor(id: '2', name: 'Kuronii', rating: 4.5, imageUrl: 'assets/v2.png'),
    Vendor(id: '3', name: 'Crane & Co', rating: 4.2, imageUrl: 'assets/v4.png'),
    Vendor(id: '4', name: 'GoodBuy', rating: 4.3, imageUrl: 'assets/v3.png'),
    Vendor(id: '5', name: 'Warehouse', rating: 4.1, imageUrl: 'assets/v5.png'),
    Vendor(id: '6', name: 'Peppa Pig', rating: 4.4, imageUrl: 'assets/v6.png'),
    Vendor(id: '7', name: 'Jstor', rating: 4.0, imageUrl: 'assets/v7.png'),
    Vendor(id: '8', name: 'Peloton', rating: 4.2, imageUrl: 'assets/v8.png'),
    Vendor(id: '9', name: 'Haymarket', rating: 4.3, imageUrl: 'assets/v9.png'),
  ];

  static List<Author> authors = [
    Author(
      id: '1',
      name: 'John Freeman',
      role: 'Writer',
      bio:
          'American writer who was the editor of several prestigious publications.',
      rating: 4.2,
      imageUrl: 'assets/a1.png',
      books: [],
    ),
    Author(
      id: '2',
      name: 'Adam Dalva',
      role: 'Writer',
      bio: 'He is a writer and the fiction editor of a renowned magazine.',
      rating: 4.0,
      imageUrl: 'assets/a2.png',
      books: [],
    ),
    Author(
      id: '3',
      name: 'Abraham Verghese',
      role: 'Professor',
      bio:
          'He is the professor and Sofia Anesaki Chair at Stanford University.',
      rating: 4.5,
      imageUrl: 'assets/a3.png',
      books: [],
    ),
    Author(
      id: '4',
      name: 'Tess Gunty',
      role: 'Novelist',
      bio:
          'Gunty was born and raised in South Bend, Indiana. She graduated from Yale University and received an MFA in Fiction and English from New York University.',
      rating: 4.0,
      imageUrl: 'assets/a4.png',
      books: AppData.books.where((b) => b.author == 'Tess Gunty').toList(),
    ),
    Author(
      id: '5',
      name: 'Ann Napolitano',
      role: 'Novelist',
      bio: 'She is the author of the novel A Good Hard Look.',
      rating: 4.3,
      imageUrl: 'assets/a5.png',
      books: [],
    ),
    Author(
      id: '6',
      name: 'Hernan Diaz',
      role: 'Writer',
      bio: 'Award-winning novelist and essayist.',
      rating: 4.4,
      imageUrl: 'assets/a6.png',
      books: [],
    ),
  ];
}

// Home Screen
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.home,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: Responsive.responsiveFontSize(context, 18),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.black,
            size: Responsive.responsiveIconSize(context, 24),
          ),
          onPressed: () {},
        ),
        actions: [
          // Language toggle button
          const LanguageToggleButton(),
          IconButton(
            icon: Icon(
              Icons.notifications_outlined,
              color: Colors.black,
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
                constraints: BoxConstraints(
                  maxWidth: maxWidth ?? double.infinity,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
            // Special Offer Banner
            _buildSpecialOfferBanner(context),

            // Top of Week Section
            _buildSectionHeader(
              context,
              AppLocalizations.of(context)!.top_of_week,
              () {},
            ),
            _buildTopOfWeekBooks(),

            SizedBox(height: Responsive.responsiveSpacing(context, 10)),

            // Best Vendors Section
            _buildSectionHeader(
              context,
              AppLocalizations.of(context)!.best_vendors,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const VendorsScreen()),
                );
              },
            ),
            _buildVendorsSection(),

            SizedBox(height: Responsive.responsiveSpacing(context, 10)),

            // Authors Section
            _buildSectionHeader(
              context,
              AppLocalizations.of(context)!.authors,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AuthorsScreen()),
                );
              },
            ),
            _buildAuthorsSection(),

                    SizedBox(height: Responsive.responsiveSpacing(context, 20)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF6C47FF),
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          // Navigate to different screens based on index
          switch (index) {
            case 0:
              // Home - already here
              break;
            case 1:
              // Orders
              Get.to(() => const OrdersScreen());
              break;
            case 2:
              // Cart
              Get.to(() => const CartScreen());
              break;
            case 3:
              // Profile
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
              );
              break;
          }
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
      ),
    );
  }

  Widget _buildSpecialOfferBanner(BuildContext context) {
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

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    VoidCallback onSeeAll,
  ) {
    final showSeeAll = title == AppLocalizations.of(context)!.best_vendors ||
        title == AppLocalizations.of(context)!.authors;

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

  Widget _buildTopOfWeekBooks() {
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

  Widget _buildVendorsSection() {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 6,
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
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAuthorsSection() {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 6,
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
              width: 85,
              margin: const EdgeInsets.only(right: 16),
              child: Column(
                children: [
                  Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: author.imageUrl.isNotEmpty
                        ? ClipOval(
                            child: Image.asset(
                              author.imageUrl,
                              width: 65,
                              height: 65,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Text(
                                    author.name[0],
                                    style: TextStyle(
                                      fontSize: 24,
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
                                fontSize: 24,
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
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    author.role,
                    style: TextStyle(fontSize: 10, color: Colors.grey[600]),
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

// Book Detail Screen
class BookDetailScreen extends StatefulWidget {
  final Book book;
  const BookDetailScreen({super.key, required this.book});

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.book_details),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book Cover and Basic Info
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Book Cover
                  Container(
                    width: 120,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: widget.book.imageUrl.isNotEmpty
                        ? Image.asset(
                            widget.book.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.menu_book_rounded,
                              size: 50,
                              color: Colors.grey[400],
                            ),
                          )
                        : Icon(
                            Icons.menu_book_rounded,
                            size: 50,
                            color: Colors.grey[400],
                          ),
                  ),
                  const SizedBox(width: 16),
                  // Book Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.book.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'by ${widget.book.author}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 20,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${widget.book.rating}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '(1,234 reviews)',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '\$${widget.book.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E88E5),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1E88E5),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!.add_to_cart,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Responsive.responsiveFontSize(context, 14),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isFavorite = !isFavorite;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300]!),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isFavorite
                                      ? Colors.red
                                      : Colors.grey[600],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Tabs
            TabBar(
              labelColor: const Color(0xFF1E88E5),
              unselectedLabelColor: Colors.grey,
              indicatorColor: const Color(0xFF1E88E5),
              tabs: [
                Tab(text: AppLocalizations.of(context)!.about),
                Tab(text: AppLocalizations.of(context)!.reviews),
                Tab(text: AppLocalizations.of(context)!.related),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // About Tab
                  _buildAboutTab(),
                  // Reviews Tab
                  _buildReviewsTab(),
                  // Related Tab
                  _buildRelatedTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.description,
            style: TextStyle(
              fontSize: Responsive.responsiveFontSize(context, 18),
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: Responsive.responsiveSpacing(context, 8)),
          Text(
            widget.book.description,
            style: TextStyle(
              fontSize: Responsive.responsiveFontSize(context, 14),
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
          SizedBox(height: Responsive.responsiveSpacing(context, 16)),
          Text(
            AppLocalizations.of(context)!.details,
            style: TextStyle(
              fontSize: Responsive.responsiveFontSize(context, 18),
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: Responsive.responsiveSpacing(context, 8)),
          _buildDetailRow(
            context,
            AppLocalizations.of(context)!.publisher,
            'Riverhead Books',
          ),
          _buildDetailRow(
            context,
            AppLocalizations.of(context)!.publication_date,
            'May 29, 2003',
          ),
          _buildDetailRow(
            context,
            AppLocalizations.of(context)!.pages,
            '400',
          ),
          _buildDetailRow(context, 'ISBN', '978-1594480003'),
          _buildDetailRow(
            context,
            AppLocalizations.of(context)!.language,
            'English',
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Responsive.responsiveSpacing(context, 4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: Responsive.responsiveFontSize(context, 14),
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: Responsive.responsiveFontSize(context, 14),
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsTab() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildReviewItem(
          'John Doe',
          '5.0',
          '2 days ago',
          'This book is amazing! The story is so touching and well-written. I couldn\'t put it down.',
        ),
        const SizedBox(height: 16),
        _buildReviewItem(
          'Jane Smith',
          '4.0',
          '1 week ago',
          'Great book with deep characters. The emotional journey is incredible.',
        ),
        const SizedBox(height: 16),
        _buildReviewItem(
          'Alex Johnson',
          '5.0',
          '2 weeks ago',
          'One of the best books I\'ve ever read. Highly recommended!',
        ),
      ],
    );
  }

  Widget _buildReviewItem(
    String name,
    String rating,
    String time,
    String review,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    rating,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(time, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          const SizedBox(height: 8),
          Text(review, style: TextStyle(fontSize: 14, color: Colors.grey[800])),
        ],
      ),
    );
  }

  Widget _buildRelatedTab() {
    return ListView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildRelatedBook(
          'A Thousand Splendid Suns',
          'Khaled Hosseini',
          '\$12.99',
        ),
        const SizedBox(width: 16),
        _buildRelatedBook(
          'And the Mountains Echoed',
          'Khaled Hosseini',
          '\$10.99',
        ),
        const SizedBox(width: 16),
        _buildRelatedBook('Sea Prayer', 'Khaled Hosseini', '\$9.99'),
      ],
    );
  }

  Widget _buildRelatedBook(String title, String author, String price) {
    return SizedBox(
      width: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            height: 180,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.book, size: 40, color: Colors.grey[400]),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            author,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            price,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E88E5),
            ),
          ),
        ],
      ),
    );
  }
}

// Vendors Screen
class VendorsScreen extends StatefulWidget {
  const VendorsScreen({super.key});

  @override
  State<VendorsScreen> createState() => _VendorsScreenState();
}

class _VendorsScreenState extends State<VendorsScreen> {
  String selectedCategory = 'All';
  final List<String> categories = [
    'All',
    'Books',
    'Poems',
    'Special for you',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppLocalizations.of(context)!.vendors,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: Responsive.responsiveFontSize(context, 18),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
              size: Responsive.responsiveIconSize(context, 24),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: Responsive.responsivePadding(context).copyWith(
              top: Responsive.responsiveSpacing(context, 16),
              bottom: Responsive.responsiveSpacing(context, 4),
            ),
            child: Text(
              AppLocalizations.of(context)!.our_vendors,
              style: TextStyle(
                fontSize: Responsive.responsiveFontSize(context, 14),
                color: Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: Responsive.responsivePadding(context),
            child: Text(
              AppLocalizations.of(context)!.vendors,
              style: TextStyle(
                fontSize: Responsive.responsiveFontSize(context, 26),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: categories.map((category) {
                return _buildCategoryChip(category);
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 20,
              ),
              itemCount: AppData.vendors.length,
              itemBuilder: (context, index) {
                final vendor = AppData.vendors[index];
                return GestureDetector(
                    onTap: () {
                      // TODO: Add navigation to vendor detail screen or other action
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 85,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: Builder(
                            builder: (context) {
                              if (vendor.imageUrl.isEmpty) {
                                return Center(
                                  child: Text(
                                    vendor.name[0],
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                );
                              }

                              try {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    vendor.imageUrl,
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      debugPrint(
                                          'Error loading ${vendor.imageUrl}: $error');
                                      return Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              '!',
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red,
                                              ),
                                            ),
                                            Text(
                                              vendor.name[0],
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                );
                              } catch (e) {
                                return Center(
                                  child: Text(
                                    '!${vendor.name[0]}',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          vendor.name,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _buildSmallStars(vendor.rating),
                        ),
                      ],
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String category) {
    final isSelected = selectedCategory == category;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF5B4DB5) : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          category,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildSmallStars(double rating) {
    return List.generate(5, (index) {
      if (index < rating.floor()) {
        return const Icon(Icons.star, size: 12, color: Colors.amber);
      } else if (index < rating) {
        return const Icon(Icons.star_half, size: 12, color: Colors.amber);
      } else {
        return const Icon(Icons.star_border, size: 12, color: Colors.amber);
      }
    });
  }
}

// Authors Screen
class AuthorsScreen extends StatefulWidget {
  const AuthorsScreen({super.key});

  @override
  State<AuthorsScreen> createState() => _AuthorsScreenState();
}

class _AuthorsScreenState extends State<AuthorsScreen> {
  String selectedCategory = 'All';
  final List<String> categories = [
    'All',
    'Poets',
    'Playwrights',
    'Novelists',
    'Journalist',
  ];

  List<Author> get filteredAuthors {
    if (selectedCategory == 'All') return AppData.authors;

    // Map of display categories to possible role matches
    final roleMap = {
      'Poets': ['poet', 'poetry', 'poem'],
      'Playwrights': ['playwright', 'dramatist', 'play'],
      'Novelists': ['novelist', 'writer', 'author'],
      'Journalist': ['journalist', 'reporter', 'correspondent'],
    };

    final categoryRoles = roleMap[selectedCategory] ?? [];

    return AppData.authors.where((author) {
      final authorRole = author.role.toLowerCase();
      return categoryRoles.any((role) => authorRole.contains(role));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppLocalizations.of(context)!.authors,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: Responsive.responsiveFontSize(context, 18),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
              size: Responsive.responsiveIconSize(context, 24),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: Responsive.responsivePadding(context).copyWith(
              top: Responsive.responsiveSpacing(context, 16),
              bottom: Responsive.responsiveSpacing(context, 4),
            ),
            child: Text(
              AppLocalizations.of(context)!.check_top_authors,
              style: TextStyle(
                fontSize: Responsive.responsiveFontSize(context, 14),
                color: Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: Responsive.responsivePadding(context),
            child: Text(
              AppLocalizations.of(context)!.authors,
              style: TextStyle(
                fontSize: Responsive.responsiveFontSize(context, 26),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: categories.map((category) {
                return _buildCategoryChip(category);
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: filteredAuthors.isEmpty
                ? Center(
                    child: Text(
                      AppLocalizations.of(context)!
                          .no_authors_found(selectedCategory),
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: Responsive.responsiveFontSize(context, 16),
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredAuthors.length,
                    itemBuilder: (context, index) {
                      final author = filteredAuthors[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AuthorDetailScreen(author: author),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  shape: BoxShape.circle,
                                ),
                                child: author.imageUrl.isNotEmpty
                                    ? ClipOval(
                                        child: Image.asset(
                                          author.imageUrl,
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Center(
                                              child: Text(
                                                author.name[0],
                                                style: TextStyle(
                                                  fontSize: 24,
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
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                      ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      author.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${author.role} • ${author.rating} ⭐',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      author.bio,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String category) {
    final isSelected = selectedCategory == category;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF5B4DB5) : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          category,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

// Author Detail Screen
class AuthorDetailScreen extends StatelessWidget {
  final Author author;

  const AuthorDetailScreen({super.key, required this.author});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppLocalizations.of(context)!.authors,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: Responsive.responsiveFontSize(context, 18),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Author Avatar
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  author.name[0],
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              author.role,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              author.name,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(5, (index) {
                  if (index < author.rating.floor()) {
                    return const Icon(
                      Icons.star,
                      size: 22,
                      color: Colors.amber,
                    );
                  } else if (index < author.rating) {
                    return const Icon(
                      Icons.star_half,
                      size: 22,
                      color: Colors.amber,
                    );
                  } else {
                    return const Icon(
                      Icons.star_border,
                      size: 22,
                      color: Colors.amber,
                    );
                  }
                }),
                const SizedBox(width: 8),
                Text(
                  '(${author.rating})',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Padding(
              padding: Responsive.responsivePadding(context).copyWith(
                left: Responsive.responsiveSpacing(context, 24),
                right: Responsive.responsiveSpacing(context, 24),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!.about,
                  style: TextStyle(
                    fontSize: Responsive.responsiveFontSize(context, 20),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                author.bio,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                  height: 1.6,
                ),
              ),
            ),
            Padding(
              padding: Responsive.responsivePadding(context).copyWith(
                left: Responsive.responsiveSpacing(context, 24),
                right: Responsive.responsiveSpacing(context, 24),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!.products,
                  style: TextStyle(
                    fontSize: Responsive.responsiveFontSize(context, 20),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            author.books.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      'No books available',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: author.books.length,
                    itemBuilder: (context, index) {
                      final book = author.books[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BookDetailScreen(book: book),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 180,
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
                              child: Center(
                                child: Icon(
                                  Icons.menu_book_rounded,
                                  size: 50,
                                  color: Colors.grey[400],
                                ),
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
                      );
                    },
                  ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
