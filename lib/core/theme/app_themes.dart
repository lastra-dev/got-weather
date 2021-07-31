import 'themes_data/themes_data.dart';

enum AppTheme {
  initial,
  winterfell,
  dorne,
  kingsLanding,
}

final appThemeData = {
  AppTheme.initial: initialThemeData,
  AppTheme.dorne: dorneThemeData,
  AppTheme.winterfell: winterfellThemeData,
  AppTheme.kingsLanding: kingsLandingThemeData,
};
