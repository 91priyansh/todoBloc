import 'package:bloc_example/ui/styles/colors.dart';
import 'package:flutter/material.dart';

enum AppTheme { Light, Dark }

final appThemeData = {
  AppTheme.Light: ThemeData(
    brightness: Brightness.light,
    primaryColor: lightPrimaryColor,
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: lightPrimaryColor),
  ),
  AppTheme.Dark: ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: primaryColor))
};
