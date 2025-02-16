import 'dart:async';

import 'package:auth_weather_api/data/models/user_model.dart';
import 'package:auth_weather_api/data/repository/user/user_repository.dart';
import 'package:auth_weather_api/presentation/blocs/auth/auth_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthBloc _authBloc;
  final UserRepository _userRepository;
  StreamSubscription? authSubscription;
  ProfileBloc(
      {required AuthBloc authBloc, required UserRepository userRepository})
      : _authBloc = authBloc,
        _userRepository = userRepository,
        super(ProfileLoading()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateProfile>(_onUpdateProfile);
    authSubscription = _authBloc.stream.listen((state) {
      if (state.authUser != null) {
        add(LoadProfile(state.authUser!));
      }
    });
  }

  Future<void> _onLoadProfile(LoadProfile event, Emitter<ProfileState> emit) async {
    if (event.authUser != null) {
      _userRepository.getUser(event.authUser!.uid).listen((user) {
        add(UpdateProfile(user));
      });
    } else {
      emit(ProfileUnavailable());
    }
  }

  Future<void> _onUpdateProfile(
      UpdateProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoaded(user: event.user));
  }

  @override
  Future<void> close() {
    authSubscription?.cancel();
    return super.close();
  }
}
