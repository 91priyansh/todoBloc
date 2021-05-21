import 'package:bloc_example/features/auth/authRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//State
@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {
  final String userId; //unique Id of user
  final String jwtToken; // if any
  final String role; //if any role (like customer or selller)

  Authenticated({this.jwtToken, this.userId, this.role});
}

class Unauthenticated extends AuthState {}

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  AuthCubit(this._authRepository) : super(AuthInitial()) {
    _checkAuthStatus();
  }

  void _checkAuthStatus() {
    final authDetails = _authRepository.getLocalAuthDetails();

    if (authDetails['isLogin']) {
      emit(Authenticated(
          jwtToken: authDetails['jwtToken'], userId: authDetails['userId']));
    } else {
      emit(Unauthenticated());
    }
  }
}
