import 'package:books/services/firestore_services.dart';

class UserModel {
  late String email;
  late String password;
  late String name;
  String phone = 'none';
  String address = 'not defined';
  String profilepic = 'https://cdn-icons-png.flaticon.com/512/9479/9479047.png';
  static UserModel user = UserModel._();
  UserModel._();
  void fromJson(Map<String, dynamic> json) {
    name = json[FirestoreServices.name];
    email = json[FirestoreServices.email];
    phone = json[FirestoreServices.phone];
    address = json[FirestoreServices.address];
    profilepic = json[FirestoreServices.profilePic];
  }

  Map<String, dynamic> toJson() {
    return ({
      FirestoreServices.name: name,
      FirestoreServices.email: email,
      FirestoreServices.phone: phone,
      FirestoreServices.address: address,
      FirestoreServices.profilePic: profilepic,
    });
  }
}
