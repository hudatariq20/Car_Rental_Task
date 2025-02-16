part of 'sign_up_cubit.dart';

enum SignUpStatus { initial, submitting, success, error }

class SignUpState extends Equatable {
  final String password;
  final auth.User? authuser;
  final User user;
  final SignUpStatus signUpStatus;

  const SignUpState(
      {required this.password,
      required this.authuser,
      required this.user,
      required this.signUpStatus});

  factory SignUpState.initial() {
    return const SignUpState(
        password: '',
        authuser: null,
        user: User(),
        signUpStatus: SignUpStatus.initial);
  }

  @override
  bool get stringify => true;

  bool get isFormValid =>
      password.isNotEmpty &&
      user!.email.isNotEmpty &&
      user!.address.isNotEmpty &&
      user!.name.isNotEmpty &&
      user!.city.isNotEmpty &&
      user!.country.isNotEmpty &&
      user!.zipCode.isNotEmpty;

  SignUpState copyWith(
      {String? password,
      User? user,
      auth.User? authUser,
      SignUpStatus? signUpStatus}) {
    return SignUpState(
        password: password ?? this.password,
        authuser: authuser ?? this.authuser,
        user: user ?? this.user,
        signUpStatus: signUpStatus ?? this.signUpStatus);
  }

  @override
  List<Object?> get props => [password, authuser, user, signUpStatus];
}
