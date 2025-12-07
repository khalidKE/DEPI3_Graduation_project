import 'package:books/core/base/view_state.dart';
import 'package:books/features/home_feature/presentation/view_model/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewModel extends Cubit<HomeState> {
  HomeViewModel() : super(const HomeState());

  void selectIndex(int index) {
    emit(state.copyWith(currentIndex: index, status: ViewStatus.success));
  }
}
