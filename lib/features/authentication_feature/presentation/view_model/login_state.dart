import 'package:books/core/base/view_state.dart';

class LoginState {
  final ViewStatus status;
  final Object? error;
  final bool isAuthenticated;

  const LoginState({
    this.status = ViewStatus.idle,
    this.error,
    this.isAuthenticated = false,
  });

  bool get isLoading => status == ViewStatus.loading;
  bool get isSuccess => status == ViewStatus.success && isAuthenticated;
  bool get hasError => status == ViewStatus.failure && error != null;

  LoginState copyWith({
    ViewStatus? status,
    Object? error,
    bool? isAuthenticated,
    bool resetError = false,
  }) {
    return LoginState(
      status: status ?? this.status,
      error: resetError ? null : error ?? this.error,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}
