import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class UserModel {
  String id;
  String email;
  String name;
  String photo;
  RxBool buttonClicked = false.obs;

  UserModel(
      {required this.id,
      required this.email,
      required this.name,
      required this.photo,
      bool? buttonClicked}) {
    this.buttonClicked = false.obs;
  }

  factory UserModel.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    return UserModel(
        id: doc['id'],
        email: doc['email'],
        name: doc['name'],
        photo: doc['photo']);
  }
}
