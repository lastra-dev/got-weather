import 'package:flutter/material.dart';

import '../pages/weather_page.dart';

class InitialMaterialApp extends StatelessWidget {
  final Color primaryColor;
  const InitialMaterialApp({
    required this.primaryColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GOT Weather',
      theme: ThemeData(
        primaryColor: primaryColor,
        fontFamily: 'Poppins',
      ),
      home: const WeatherPage(),
    );
  }
}
