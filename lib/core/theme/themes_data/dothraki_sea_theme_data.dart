import 'package:flutter/material.dart';

const dothrakiSeaColor = Color(0xFF2F2D25);

final dothrakiSeaThemeData = ThemeData(
  primaryColor: dothrakiSeaColor,
  accentColor: Colors.white,
  colorScheme: const ColorScheme(
    primary: dothrakiSeaColor,
    primaryVariant: dothrakiSeaColor,
    secondary: Colors.white,
    secondaryVariant: dothrakiSeaColor,
    surface: dothrakiSeaColor,
    background: dothrakiSeaColor,
    error: dothrakiSeaColor,
    onPrimary: Colors.white,
    onSecondary: dothrakiSeaColor,
    onSurface: dothrakiSeaColor,
    onBackground: dothrakiSeaColor,
    onError: dothrakiSeaColor,
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
    headline6: const TextStyle(color: Colors.white),
  ),
  fontFamily: 'Poppins',
);
