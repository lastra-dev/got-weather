import 'package:flutter/material.dart';

import '../bodies/weather_page_body.dart';

const initialBg = 'initialBg';

class WeatherPageScaffold extends StatelessWidget {
  final String background;

  const WeatherPageScaffold({
    this.background = initialBg,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(
              background == initialBg ? 0 : 0.3,
            ),
            BlendMode.darken,
          ),
          image: AssetImage('assets/images/$background.jpg'),
          fit: BoxFit.cover,
          alignment: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Row(
            children: const [
              Text('GOT Weather'),
              SizedBox(width: 10),
              Icon(Icons.ac_unit),
            ],
          ),
        ),
        body: const WeatherPageBody(),
      ),
    );
  }
}
