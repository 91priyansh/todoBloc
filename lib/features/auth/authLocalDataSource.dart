import 'package:bloc_example/utils/constants.dart';
import 'package:hive/hive.dart';

class AuthLocalDataSource {
  bool checkIsAuth() {
    return Hive.box(authBox).get(isLoginKey, defaultValue: false);
  }

  String getJwt() {
    return Hive.box(authBox).get(jwtTokenKey, defaultValue: "");
  }

  String getUserId() {
    return Hive.box(authBox).get(userIdKey, defaultValue: "");
  }

  Future<void> setJwt(String jwtToken) async {
    Hive.box(authBox).put(jwtTokenKey, jwtToken);
  }

  Future<void> setUserId(String userId) async {
    Hive.box(authBox).put(userId, userId);
  }

  Future<void> changeAuthStatus() async {
    final currentAuthStatus =
        Hive.box(authBox).get(isLoginKey, defaultValue: false);
    Hive.box(authBox).put(isLoginKey, !currentAuthStatus);
  }
}
