import 'package:books/core/base/view_state.dart';
import 'package:books/features/authentication_feature/data/auth_repository.dart';
import 'package:books/features/authentication_feature/data/user_model.dart';
import 'package:books/features/authentication_feature/presentation/view_model/login_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginViewModel extends Cubit<LoginState> {
  LoginViewModel({AuthRepository? repository})
      : _repository = repository ?? AuthRepository(),
        super(const LoginState());

  final AuthRepository _repository;

  Future<void> login(UserModel user) async {
    emit(
      state.copyWith(
        status: ViewStatus.loading,
        isAuthenticated: false,
        resetError: true,
      ),
    );
    try {
      await _repository.signIn(user);
      emit(
        state.copyWith(
          status: ViewStatus.success,
          isAuthenticated: true,
          resetError: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ViewStatus.failure,
          error: e,
          isAuthenticated: false,
        ),
      );
      debugPrint('Error signing in: $e');
    }
  }

  Future<void> signInWithGoogle() async {
    emit(
      state.copyWith(
        status: ViewStatus.loading,
        isAuthenticated: false,
        resetError: true,
      ),
    );
    try {
      await _repository.signInWithGoogle();
      emit(
        state.copyWith(
          status: ViewStatus.success,
          isAuthenticated: true,
          resetError: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ViewStatus.failure,
          error: e,
          isAuthenticated: false,
        ),
      );
      debugPrint('Error signing in with Google: $e');
    }
  }
}
