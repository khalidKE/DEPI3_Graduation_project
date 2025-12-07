import 'package:books/core/utils/responsive.dart';
import 'package:books/core/widgets/error_boundary.dart';
import 'package:books/core/widgets/language_toggle.dart';
import 'package:books/features/cart_feature/data/order_models.dart';
import 'package:books/features/cart_feature/presentation/view_model/orders_state.dart';
import 'package:books/features/cart_feature/presentation/view_model/orders_view_model.dart';
import 'package:books/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrdersViewModel(),
      child: const ErrorBoundary(
        child: _OrdersView(),
      ),
    );
  }
}

class _OrdersView extends StatelessWidget {
  const _OrdersView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersViewModel, OrdersState>(
      builder: (context, state) {
        return DefaultTabController(
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
                final viewModel = context.read<OrdersViewModel>();
                return Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: maxWidth ?? double.infinity,
                    ),
                    child: state.orders.isEmpty
                        ? _EmptyOrders()
                        : TabBarView(
                            children: [
                              _OrdersList(orders: viewModel.filterByStatus('All')),
                              _OrdersList(orders: viewModel.filterByStatus('Processing')),
                              _OrdersList(orders: viewModel.filterByStatus('Shipped')),
                              _OrdersList(orders: viewModel.filterByStatus('Delivered')),
                            ],
                          ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _EmptyOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
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
        ],
      ),
    );
  }
}

class _OrdersList extends StatelessWidget {
  const _OrdersList({required this.orders});

  final List<Order> orders;

  @override
  Widget build(BuildContext context) {
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${AppLocalizations.of(context)!.order} ${order.id}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Responsive.responsiveFontSize(context, 16),
                      ),
                    ),
                    _StatusChip(status: order.status),
                  ],
                ),
                SizedBox(height: Responsive.responsiveSpacing(context, 8)),
                Text(
                  '${AppLocalizations.of(context)!.date}: ${order.date}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: Responsive.responsiveFontSize(context, 14),
                  ),
                ),
                SizedBox(height: Responsive.responsiveSpacing(context, 12)),
                ...order.items.map((item) => Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: Responsive.responsiveSpacing(context, 4),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: Responsive.responsiveImageSize(context, 50),
                            height: Responsive.responsiveImageSize(context, 70),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                Responsive.responsiveBorderRadius(context, 4),
                              ),
                              color: Colors.grey[200],
                            ),
                            child: item.imageUrl.isNotEmpty
                                ? Image.asset(
                                    item.imageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) =>
                                        Icon(Icons.book,
                                            size: Responsive.responsiveIconSize(context, 24),
                                            color: Colors.grey),
                                  )
                                : Icon(Icons.book,
                                    size: Responsive.responsiveIconSize(context, 24),
                                    color: Colors.grey),
                          ),
                          SizedBox(width: Responsive.responsiveSpacing(context, 12)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: Responsive.responsiveFontSize(context, 14),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: Responsive.responsiveSpacing(context, 2)),
                                Text(
                                  '${AppLocalizations.of(context)!.qty}: ${item.quantity}',
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
                              '\$${item.total.toStringAsFixed(2)}',
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
                    )),
                Divider(height: Responsive.responsiveSpacing(context, 24)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        '${AppLocalizations.of(context)!.total}: \$${order.total.toStringAsFixed(2)}',
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
                        if (order.status == 'Delivered')
                          TextButton(
                            onPressed: () {},
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
                          onPressed: () {},
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
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final String status;

  Color _getStatusColor() {
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

  String _localizedStatus(BuildContext context) {
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

  @override
  Widget build(BuildContext context) {
    final color = _getStatusColor();
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.responsiveSpacing(context, 12),
        vertical: Responsive.responsiveSpacing(context, 4),
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(
          Responsive.responsiveBorderRadius(context, 12),
        ),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        _localizedStatus(context),
        style: TextStyle(
          color: color,
          fontSize: Responsive.responsiveFontSize(context, 12),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
