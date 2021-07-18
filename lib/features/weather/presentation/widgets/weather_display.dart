import 'package:flutter/material.dart';
import 'package:got_weather/features/weather/domain/entities/got_weather.dart';
import 'package:got_weather/features/weather/domain/entities/weather.dart';

import 'feels_like_widget.dart';

class WeatherDisplay extends StatelessWidget {
  final Weather weather;
  final GOTWeather gotWeather;

  const WeatherDisplay({
    Key? key,
    required this.weather,
    required this.gotWeather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WeatherWidget(weather: weather),
        const FeelsLikeWidget(),
      ],
    );
  }
}

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({
    Key? key,
    required this.weather,
  }) : super(key: key);

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 9,
            width: MediaQuery.of(context).size.width / 5,
            child:
                Image.asset('assets/images/weather_icons/${weather.icon}.png'),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 17,
            width: MediaQuery.of(context).size.width / 4,
            child: Text('${weather.temperature.toString()}ºC',
                style: const TextStyle(
                  fontSize: 30,
                  // color: Colors.white,
                ),
                textAlign: TextAlign.center),
          ),
          Text(
            weather.cityName,
            style: const TextStyle(
                // color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }
}
