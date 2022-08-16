import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String email;
  String name;
  String status;

  String uid;

  UserModel(
      {required this.email,
      required this.name,
      required this.status,
      required this.uid});

  factory UserModel.fromJson(DocumentSnapshot snapshot) {
    return UserModel(
      email: snapshot['email'],
      name: snapshot['name'],
      status: snapshot['status'],
      uid: snapshot['uid'],
    );
  }
}
