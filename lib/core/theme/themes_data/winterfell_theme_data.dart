import 'package:flutter/material.dart';

const winterfellColor = Color(0xFF031530);

final winterfellThemeData = ThemeData(
  primaryColor: winterfellColor,
  colorScheme: const ColorScheme(
    primary: winterfellColor,
    primaryVariant: winterfellColor,
    secondary: Colors.white,
    secondaryVariant: winterfellColor,
    surface: winterfellColor,
    background: winterfellColor,
    error: winterfellColor,
    onPrimary: Colors.white,
    onSecondary: winterfellColor,
    onSurface: Colors.white,
    onBackground: winterfellColor,
    onError: winterfellColor,
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
