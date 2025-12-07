import 'package:books/core/base/view_state.dart';
import 'package:books/features/cart_feature/data/delivery_address.dart';
import 'package:books/features/cart_feature/presentation/view_model/confirm_order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmOrderViewModel extends Cubit<ConfirmOrderState> {
  ConfirmOrderViewModel()
      : super(
          ConfirmOrderState(
            status: ViewStatus.success,
            address: const DeliveryAddress(
              name: 'Utama Street No.20',
              governorate: 'New York',
              city: 'Dumbo',
            ),
            selectedDateTime: null,
          ),
        );

  void updateAddress(DeliveryAddress address) {
    emit(
      state.copyWith(
        address: address,
        status: ViewStatus.success,
        shouldNavigate: false,
        resetMessage: true,
      ),
    );
  }

  void setDateTime(DateTime dateTime) {
    emit(
      state.copyWith(
        selectedDateTime: dateTime,
        status: ViewStatus.success,
        resetMessage: true,
      ),
    );
  }

  void proceed() {
    if (state.address.name.isEmpty) {
      emit(
        state.copyWith(
          status: ViewStatus.failure,
          message: 'address_missing',
          shouldNavigate: false,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        shouldNavigate: true,
        status: ViewStatus.success,
        resetMessage: true,
      ),
    );
  }

  void acknowledgeNavigation() {
    emit(
      state.copyWith(
        shouldNavigate: false,
      ),
    );
  }
}
