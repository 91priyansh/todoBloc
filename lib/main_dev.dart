import 'package:bloc_example/app/app.dart';
import 'package:bloc_example/app/appConfig.dart';
import 'package:flutter/material.dart';

void main() async {
  AppConfig appConfig =
      AppConfig(apiUrl: "", appName: "Bloc Example Dev", flavor: "dev");
  runApp(await initializeApp(appConfig));
}

/*
flutter run -t lib/main_dev.dart  --flavor=dev
# Debug signing configuration + dev flavor
flutter run -t lib/main_dev.dart  --debug --flavor=dev
flutter run -t lib/main_dev.dart  --release --flavor=dev
flutter build appbundle -t lib/main_dev.dart  --flavor=dev
flutter build apk -t lib/main_dev.dart  --flavor=dev
*/