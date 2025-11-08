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
    this.name = json[FirestoreServices.name];
    this.email = json[FirestoreServices.email];
    this.phone = json[FirestoreServices.phone];
    this.address = json[FirestoreServices.address];
    this.profilepic = json[FirestoreServices.profilePic];
  }

  Map<String, dynamic> toJson() {
    return ({
      FirestoreServices.name: this.name,
      FirestoreServices.email: this.email,
      FirestoreServices.phone: this.phone,
      FirestoreServices.address: this.address,
      FirestoreServices.profilePic: this.profilepic,
    });
  }
}
