import 'package:bloc_example/features/auth/authRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//State
@immutable
abstract class SigninState {}

class SigninIntial extends SigninState {}

class SigninInProgress extends SigninState {}

class SigninFailure extends SigninState {
  final String errorMessage;

  SigninFailure(this.errorMessage);
}

class SigninSuccess extends SigninState {
  final String userId;
  final String jwtToken;

  SigninSuccess({this.jwtToken, this.userId});
}

class SigninCubit extends Cubit<SigninState> {
  final AuthRepository _authRepository;
  SigninCubit(this._authRepository) : super(SigninIntial());

  Future<void> signInUser(String email, String password) async {
    try {
      emit(SigninInProgress());
      //auth fucntion from remotedatabse
      emit(SigninSuccess(jwtToken: "token", userId: "1"));
      _authRepository.setLocalAuthDetails(jwtToken: "token", userId: "1");
    } catch (e) {
      emit(SigninFailure(e.toString()));
    }
  }
}
