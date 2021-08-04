import 'themes_data/themes_data.dart';

enum AppTheme {
  initial,
  winterfell,
  dorne,
  kingsLanding,
  beyondTheWall,
  highgarden,
  yunkai,
  dragonstone,
  dothrakiSea,
}

final appThemeData = {
  AppTheme.initial: initialThemeData,
  AppTheme.dorne: dorneThemeData,
  AppTheme.winterfell: winterfellThemeData,
  AppTheme.kingsLanding: kingsLandingThemeData,
  AppTheme.beyondTheWall: beyondTheWallThemeData,
  AppTheme.highgarden: highgardenThemeData,
  AppTheme.yunkai: yunkaiThemeData,
  AppTheme.dragonstone: dragonstoneThemeData,
  AppTheme.dothrakiSea: dothrakiSeaThemeData,
};
