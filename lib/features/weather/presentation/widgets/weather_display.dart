import 'package:flutter/material.dart';
import 'package:got_weather/features/weather/domain/entities/weather.dart';

class WeatherDisplay extends StatelessWidget {
  final Weather weather;

  const WeatherDisplay({
    Key? key,
    required this.weather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 10,
            width: MediaQuery.of(context).size.width / 4,
            child:
                Image.asset('assets/images/weather_icons/${weather.icon}.png'),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: MediaQuery.of(context).size.height / 14,
            width: MediaQuery.of(context).size.width / 4,
            child: Text('${weather.temperature.toString()}ºC',
                textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}
