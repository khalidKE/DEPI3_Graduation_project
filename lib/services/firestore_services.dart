import 'package:books/features/authentication_feature/data/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirestoreServices {
  static const String usersCollection = 'users';
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> addUser(UserModel user, {String? uid}) async {
    _db.settings = const Settings(persistenceEnabled: true);
    try {
      final currentUserId = uid ?? FirebaseAuth.instance.currentUser?.uid;
      if (currentUserId == null) {
        throw Exception('No user is signed in');
      }

      await _db.collection(usersCollection).doc(currentUserId).set({
        UserModel.fieldName: user.name,
        UserModel.fieldEmail: user.email,
        UserModel.fieldPhone: user.phone,
        UserModel.fieldAddress: user.address,
        UserModel.fieldProfilePic: user.profilePic,
      });
      debugPrint('User added with ID $currentUserId');
    } catch (e) {
      debugPrint('Error adding user: $e');
      rethrow;
    }
  }

  static Future<void> addUserFromGoogle(UserModel user, String uid) async {
    await addUser(user, uid: uid);
  }

  static Future<UserModel?> getUserData() async {
    _db.settings = const Settings(persistenceEnabled: true);
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        debugPrint('no user signed in');
        return null;
      }

      final result = await _db.collection(usersCollection).doc(currentUser.uid).get();
      final data = result.data();
      if (data != null) {
        return UserModel.fromJson(data);
      }
    } catch (e) {
      debugPrint('Error getting user data: $e');
    }
    return null;
  }
}
