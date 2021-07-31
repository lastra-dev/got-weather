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
    return SizedBox(
      height: MediaQuery.of(context).size.height -
          Scaffold.of(context).appBarMaxHeight! -
          142,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          WeatherInfoWidget(
            weather: weather,
          ),
          BigText(
            'FEELS\nLIKE\n${gotWeather.cityName.toUpperCase()}',
          ),
          const SizedBox(
            height: 40,
          ),
          SubtitleText(
            gotWeather.description.toUpperCase(),
          ),
        ],
      ),
    );
  }
}
