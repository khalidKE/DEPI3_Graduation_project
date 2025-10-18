import 'package:books/cubits/signup_state.dart';
import 'package:books/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupCubit extends Cubit<signupState> {
  SignupCubit() : super(signupInitialState());

  Future<User?> signupWithFirebase(UserModel user) async {
    emit(signupLoadingState());
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: user.email,
            password: user.password,
          );

      emit(signupSuccessState());
      return userCredential.user;
    } catch (e) {
      emit(signupErrorState());
      print('========================================');
      print(e.toString());
    }
  }
}
