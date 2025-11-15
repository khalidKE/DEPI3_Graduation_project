import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:books/l10n/app_localizations.dart';
import 'package:books/core/widgets/language_toggle.dart';
import 'package:books/core/utils/responsive.dart';
import 'package:books/features/cart_feature/presentation/views/confirm_order_screen.dart';
import 'package:books/core/widgets/error_boundary.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Sample cart items - in a real app, this would come from a state management solution
  final List<Map<String, dynamic>> _cartItems = [
    {
      'id': '1',
      'title': 'The Kite Runner',
      'author': 'Khaled Hosseini',
      'price': 39.99,
      'quantity': 1,
      'imageUrl': 'assets/b1.png',
    },
    {
      'id': '2',
      'title': 'The Subtle Art',
      'author': 'Mark Manson',
      'price': 19.99,
      'quantity': 2,
      'imageUrl': 'assets/b2.png',
    },
  ];

  double get _totalPrice {
    return _cartItems.fold(
        0, (sum, item) => sum + (item['price'] * item['quantity']));
  }

  void _updateQuantity(int index, int newQuantity) {
    setState(() {
      if (newQuantity > 0) {
        _cartItems[index]['quantity'] = newQuantity;
      } else {
        _cartItems.removeAt(index);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.item_removed)),
        );
      }
    });
  }

  void _checkout() {
    if (_cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.cart_empty)),
      );
      return;
    }

    // Navigate to confirm order screen
    Get.to(() => const ConfirmOrderScreen());
  }

  @override
  Widget build(BuildContext context) {
    return ErrorBoundary(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.my_cart,
            style: TextStyle(
              fontSize: Responsive.responsiveFontSize(context, 20),
            ),
          ),
          centerTitle: true,
          elevation: 0,
          actions: const [
            LanguageToggleButton(),
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = Responsive.maxContentWidth(context);
            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: maxWidth ?? double.infinity,
                ),
                child: Column(
                  children: [
                    // Cart items list
                    Expanded(
                      child: _cartItems.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.shopping_cart_outlined,
                                    size: Responsive.responsiveIconSize(context, 64),
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: Responsive.responsiveSpacing(context, 16)),
                                  Text(
                                    AppLocalizations.of(context)!.cart_empty,
                                    style: TextStyle(
                                      fontSize: Responsive.responsiveFontSize(context, 18),
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              padding: Responsive.responsivePadding(context),
                      itemCount: _cartItems.length,
                      itemBuilder: (context, index) {
                        final item = _cartItems[index];
                        return Card(
                          margin: EdgeInsets.only(
                            bottom: Responsive.responsiveSpacing(context, 16),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(
                              Responsive.responsiveSpacing(context, 12),
                            ),
                            child: Row(
                              children: [
                                // Book cover
                                Container(
                                  width: Responsive.responsiveImageSize(context, 80),
                                  height: Responsive.responsiveImageSize(context, 100),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      Responsive.responsiveBorderRadius(context, 8),
                                    ),
                                    color: Colors.grey[200],
                                  ),
                                  child: item['imageUrl'] != null &&
                                          item['imageUrl'].startsWith('http')
                                      ? Image.network(
                                          item['imageUrl'],
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Icon(Icons.book,
                                                      size: Responsive.responsiveIconSize(context, 40),
                                                      color: Colors.grey),
                                        )
                                      : item['imageUrl'] != null
                                          ? Image.asset(
                                              item['imageUrl'],
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  Icon(Icons.book,
                                                      size: Responsive.responsiveIconSize(context, 40),
                                                      color: Colors.grey),
                                            )
                                          : Icon(Icons.book,
                                              size: Responsive.responsiveIconSize(context, 40),
                                              color: Colors.grey),
                                ),
                                SizedBox(width: Responsive.responsiveSpacing(context, 16)),
                                // Book details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['title'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Responsive.responsiveFontSize(context, 16),
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: Responsive.responsiveSpacing(context, 4)),
                                      Text(
                                        item['author'],
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: Responsive.responsiveFontSize(context, 14),
                                        ),
                                      ),
                                      SizedBox(height: Responsive.responsiveSpacing(context, 8)),
                                      Text(
                                        '\$${item['price'].toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF6C47FF),
                                          fontSize: Responsive.responsiveFontSize(context, 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Quantity controls
                                Column(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.add_circle_outline,
                                          size: Responsive.responsiveIconSize(context, 20)),
                                      onPressed: () => _updateQuantity(
                                        index,
                                        item['quantity'] + 1,
                                      ),
                                    ),
                                    Text(
                                      '${item['quantity']}',
                                      style: TextStyle(
                                        fontSize: Responsive.responsiveFontSize(context, 16),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                          Icons.remove_circle_outline,
                                          size: Responsive.responsiveIconSize(context, 20)),
                                      onPressed: () => _updateQuantity(
                                        index,
                                        item['quantity'] - 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                            },
                          ),
                    ),
                    // Checkout section
                    if (_cartItems.isNotEmpty)
                      Container(
                        padding: Responsive.responsivePadding(context),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          Text(
                            AppLocalizations.of(context)!.total,
                            style: TextStyle(
                              fontSize: Responsive.responsiveFontSize(context, 18),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '\$${_totalPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: Responsive.responsiveFontSize(context, 20),
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF6C47FF),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Responsive.responsiveSpacing(context, 16)),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _checkout,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6C47FF),
                            padding: EdgeInsets.symmetric(
                              vertical: Responsive.responsiveSpacing(context, 16),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                Responsive.responsiveBorderRadius(context, 12),
                              ),
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.proceed_to_checkout,
                            style: TextStyle(
                              fontSize: Responsive.responsiveFontSize(context, 16),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ));
          },
        ),
      ),
    );
  }
}
