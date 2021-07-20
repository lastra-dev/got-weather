import 'package:flutter/material.dart';

import '../../../../core/theme/app_themes.dart';
import '../pages/weather_page.dart';

class WeatherMaterialApp extends StatelessWidget {
  final AppTheme appTheme;
  const WeatherMaterialApp({
    this.appTheme = AppTheme.initial,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    precacheImages(context);
    return MaterialApp(
      title: 'GOT Weather',
      theme: appThemeData[appTheme],
      home: const WeatherPage(),
    );
  }

  void precacheImages(BuildContext context) {
    precacheImage(const AssetImage("assets/images/winterfellBg.jpg"), context);
    precacheImage(const AssetImage("assets/images/dorneBg.jpg"), context);
  }
}
