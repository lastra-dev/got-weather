import 'package:got_weather/core/error/exception.dart';
import 'package:got_weather/features/weather/domain/entities/got_weather.dart';

abstract class GOTWeatherLocalDataSource {
  /// Matches a temperature with a [GOTWeather] temperature range and returns a GOTWeather
  GOTWeather getGOTWeather(int temperature);
}

class GOTWeatherLocalDataSourceImpl implements GOTWeatherLocalDataSource {
  @override
  GOTWeather getGOTWeather(int temperature) {
    return gotWeatherData.firstWhere(
      (element) =>
          temperature >= element.minTemp && temperature <= element.maxTemp,
      orElse: () => throw CacheException(),
    );
  }
}

const gotWeatherData = [
  GOTWeather(
    description: 'Ice place',
    cityName: 'Winterfell',
    background: 'winterfell',
    minTemp: -4,
    maxTemp: 5,
  ),
  GOTWeather(
    description: 'Fire place',
    cityName: 'Dorne',
    background: 'dorne',
    minTemp: 20,
    maxTemp: 35,
  )
];

enum GOTCity {
  winterfell,
  dorne,
}
