import 'package:flutter/material.dart';

import '../pages/weather_page.dart';

class WeatherMaterialApp extends StatelessWidget {
  final Color primaryColor;
  const WeatherMaterialApp({
    this.primaryColor = const Color(0xFF272935),
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GOT Weather',
      theme: ThemeData(
        primaryColor: primaryColor,
        accentColor: primaryColor,
        fontFamily: 'Poppins',
      ),
      home: const WeatherPage(),
    );
  }
}
