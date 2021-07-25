import 'package:flutter/material.dart';

enum AppTheme {
  initial,
  winterfell,
  dorne,
}

const initialPrimaryColor = Color(0xFF282a36);
const initialAccentColor = Color(0xFFf8f8f2);
const winterfellPrimaryColor = Color(0xFF111844);
const winterfellAccentColor = Color(0xFF455fff);
const dornePrimaryColor = Color(0xFF950330);
const dorneAccentColor = Color(0xFFe0074a);

final appThemeData = {
  AppTheme.initial: ThemeData(
    brightness: Brightness.dark,
    primaryColor: initialPrimaryColor,
    accentColor: initialAccentColor,
    hintColor: initialPrimaryColor,
    textTheme: const TextTheme(
      subtitle1: TextStyle(color: initialAccentColor),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(primary: initialAccentColor),
    ),
    snackBarTheme: const SnackBarThemeData(
      contentTextStyle: TextStyle(color: initialAccentColor),
      backgroundColor: initialPrimaryColor,
      actionTextColor: initialAccentColor,
    ),
  ),
  AppTheme.winterfell: ThemeData(
    brightness: Brightness.dark,
    primaryColor: winterfellPrimaryColor,
    accentColor: winterfellAccentColor,
  ),
  AppTheme.dorne: ThemeData(
    brightness: Brightness.dark,
    primaryColor: dornePrimaryColor,
    accentColor: dorneAccentColor,
  ),
};
