import 'dart:async';

import 'package:auth_weather_api/data/models/user_model.dart';
import 'package:auth_weather_api/data/repository/auth/auth_repository.dart';
import 'package:auth_weather_api/data/repository/user/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  StreamSubscription<auth.User?>? _authStreamSubscription;
  StreamSubscription<User>? _userStreamSubscription;

  AuthBloc(
      {required AuthRepository authRepository,
      required UserRepository userRepository})
      : _authRepository = authRepository,
        _userRepository = userRepository,
        super(AuthState.unknown()) {
    on<AuthUserChanged>(_onAuthUserChanged);
    _authStreamSubscription = _authRepository.user.listen((authUser) {
      if (authUser != null) {
        _userRepository.getUser(authUser.uid).listen((user) {
          add(AuthUserChanged(authUser: authUser, user: user));
        });
      } else {
        add(AuthUserChanged(authUser: authUser));
      }
    });
  }

  FutureOr<void> _onAuthUserChanged(
      AuthUserChanged event, Emitter<AuthState> emit) {
    if (event.authUser != null) {
      emit(AuthState.authenticated(
          authUser: event.authUser!, user: event.user!));
    } else {
      emit(AuthState.unauthenticated());
    }
  }

  @override
  Future<void> close() {
    _authStreamSubscription?.cancel();
    _userStreamSubscription?.cancel();
    return super.close();
  }
}
