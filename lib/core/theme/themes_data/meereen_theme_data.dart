import 'package:flutter/material.dart';

const meereenColor = Color(0xFF191c01);

final meereenThemeData = ThemeData(
  primaryColor: meereenColor,
  colorScheme: const ColorScheme(
    primary: meereenColor,
    primaryVariant: meereenColor,
    secondary: Colors.white,
    secondaryVariant: meereenColor,
    surface: meereenColor,
    background: meereenColor,
    error: meereenColor,
    onPrimary: Colors.white,
    onSecondary: meereenColor,
    onSurface: Colors.white,
    onBackground: meereenColor,
    onError: meereenColor,
    brightness: Brightness.dark,
  ),
  textTheme: TextTheme(
    headline2: TextStyle(
      color: Colors.white,
      shadows: [
        Shadow(
          offset: Offset.fromDirection(0, 4),
        ),
      ],
    ),
    headline4: const TextStyle(color: Colors.white),
    headline6: const TextStyle(color: Colors.white70),
  ),
  fontFamily: 'Poppins',
);
