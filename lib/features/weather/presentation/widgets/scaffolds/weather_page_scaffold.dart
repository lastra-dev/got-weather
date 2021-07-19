import 'package:flutter/material.dart';

import '../bodies/weather_page_body.dart';

class WeatherPageScaffold extends StatelessWidget {
  final String background;

  const WeatherPageScaffold({
    required this.background,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3),
            BlendMode.darken,
          ),
          image: AssetImage('assets/images/$background.jpg'),
          fit: BoxFit.fill,
          alignment: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: const Text('GOT Weather')),
        body: const WeatherPageBody(),
      ),
    );
  }
}
