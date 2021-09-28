import 'package:flutter/material.dart';

const yunkaiColor = Color(0xFF301B16);

final yunkaiThemeData = ThemeData(
  primaryColor: yunkaiColor,
  colorScheme: const ColorScheme(
    primary: yunkaiColor,
    primaryVariant: yunkaiColor,
    secondary: Colors.white,
    secondaryVariant: yunkaiColor,
    surface: yunkaiColor,
    background: yunkaiColor,
    error: yunkaiColor,
    onPrimary: Colors.white,
    onSecondary: yunkaiColor,
    onSurface: Colors.white,
    onBackground: yunkaiColor,
    onError: yunkaiColor,
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
