import 'package:flutter/material.dart';

const initialColor = Color(0xFF0090BF);
const secondaryColor = Color(0xFFF8931F);
const subtitle2Color = Color(0xA5001c26);

final initialThemeData = ThemeData(
  primaryColor: initialColor,
  accentColor: secondaryColor,
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
    brightness: Brightness.light,
  ),
  textTheme: const TextTheme(
    subtitle1: TextStyle(color: subtitle2Color),
    headline2: TextStyle(color: initialColor),
  ),
  fontFamily: 'Poppins',
);
