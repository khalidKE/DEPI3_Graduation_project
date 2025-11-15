import 'package:books/features/authentication_feature/presentation/manager/login_state.dart';
import 'package:books/features/authentication_feature/data/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  void loginWithFirebase(UserModel user) async {
    emit(LoginLoadingState());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      emit(LoginSuccessState());
    } catch (e) {
      emit(LoginErrorState(e));
    }
  }

  void signInWithGoogleFirebase() async {
    emit(LoginLoadingState());
    try {
      // Use the singleton instance that was initialized in main.dart
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;
      
      // Sign in with Google - authenticate() returns GoogleSignInAccount (non-nullable)
      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

      // Get authentication details - authentication is a getter, not a Future
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      
      // Create Firebase credential
      // For Firebase Auth with google_sign_in 7.2.0, we only need idToken
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      
      // Sign in to Firebase with Google credential
      await FirebaseAuth.instance.signInWithCredential(credential);

      emit(LoginSuccessState());
    } catch (e) {
      emit(LoginErrorState(e));
      debugPrint('Error signing in with Google: $e');
    }
  }
}
