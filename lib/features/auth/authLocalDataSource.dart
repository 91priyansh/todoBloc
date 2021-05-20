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
}
