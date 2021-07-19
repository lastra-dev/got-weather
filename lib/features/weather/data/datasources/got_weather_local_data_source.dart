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
    background: 'winterfellBg',
    minTemp: -100,
    maxTemp: 10,
  ),
  GOTWeather(
    description: 'You might catch a snake...',
    cityName: 'Dorne',
    background: 'dorneBg',
    minTemp: 11,
    maxTemp: 100,
  )
];

enum GOTCity {
  winterfell,
  dorne,
}
