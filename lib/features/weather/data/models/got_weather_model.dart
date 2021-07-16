import 'package:got_weather/features/weather/domain/entities/got_weather.dart';

class GOTWeatherModel extends GOTWeather {
  const GOTWeatherModel({
    required int minTemp,
    required int maxTemp,
    required String cityName,
    required String background,
    required String description,
  }) : super(
          minTemp: minTemp,
          maxTemp: maxTemp,
          cityName: cityName,
          background: background,
          description: description,
        );
}
