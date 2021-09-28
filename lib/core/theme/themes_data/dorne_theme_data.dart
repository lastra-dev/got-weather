import 'package:flutter/material.dart';

const dorneColor = Color(0xFF2e2425);

final dorneThemeData = ThemeData(
  primaryColor: dorneColor,
  colorScheme: const ColorScheme(
    primary: dorneColor,
    primaryVariant: dorneColor,
    secondary: Colors.white,
    secondaryVariant: dorneColor,
    surface: dorneColor,
    background: dorneColor,
    error: dorneColor,
    onPrimary: Colors.white,
    onSecondary: dorneColor,
    onSurface: Colors.white,
    onBackground: dorneColor,
    onError: dorneColor,
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
