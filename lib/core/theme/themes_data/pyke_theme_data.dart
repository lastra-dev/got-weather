import 'package:flutter/material.dart';

const pykeColor = Color(0xFF1f3f54);

final pykeThemeData = ThemeData(
  primaryColor: pykeColor,
  accentColor: Colors.white,
  colorScheme: const ColorScheme(
    primary: pykeColor,
    primaryVariant: pykeColor,
    secondary: Colors.white,
    secondaryVariant: pykeColor,
    surface: pykeColor,
    background: pykeColor,
    error: pykeColor,
    onPrimary: Colors.white,
    onSecondary: pykeColor,
    onSurface: pykeColor,
    onBackground: pykeColor,
    onError: pykeColor,
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
