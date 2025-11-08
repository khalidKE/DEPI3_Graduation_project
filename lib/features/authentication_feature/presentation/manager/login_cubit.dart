import 'package:books/features/authentication_feature/presentation/manager/login_state.dart';
import 'package:books/features/authentication_feature/data/user_model.dart';
import 'package:books/services/firestore_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  void loginWithFirebase(UserModel user) async {
    emit(LoginLoadingState());
    try {
      final response = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      print(response);

      emit(LoginSuccessState());
    } catch (e) {
      emit(LoginErrorState());
    }
  }

  void signInWithGoogleFirebase() async {
    emit(LoginLoadingState());
    try {
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn.instance.authenticate();

      final GoogleSignInAuthentication? googleAuth = googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken,
      );
      FirebaseAuth.instance.signInWithCredential(credential);
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      emit(LoginSuccessState());
    } catch (e) {
      emit(LoginErrorState());
      print('===========================error========================');
      print(e.toString());
    }
  }
}
