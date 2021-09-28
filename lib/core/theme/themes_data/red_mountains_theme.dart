import 'package:flutter/material.dart';

const redMountainsColor = Color(0xFF251B00);

final redMountainsThemeData = ThemeData(
  primaryColor: redMountainsColor,
  colorScheme: const ColorScheme(
    primary: redMountainsColor,
    primaryVariant: redMountainsColor,
    secondary: Colors.white,
    secondaryVariant: redMountainsColor,
    surface: redMountainsColor,
    background: redMountainsColor,
    error: redMountainsColor,
    onPrimary: Colors.white,
    onSecondary: redMountainsColor,
    onSurface: Colors.white,
    onBackground: redMountainsColor,
    onError: redMountainsColor,
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
