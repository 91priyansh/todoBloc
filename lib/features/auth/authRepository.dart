import 'package:bloc_example/features/auth/authLocalDataSource.dart';

class AuthRepository {
  static final AuthRepository _authRepository = AuthRepository._internal();
  AuthLocalDataSource _authLocalDataSource;

  factory AuthRepository() {
    _authRepository._authLocalDataSource = AuthLocalDataSource();
    return _authRepository;
  }

  AuthRepository._internal();

  Map<String, dynamic> getLocalAuthDetails() {
    return {
      "isLogin": _authLocalDataSource.checkIsAuth(),
      "jwtToken": _authLocalDataSource.getJwt(),
      "userId": _authLocalDataSource.getUserId()
    };
  }

  void setLocalAuthDetails({String jwtToken, String userId}) {
    _authLocalDataSource.changeAuthStatus();
    _authLocalDataSource.setJwt(jwtToken);
    _authLocalDataSource.setUserId(userId);
  }

  //and signInUser
}
