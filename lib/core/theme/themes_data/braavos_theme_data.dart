import 'package:flutter/material.dart';

const braavosColor = Color(0xFF242a2e);

final braavosThemeData = ThemeData(
  primaryColor: braavosColor,
  colorScheme: const ColorScheme(
    primary: braavosColor,
    primaryVariant: braavosColor,
    secondary: Colors.white,
    secondaryVariant: braavosColor,
    surface: braavosColor,
    background: braavosColor,
    error: braavosColor,
    onPrimary: Colors.white,
    onSecondary: braavosColor,
    onSurface: Colors.white,
    onBackground: braavosColor,
    onError: braavosColor,
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
