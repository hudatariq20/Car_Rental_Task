part of 'login_cubit.dart';

enum LoginStatus { initial, submitting, error, success }

class LoginState extends Equatable {
  final String password;
  final String email;
  final LoginStatus loginStatus;
  final auth.User? authUser;

  LoginState(
      {required this.password, required this.email, required this.loginStatus, required this.authUser});
      
  bool get isFormValid => email.isNotEmpty && password.isNotEmpty;
  bool get stringify => true;

  factory LoginState.initial() {
    return LoginState(
        password: '', email: '', loginStatus: LoginStatus.initial, authUser: null);
  }

  LoginState copyWith(
      {String? email,
      String? password,
      LoginStatus? status,
      auth.User? authUser}) {
    return LoginState(
        loginStatus: status ?? this.loginStatus,
        email: email ?? this.email,
        password: password ?? this.password,
        authUser: authUser ?? this.authUser);
  }

  @override
  List<Object?> get props => [email, password, loginStatus, authUser];
}
