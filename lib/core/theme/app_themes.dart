import 'package:flutter/material.dart';

enum AppTheme {
  initial,
  winterfell,
  dorne,
}

final appThemeData = {
  AppTheme.initial: ThemeData(
    primaryColor: const Color(0xFF272935),
    accentColor: const Color(0xFF272935),
  ),
  AppTheme.winterfell: ThemeData(
    primaryColor: const Color(0xFF111844),
    accentColor: const Color(0xFF111844),
  ),
  AppTheme.dorne: ThemeData(
    primaryColor: const Color(0xFF950330),
    accentColor: const Color(0xFF950330),
  ),
};
