import 'package:got_weather/core/error/exception.dart';
import 'package:got_weather/core/theme/app_themes.dart';
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
    appTheme: AppTheme.winterfell,
    description: 'Winter is comming...',
    cityName: 'Winterfell',
    background: 'winterfellBg',
    minTemp: -100,
    maxTemp: 19,
  ),
  GOTWeather(
    appTheme: AppTheme.dorne,
    description: 'You might catch a snake...',
    cityName: 'Dorne',
    background: 'dorneBg',
    minTemp: 30,
    maxTemp: 100,
  ),
  GOTWeather(
    appTheme: AppTheme.kingsLanding,
    description: 'Power is power...',
    cityName: "King's Landing",
    background: 'kingsLanding',
    minTemp: 20,
    maxTemp: 29,
  )
];

enum GOTCity {
  winterfell,
  dorne,
}
