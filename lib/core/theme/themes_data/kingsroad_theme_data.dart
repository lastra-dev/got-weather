import 'package:flutter/material.dart';

const kingsroadColor = Color(0xFF221611);

final kingsroadThemeData = ThemeData(
  primaryColor: kingsroadColor,
  colorScheme: const ColorScheme(
    primary: kingsroadColor,
    primaryVariant: kingsroadColor,
    secondary: Colors.white,
    secondaryVariant: kingsroadColor,
    surface: kingsroadColor,
    background: kingsroadColor,
    error: kingsroadColor,
    onPrimary: Colors.white,
    onSecondary: kingsroadColor,
    onSurface: Colors.white,
    onBackground: kingsroadColor,
    onError: kingsroadColor,
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
