import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:books/l10n/app_localizations.dart';
import 'package:books/core/widgets/language_toggle.dart';
import 'package:books/core/utils/responsive.dart';
import 'package:books/core/widgets/error_boundary.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  // Sample orders data - in a real app, this would come from an API or state management
  final List<Map<String, dynamic>> _orders = [
    {
      'id': '#12345',
      'date': '2025-05-15',
      'status': 'Delivered',
      'total': 99.97,
      'items': [
        {
          'title': 'The Kite Runner',
          'author': 'Khaled Hosseini',
          'price': 39.99,
          'quantity': 1,
          'imageUrl': 'assets/images/books/kite_runner.jpg',
        },
        {
          'title': 'The Subtle Art',
          'author': 'Mark Manson',
          'price': 19.99,
          'quantity': 2,
          'imageUrl': 'assets/images/books/subtle_art.jpg',
        },
      ],
    },
    {
      'id': '#12344',
      'date': '2025-05-10',
      'status': 'Shipped',
      'total': 29.98,
      'items': [
        {
          'title': 'The Da Vinci Code',
          'author': 'Dan Brown',
          'price': 14.99,
          'quantity': 2,
          'imageUrl': 'assets/images/books/da_vinci_code.jpg',
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ErrorBoundary(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context)!.my_orders,
              style: TextStyle(
                fontSize: Responsive.responsiveFontSize(context, 20),
              ),
            ),
            centerTitle: true,
            actions: const [
              LanguageToggleButton(),
            ],
            bottom: TabBar(
              isScrollable: true,
              labelColor: const Color(0xFF6C47FF),
              unselectedLabelColor: Colors.grey,
              indicatorColor: const Color(0xFF6C47FF),
              tabs: [
                Tab(text: AppLocalizations.of(context)!.all),
                Tab(text: AppLocalizations.of(context)!.processing),
                Tab(text: AppLocalizations.of(context)!.shipped),
                Tab(text: AppLocalizations.of(context)!.delivered),
              ],
            ),
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth = Responsive.maxContentWidth(context);
              return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: maxWidth ?? double.infinity,
                  ),
                  child: _orders.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_bag_outlined,
                                size: Responsive.responsiveIconSize(context, 64),
                                color: Colors.grey,
                              ),
                              SizedBox(height: Responsive.responsiveSpacing(context, 16)),
                              Text(
                                AppLocalizations.of(context)!.no_orders_yet,
                                style: TextStyle(
                                  fontSize: Responsive.responsiveFontSize(context, 18),
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: Responsive.responsiveSpacing(context, 16)),
                              ElevatedButton(
                                onPressed: () {
                                  // Navigate to home or products screen
                                  Get.back();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF6C47FF),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Responsive.responsiveSpacing(context, 24),
                                    vertical: Responsive.responsiveSpacing(context, 12),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      Responsive.responsiveBorderRadius(context, 8),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!.start_shopping,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        )
                      : TabBarView(
                  children: [
                    // All orders
                    _buildOrderList(_orders),
                    // Processing
                    _buildOrderList(_orders
                        .where((order) => order['status'] == 'Processing')
                        .toList()),
                    // Shipped
                    _buildOrderList(_orders
                        .where((order) => order['status'] == 'Shipped')
                        .toList()),
                    // Delivered
                          _buildOrderList(_orders
                              .where((order) => order['status'] == 'Delivered')
                              .toList()),
                        ],
                      ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildOrderList(List<Map<String, dynamic>> orders) {
    if (orders.isEmpty) {
      return Center(
        child: Text(
          AppLocalizations.of(context)!.no_orders_in_category,
          style: TextStyle(
            fontSize: Responsive.responsiveFontSize(context, 16),
            color: Colors.grey,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: Responsive.responsivePadding(context),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Card(
          margin: EdgeInsets.only(
            bottom: Responsive.responsiveSpacing(context, 16),
          ),
          child: Padding(
            padding: EdgeInsets.all(
              Responsive.responsiveSpacing(context, 12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Order header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${AppLocalizations.of(context)!.order} ${order['id']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Responsive.responsiveFontSize(context, 16),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Responsive.responsiveSpacing(context, 12),
                        vertical: Responsive.responsiveSpacing(context, 4),
                      ),
                      decoration: BoxDecoration(
                        color:
                            _getStatusColor(order['status']).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(
                          Responsive.responsiveBorderRadius(context, 12),
                        ),
                        border: Border.all(
                            color: _getStatusColor(order['status'])
                                .withValues(alpha: 0.3)),
                      ),
                      child: Text(
                        _getLocalizedStatus(order['status']),
                        style: TextStyle(
                          color: _getStatusColor(order['status']),
                          fontSize: Responsive.responsiveFontSize(context, 12),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Responsive.responsiveSpacing(context, 8)),
                Text(
                  '${AppLocalizations.of(context)!.date}: ${order['date']}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: Responsive.responsiveFontSize(context, 14),
                  ),
                ),
                SizedBox(height: Responsive.responsiveSpacing(context, 12)),
                // Order items
                ...order['items']
                    .map<Widget>((item) => Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: Responsive.responsiveSpacing(context, 4),
                          ),
                          child: Row(
                            children: [
                              // Book cover
                              Container(
                                width: Responsive.responsiveImageSize(context, 50),
                                height: Responsive.responsiveImageSize(context, 70),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    Responsive.responsiveBorderRadius(context, 4),
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
                                                    size: Responsive.responsiveIconSize(context, 24),
                                                    color: Colors.grey),
                                      )
                                    : item['imageUrl'] != null
                                        ? Image.asset(
                                            item['imageUrl'],
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    Icon(Icons.book,
                                                        size: Responsive.responsiveIconSize(context, 24),
                                                        color: Colors.grey),
                                          )
                                        : Icon(Icons.book,
                                            size: Responsive.responsiveIconSize(context, 24),
                                            color: Colors.grey),
                              ),
                              SizedBox(width: Responsive.responsiveSpacing(context, 12)),
                              // Book details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['title'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: Responsive.responsiveFontSize(context, 14),
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: Responsive.responsiveSpacing(context, 2)),
                                    Text(
                                      '${AppLocalizations.of(context)!.qty}: ${item['quantity']}',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: Responsive.responsiveFontSize(context, 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  '\$${(item['price'] * item['quantity']).toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Responsive.responsiveFontSize(context, 14),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
                Divider(height: Responsive.responsiveSpacing(context, 24)),
                // Order total and action
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        '${AppLocalizations.of(context)!.total}: \$${order['total'].toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: Responsive.responsiveFontSize(context, 16),
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (order['status'] == 'Delivered')
                          TextButton(
                            onPressed: () {
                              // View order details
                            },
                            child: Text(
                              AppLocalizations.of(context)!.rate_order,
                              style: TextStyle(
                                color: const Color(0xFF6C47FF),
                                fontSize: Responsive.responsiveFontSize(context, 14),
                              ),
                            ),
                          ),
                        SizedBox(width: Responsive.responsiveSpacing(context, 8)),
                        TextButton(
                          onPressed: () {
                            // View order details
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: Responsive.responsiveSpacing(context, 16),
                              vertical: Responsive.responsiveSpacing(context, 8),
                            ),
                            backgroundColor:
                                const Color(0xFF6C47FF).withValues(alpha: 0.1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                Responsive.responsiveBorderRadius(context, 20),
                              ),
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.view_details,
                            style: TextStyle(
                              color: const Color(0xFF6C47FF),
                              fontSize: Responsive.responsiveFontSize(context, 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getLocalizedStatus(String status) {
    switch (status) {
      case 'Processing':
        return AppLocalizations.of(context)!.processing;
      case 'Shipped':
        return AppLocalizations.of(context)!.shipped;
      case 'Delivered':
        return AppLocalizations.of(context)!.delivered;
      default:
        return status;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Processing':
        return Colors.orange;
      case 'Shipped':
        return Colors.blue;
      case 'Delivered':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
