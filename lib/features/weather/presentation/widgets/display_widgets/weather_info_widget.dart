import 'package:flutter/material.dart';

import '../../../domain/entities/weather.dart';

class WeatherInfoWidget extends StatelessWidget {
  const WeatherInfoWidget({
    required this.weather,
    Key? key,
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
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
            textAlign: TextAlign.center,
          ),
          if (weather.country == null) _LocationText(weather.cityName),
          if (weather.country != null)
            _LocationText('${weather.cityName}, ${weather.country}'),
        ],
      ),
    );
  }
}

class _LocationText extends StatelessWidget {
  const _LocationText(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) => Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.subtitle2!.copyWith(
              height: 1,
            ),
      );
}
