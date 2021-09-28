import 'package:flutter/material.dart';

const beyondTheWallColor = Color(0xFF052a4d);

final beyondTheWallThemeData = ThemeData(
  primaryColor: beyondTheWallColor,
  colorScheme: const ColorScheme(
    primary: beyondTheWallColor,
    primaryVariant: beyondTheWallColor,
    secondary: Colors.white,
    secondaryVariant: beyondTheWallColor,
    surface: beyondTheWallColor,
    background: beyondTheWallColor,
    error: beyondTheWallColor,
    onPrimary: Colors.white,
    onSecondary: beyondTheWallColor,
    onSurface: Colors.white,
    onBackground: beyondTheWallColor,
    onError: beyondTheWallColor,
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
