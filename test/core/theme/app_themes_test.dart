import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:got_weather/core/theme/app_themes.dart';

void main() {
  test(
    'appThemeData should be of type Map<AppTheme, ThemeData>',
    () async {
      // act
      final testVar = appThemeData;
      // assert
      expect(testVar, isA<Map<AppTheme, ThemeData>>());
    },
  );
}
