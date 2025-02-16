part of 'auth_bloc.dart';

class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class AuthUserChanged extends AuthEvent {
  final User? user;
  final auth.User? authUser;

  const AuthUserChanged({this.user, required this.authUser});

  @override
  List<Object?> get props => [user, authUser];
}
