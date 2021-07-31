import 'package:flutter/material.dart';

const kingsLandingColor = Color(0xFF261014);

final kingsLandingThemeData = ThemeData(
  primaryColor: kingsLandingColor,
  accentColor: Colors.white,
  colorScheme: const ColorScheme(
    primary: kingsLandingColor,
    primaryVariant: kingsLandingColor,
    secondary: Colors.white,
    secondaryVariant: kingsLandingColor,
    surface: kingsLandingColor,
    background: kingsLandingColor,
    error: kingsLandingColor,
    onPrimary: Colors.white,
    onSecondary: kingsLandingColor,
    onSurface: kingsLandingColor,
    onBackground: kingsLandingColor,
    onError: kingsLandingColor,
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
