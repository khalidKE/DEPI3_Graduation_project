import 'package:books/core/base/view_state.dart';
import 'package:books/features/authentication_feature/data/auth_repository.dart';
import 'package:books/features/authentication_feature/data/user_model.dart';
import 'package:books/features/authentication_feature/presentation/view_model/signup_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupViewModel extends Cubit<SignupState> {
  SignupViewModel({AuthRepository? repository})
      : _repository = repository ?? AuthRepository(),
        super(const SignupState());

  final AuthRepository _repository;

  Future<void> signup(UserModel user) async {
    emit(
      state.copyWith(
        status: ViewStatus.loading,
        resetError: true,
        user: user,
      ),
    );
    try {
      await _repository.signUp(user);
      emit(
        state.copyWith(
          status: ViewStatus.success,
          user: user,
          resetError: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ViewStatus.failure,
          error: e,
          user: user,
        ),
      );
      debugPrint('Signup error: $e');
    }
  }
}
