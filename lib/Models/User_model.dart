import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? name;
  final int? age;
  final String? favHobby;

  UserModel({
    this.name,
    this.age,
    this.favHobby,
  });

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserModel(
      name: data?['name'],
      age: data?['age'],
      favHobby: data?['favHobby'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (age != null) "age": age,
      if (favHobby != null) "favHobby": favHobby,
    };
  }
}
