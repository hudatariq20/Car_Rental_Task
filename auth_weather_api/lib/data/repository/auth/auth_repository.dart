
import 'package:auth_weather_api/data/models/user_model.dart';
import 'package:auth_weather_api/data/repository/auth/base_auth_respository.dart';
import 'package:auth_weather_api/data/repository/user/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class AuthRepository extends BaseAuthRepository {
  final auth.FirebaseAuth _firebaseAuth;
  final UserRepository _userRepository;

  AuthRepository(
      {auth.FirebaseAuth? firebaseAuth, required UserRepository userRepository})
      : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance,
        _userRepository = userRepository;

  @override
  Stream<auth.User?> get user => _firebaseAuth.authStateChanges();

  @override
  Future<auth.User?> signUp(
      {required User user, required String password}) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: user.email, password: password)
          .then((value) =>
              _userRepository.createUser(user.copyWith(id: value.user!.uid)));
      print(_firebaseAuth);
    } catch (_) {}
  }

  @override
  Future<void> logInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on auth.FirebaseAuthException catch (e) {
      print("FirebaseAuthException: $e");
      print("Complete exception details: ${e.toString()}");
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
