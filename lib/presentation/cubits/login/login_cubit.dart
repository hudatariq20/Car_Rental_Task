
import 'package:auth_weather_api/data/repository/auth/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(LoginState.initial());

  void emailChanged(String email) {
    emit(state.copyWith(email: email, status: LoginStatus.initial));
  }

  void passwordChanged(String password) {
    emit(state.copyWith(password: password, status: LoginStatus.initial));
  }

  Future<void> logInWithCredentials() async {
    if (!state.isFormValid || state.loginStatus == LoginStatus.submitting)
      return;
    emit(state.copyWith(status: LoginStatus.submitting));
    try {
      await _authRepository.logInWithEmailAndPassword(
          email: state.email, password: state.password);
      emit(state.copyWith(
        status: LoginStatus.success,
      ));
    } on auth.FirebaseAuthException catch (e) {
      print("FirebaseAuthException: $e");
      print("Complete exception details: ${e.toString()}");
      emit(state.copyWith(status: LoginStatus.error));
    }
  }
}
