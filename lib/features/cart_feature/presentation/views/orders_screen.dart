import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:books/l10n/app_localizations.dart';
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
            title: Text(AppLocalizations.of(context)!.my_orders),
            centerTitle: true,
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
          body: _orders.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.shopping_bag_outlined,
                          size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text(
                        AppLocalizations.of(context)!.no_orders_yet,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to home or products screen
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6C47FF),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
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
      ),
    );
  }

  Widget _buildOrderList(List<Map<String, dynamic>> orders) {
    if (orders.isEmpty) {
      return Center(
        child: Text(
          AppLocalizations.of(context)!.no_orders_in_category,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Order header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${AppLocalizations.of(context)!.order} ${order['id']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color:
                            _getStatusColor(order['status']).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: _getStatusColor(order['status'])
                                .withOpacity(0.3)),
                      ),
                      child: Text(
                        order['status'],
                        style: TextStyle(
                          color: _getStatusColor(order['status']),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '${AppLocalizations.of(context)!.date}: ${order['date']}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                const SizedBox(height: 12),
                // Order items
                ...order['items']
                    .map<Widget>((item) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              // Book cover
                              Container(
                                width: 50,
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.grey[200],
                                ),
                                child: item['imageUrl'] != null &&
                                        item['imageUrl'].startsWith('http')
                                    ? Image.network(
                                        item['imageUrl'],
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Icon(Icons.book,
                                                    size: 24,
                                                    color: Colors.grey),
                                      )
                                    : item['imageUrl'] != null
                                        ? Image.asset(
                                            item['imageUrl'],
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    const Icon(Icons.book,
                                                        size: 24,
                                                        color: Colors.grey),
                                          )
                                        : const Icon(Icons.book,
                                            size: 24, color: Colors.grey),
                              ),
                              const SizedBox(width: 12),
                              // Book details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['title'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${AppLocalizations.of(context)!.qty}: ${item['quantity']}',
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '\$${(item['price'] * item['quantity']).toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
                const Divider(height: 24),
                // Order total and action
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${AppLocalizations.of(context)!.total}: \$${order['total'].toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        if (order['status'] == 'Delivered')
                          TextButton(
                            onPressed: () {
                              // View order details
                            },
                            child: Text(
                              AppLocalizations.of(context)!.rate_order,
                              style: const TextStyle(color: Color(0xFF6C47FF)),
                            ),
                          ),
                        const SizedBox(width: 8),
                        TextButton(
                          onPressed: () {
                            // View order details
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            backgroundColor:
                                const Color(0xFF6C47FF).withOpacity(0.1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.view_details,
                            style: const TextStyle(color: Color(0xFF6C47FF)),
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
