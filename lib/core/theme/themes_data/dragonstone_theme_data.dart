import 'package:flutter/material.dart';

const dragonstoneColor = Color(0xFF1c0603);

final dragonstoneThemeData = ThemeData(
  primaryColor: dragonstoneColor,
  colorScheme: const ColorScheme(
    primary: dragonstoneColor,
    primaryVariant: dragonstoneColor,
    secondary: Colors.white,
    secondaryVariant: dragonstoneColor,
    surface: dragonstoneColor,
    background: dragonstoneColor,
    error: dragonstoneColor,
    onPrimary: Colors.white,
    onSecondary: dragonstoneColor,
    onSurface: Colors.white,
    onBackground: dragonstoneColor,
    onError: dragonstoneColor,
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
