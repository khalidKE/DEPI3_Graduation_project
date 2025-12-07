import 'package:books/core/base/view_state.dart';
import 'package:books/features/authentication_feature/data/user_model.dart';

class SignupState {
  final ViewStatus status;
  final Object? error;
  final UserModel? user;

  const SignupState({
    this.status = ViewStatus.idle,
    this.error,
    this.user,
  });

  bool get isLoading => status == ViewStatus.loading;
  bool get isSuccess => status == ViewStatus.success && user != null;
  bool get hasError => status == ViewStatus.failure && error != null;

  SignupState copyWith({
    ViewStatus? status,
    Object? error,
    UserModel? user,
    bool resetError = false,
  }) {
    return SignupState(
      status: status ?? this.status,
      error: resetError ? null : error ?? this.error,
      user: user ?? this.user,
    );
  }
}
