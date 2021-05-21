import 'package:flutter/cupertino.dart';

//if usnig firebase create two folder in app/src name as dev and production
// and put respective google-service.json file

class AppConfig {
  final String flavor;
  final String appName;
  final String apiUrl;

  AppConfig(
      {@required this.apiUrl, @required this.appName, @required this.flavor});
}
