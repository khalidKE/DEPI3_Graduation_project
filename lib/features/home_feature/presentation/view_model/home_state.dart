import 'package:books/core/base/view_state.dart';

class HomeState {
  final ViewStatus status;
  final int currentIndex;

  const HomeState({
    this.status = ViewStatus.success,
    this.currentIndex = 0,
  });

  HomeState copyWith({
    ViewStatus? status,
    int? currentIndex,
  }) {
    return HomeState(
      status: status ?? this.status,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
