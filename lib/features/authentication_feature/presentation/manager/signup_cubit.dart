import 'package:books/features/authentication_feature/presentation/manager/signup_state.dart';
import 'package:books/features/authentication_feature/data/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupCubit extends Cubit<signupState> {
  SignupCubit() : super(signupInitialState());

  Future<User?> signupWithFirebase(UserModel user) async {
    emit(signupLoadingState());
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
    return null;
  }
}
