import 'package:books/features/authentication_feature/data/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreServices {
  static const String users = 'Users';
  static const String name = 'name';
  static const String email = 'email';
  static const String phone = 'phone';
  static const String address = 'address';
  static const String profilePic = 'profile pic';
  static final db = FirebaseFirestore.instance;

  static void addUser(Map<String, dynamic> user) async {
    db.settings = const Settings(persistenceEnabled: true);
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        print('no user signed in');
        throw Exception('No user is signed in');
      }
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');
      await usersCollection.doc(currentUser.uid).set({
        name: user[name],
        email: user[email],
        phone: user[phone],
        address: user[address],
        profilePic: user[profilePic],
      });
      print('User added with custom ID!');
    } catch (e) {
      print('=========================================');
      print('Error adding user: $e');
    }
  }

  static void addUserFromGoogle(Map<String, dynamic> user, String uid) async {
    db.settings = const Settings(persistenceEnabled: true);
    try {
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');
      await usersCollection.doc(uid).set({
        name: user[name],
        email: user[email],
        phone: user[phone],
        address: user[address],
        profilePic: user[profilePic],
      });
      print('User added with custom ID!');
    } catch (e) {
      print('=========================================');
      print('Error adding user: $e');
    }
  }

  static Future getUserData() async {
    db.settings = const Settings(persistenceEnabled: true);
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        print('no user signed in');
        throw Exception('No user is signed in');
      }
      final result = await db.collection('users').doc(currentUser.uid).get();
      UserModel.user.fromJson(result.data()!);
    } catch (e) {
      print('=========================================');
      print('Error getting user data user: $e');
    }
  }
}
