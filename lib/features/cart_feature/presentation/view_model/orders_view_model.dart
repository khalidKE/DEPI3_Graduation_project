import 'package:books/core/base/view_state.dart';
import 'package:books/features/cart_feature/data/order_models.dart';
import 'package:books/features/cart_feature/presentation/view_model/orders_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersViewModel extends Cubit<OrdersState> {
  OrdersViewModel()
      : super(
          OrdersState(
            status: ViewStatus.success,
            orders: const [],
          ),
        );

  List<Order> filterByStatus(String status) {
    if (status == 'All') return state.orders;
    return state.orders.where((order) => order.status == status).toList();
  }
}
