import 'package:books/features/authentication_feature/data/user_model.dart';
import 'package:books/services/firestore_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  AuthRepository({
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.instance;

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  Future<UserCredential> signIn(UserModel user) async {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: user.email,
      password: user.password,
    );
  }

  Future<UserCredential> signUp(UserModel user) async {
    return _firebaseAuth.createUserWithEmailAndPassword(
      email: user.email,
      password: user.password,
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    final googleUser = await _googleSignIn.authenticate();
    final googleAuth = googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    final result = await _firebaseAuth.signInWithCredential(credential);

    final firebaseUser = result.user;
    if (firebaseUser != null) {
      final userModel = UserModel(
        email: firebaseUser.email ?? '',
        password: '',
        name: firebaseUser.displayName ?? '',
        profilePic: firebaseUser.photoURL ?? UserModel.defaultProfilePic,
      );
      await FirestoreServices.addUserFromGoogle(userModel, firebaseUser.uid);
    }

    return result;
  }
}
