part of 'auth_bloc.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState extends Equatable {
  final AuthStatus authStatus;
  final User? user;
  final auth.User? authUser;

  AuthState._({this.authStatus = AuthStatus.unknown, this.authUser, this.user});

  AuthState.unknown() : this._();

  AuthState.authenticated({required auth.User authUser, required User user})
      : this._(
            authStatus: AuthStatus.authenticated,
            authUser: authUser,
            user: user);

  AuthState.unauthenticated() : this._(authStatus: AuthStatus.unauthenticated);

  @override
  List<Object?> get props => [authStatus, user, authUser];
}
