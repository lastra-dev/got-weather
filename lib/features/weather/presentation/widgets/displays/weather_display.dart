import 'package:flutter/material.dart';

import '../../../domain/entities/got_weather.dart';
import '../../../domain/entities/weather.dart';
import '../display_widgets/big_text.dart';
import '../display_widgets/subtitle_text.dart';
import '../display_widgets/weather_info_widget.dart';

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
        const SizedBox(
          height: 10,
        ),
        WeatherInfoWidget(
          weather: weather,
        ),
        BigText(
          'FEELS\nLIKE\n${gotWeather.cityName.toUpperCase()}',
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 7,
        ),
        SubtitleText(
          gotWeather.description,
        ),
      ],
    );
  }
}
