import 'package:flutter/material.dart';

const initialColor = Color(0xFF3d3030);
const otherColor = Color(0xFF58736F);

final initialThemeData = ThemeData(
  primaryColor: initialColor,
  colorScheme: const ColorScheme(
    primary: Colors.white,
    primaryVariant: initialColor,
    secondary: Colors.white,
    secondaryVariant: initialColor,
    surface: initialColor,
    background: initialColor,
    error: initialColor,
    onPrimary: Colors.white,
    onSecondary: initialColor,
    onSurface: Colors.white,
    onBackground: initialColor,
    onError: initialColor,
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
