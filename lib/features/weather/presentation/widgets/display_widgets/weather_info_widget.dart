import 'package:flutter/material.dart';

import '../../../domain/entities/weather.dart';

class WeatherInfoWidget extends StatelessWidget {
  const WeatherInfoWidget({
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
          Text(
            '${weather.temperature.toString()}ºC',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(
            weather.cityName,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      ),
    );
  }
}
