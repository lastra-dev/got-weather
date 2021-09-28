import 'package:flutter/material.dart';

const volantisColor = Color(0xFF251B00);

final volantisThemeData = ThemeData(
  primaryColor: volantisColor,
  colorScheme: const ColorScheme(
    primary: volantisColor,
    primaryVariant: volantisColor,
    secondary: Colors.white,
    secondaryVariant: volantisColor,
    surface: volantisColor,
    background: volantisColor,
    error: volantisColor,
    onPrimary: Colors.white,
    onSecondary: volantisColor,
    onSurface: Colors.white,
    onBackground: volantisColor,
    onError: volantisColor,
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
