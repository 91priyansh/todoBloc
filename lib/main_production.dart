import 'package:bloc_example/app/app.dart';
import 'package:bloc_example/app/appConfig.dart';
import 'package:flutter/material.dart';

void main() async {
  AppConfig appConfig =
      AppConfig(apiUrl: "", appName: "Bloc Example", flavor: "production");
  runApp(await initializeApp(appConfig));
}

/*
flutter run -t lib/main_production.dart  --flavor=production
flutter run -t lib/main_production.dart  --release --flavor=production
flutter build appbundle -t lib/main_production.dart  --flavor=production
flutter build apk -t lib/main_production.dart  --flavor=production
*/