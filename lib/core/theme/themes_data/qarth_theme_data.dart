import 'package:flutter/material.dart';

const qarthColor = Color(0xFF1D2840);

final qarthThemeData = ThemeData(
  primaryColor: qarthColor,
  colorScheme: const ColorScheme(
    primary: qarthColor,
    primaryVariant: qarthColor,
    secondary: Colors.white,
    secondaryVariant: qarthColor,
    surface: qarthColor,
    background: qarthColor,
    error: qarthColor,
    onPrimary: Colors.white,
    onSecondary: qarthColor,
    onSurface: Colors.white,
    onBackground: qarthColor,
    onError: qarthColor,
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
