import 'package:flutter/material.dart';

const ironIslandsColor = Color(0xFF34566b);

final ironIslandsThemeData = ThemeData(
  primaryColor: ironIslandsColor,
  accentColor: Colors.white,
  colorScheme: const ColorScheme(
    primary: ironIslandsColor,
    primaryVariant: ironIslandsColor,
    secondary: Colors.white,
    secondaryVariant: ironIslandsColor,
    surface: ironIslandsColor,
    background: ironIslandsColor,
    error: ironIslandsColor,
    onPrimary: Colors.white,
    onSecondary: ironIslandsColor,
    onSurface: ironIslandsColor,
    onBackground: ironIslandsColor,
    onError: ironIslandsColor,
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
