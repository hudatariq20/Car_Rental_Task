import 'package:auth_weather_api/data/models/user_model.dart';
import 'package:auth_weather_api/data/repository/auth/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:meta/meta.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository _authRepository;
  SignUpCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(SignUpState.initial());

  void userChanged(User? user) {
    emit(state.copyWith(user: user, signUpStatus: SignUpStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, signUpStatus: SignUpStatus.initial));
  }

  Future<void> signUpWithCredentials() async {
    if (!state.isFormValid || state.signUpStatus == SignUpStatus.submitting)
      return;
    emit(state.copyWith(signUpStatus: SignUpStatus.submitting));
    try {
      var authUser =  await _authRepository.signUp(user: state.user, password: state.password);
      emit(state.copyWith(signUpStatus: SignUpStatus.success, authUser: authUser));
    } catch (_) {}
  }
}
