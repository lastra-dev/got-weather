import 'package:flutter/material.dart';

enum AppTheme {
  initial,
  winterfell,
  dorne,
}

const initialColor = Color(0xFF282a36);
const winterfellColor = Color(0xFF111844);
const dorneColor = Color(0xFF950330);

final appThemeData = {
  AppTheme.initial: ThemeData(
    brightness: Brightness.dark,
    primaryColor: initialColor,
    accentColor: initialColor,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: initialColor,
      ),
    ),
  ),
  AppTheme.winterfell: ThemeData(
    brightness: Brightness.dark,
    primaryColor: winterfellColor,
    accentColor: winterfellColor,
  ),
  AppTheme.dorne: ThemeData(
    brightness: Brightness.dark,
    primaryColor: dorneColor,
    accentColor: dorneColor,
  ),
};
