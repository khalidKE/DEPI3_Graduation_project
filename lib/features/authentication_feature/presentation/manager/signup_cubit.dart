import 'package:books/features/authentication_feature/presentation/manager/signup_state.dart';
import 'package:books/features/authentication_feature/data/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitialState());

  Future<User?> signupWithFirebase(UserModel user) async {
    emit(SignupLoadingState());
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      emit(SignupSuccessState());
      return userCredential.user;
    } catch (e) {
      emit(SignupErrorState(e));
      debugPrint('Signup error: $e');
      return null;
    }
  }
}
