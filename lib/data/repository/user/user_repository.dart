
import 'package:auth_weather_api/data/models/user_model.dart';
import 'package:auth_weather_api/data/repository/user/base_user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserRepository extends BaseUserRepository {
  final FirebaseFirestore _firebaseFirestore;

  UserRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<void> createUser(User user) async {
    try {
      //create the user in the db collection
      await _firebaseFirestore
          .collection('user')
          .doc(user.id)
          .set(user.toDocument());
    } catch (_) {}
  }

  @override
  Stream<User> getUser(String userId) {
    //Find the user from the pool of users
    return _firebaseFirestore
        .collection('user')
        .doc(userId)
        .snapshots()
        .map((snap) => User.fromSnapshot(snap));
  }

  @override
  Future<void> updateUser(User user) {
    //update the given user in the database
    return _firebaseFirestore
        .collection('user')
        .doc(user.id)
        .update(user.toDocument())
        .then((value) => debugPrint('The document has been updated'));
  }
}
