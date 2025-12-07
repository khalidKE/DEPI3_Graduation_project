import 'package:books/core/base/view_state.dart';
import 'package:books/features/cart_feature/data/cart_item.dart';
import 'package:books/features/cart_feature/data/order_models.dart';
import 'package:books/features/cart_feature/presentation/view_model/orders_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersViewModel extends Cubit<OrdersState> {
  OrdersViewModel()
      : super(
          OrdersState(
            status: ViewStatus.success,
            orders: const [
              Order(
                id: '#12345',
                date: '2025-05-15',
                status: 'Delivered',
                total: 99.97,
                items: [
                  CartItem(
                    id: '1',
                    title: 'The Kite Runner',
                    author: 'Khaled Hosseini',
                    price: 39.99,
                    quantity: 1,
                    imageUrl: 'assets/images/books/kite_runner.jpg',
                  ),
                  CartItem(
                    id: '2',
                    title: 'The Subtle Art',
                    author: 'Mark Manson',
                    price: 19.99,
                    quantity: 2,
                    imageUrl: 'assets/images/books/subtle_art.jpg',
                  ),
                ],
              ),
              Order(
                id: '#12344',
                date: '2025-05-10',
                status: 'Shipped',
                total: 29.98,
                items: [
                  CartItem(
                    id: '3',
                    title: 'The Da Vinci Code',
                    author: 'Dan Brown',
                    price: 14.99,
                    quantity: 2,
                    imageUrl: 'assets/images/books/da_vinci_code.jpg',
                  ),
                ],
              ),
            ],
          ),
        );

  List<Order> filterByStatus(String status) {
    if (status == 'All') return state.orders;
    return state.orders.where((order) => order.status == status).toList();
  }
}
