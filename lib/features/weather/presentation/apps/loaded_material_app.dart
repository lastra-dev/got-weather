import 'package:flutter/material.dart';
import '../pages/weather_page.dart';

class LoadedMaterialApp extends StatelessWidget {
  const LoadedMaterialApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GOT Weather',
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(149, 3, 48, 1),
        fontFamily: 'Poppins',
      ),
      home: const WeatherPage(),
    );
  }
}
