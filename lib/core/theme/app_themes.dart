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
  AppTheme.initial: ThemeData.from(
    colorScheme: const ColorScheme(
      primary: initialColor,
      primaryVariant: initialColor,
      secondary: Colors.white,
      secondaryVariant: initialColor,
      surface: initialColor,
      background: initialColor,
      error: initialColor,
      onPrimary: Colors.white,
      onSecondary: initialColor,
      onSurface: initialColor,
      onBackground: initialColor,
      onError: initialColor,
      brightness: Brightness.dark,
    ),
    textTheme: const TextTheme(
      subtitle1: TextStyle(color: initialColor),
      headline2: TextStyle(color: initialColor),
    ),
  ),
  AppTheme.dorne: ThemeData.from(
    colorScheme: const ColorScheme(
      primary: dorneColor,
      primaryVariant: dorneColor,
      secondary: Colors.white,
      secondaryVariant: dorneColor,
      surface: dorneColor,
      background: dorneColor,
      error: dorneColor,
      onPrimary: Colors.white,
      onSecondary: dorneColor,
      onSurface: initialColor,
      onBackground: dorneColor,
      onError: dorneColor,
      brightness: Brightness.dark,
    ),
    textTheme: const TextTheme(
      headline2: TextStyle(color: Colors.white),
      headline4: TextStyle(color: Colors.white),
      headline6: TextStyle(color: Colors.white70),
    ),
  ),
  AppTheme.winterfell: ThemeData.from(
    colorScheme: const ColorScheme(
      primary: winterfellColor,
      primaryVariant: winterfellColor,
      secondary: Colors.white,
      secondaryVariant: winterfellColor,
      surface: winterfellColor,
      background: winterfellColor,
      error: winterfellColor,
      onPrimary: Colors.white,
      onSecondary: winterfellColor,
      onSurface: initialColor,
      onBackground: winterfellColor,
      onError: winterfellColor,
      brightness: Brightness.dark,
    ),
    textTheme: const TextTheme(
      headline2: TextStyle(color: Colors.white),
      headline4: TextStyle(color: Colors.white),
      headline6: TextStyle(color: Colors.white70),
    ),
  ),
};
