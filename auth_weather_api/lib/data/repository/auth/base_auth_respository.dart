import 'package:auth_weather_api/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

abstract class BaseAuthRepository {
//get user
  Stream<auth.User?> get user;

//sign up
  Future<auth.User?> signUp({required User user, required String password});

//login with email and password
  Future<void> logInWithEmailAndPassword(
      {required String email, required String password});

//signout
  Future<void> signOut();
}
