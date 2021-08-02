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
    appTheme: AppTheme.beyondTheWall,
    title: "Feels Like\nBeyond\nthe wall",
    subtitle: 'Looks like an arrowhead...',
    background: 'beyondTheWallBg',
    minTemp: -100,
    maxTemp: 10,
  ),
  GOTWeather(
    appTheme: AppTheme.winterfell,
    title: 'Feels\nLike\nWinterfell',
    subtitle: 'Winter is comming...',
    background: 'winterfellBg',
    minTemp: 11,
    maxTemp: 20,
  ),
  GOTWeather(
    appTheme: AppTheme.kingsLanding,
    title: "Feels Like\nKing's\nLanding",
    subtitle: 'Power is power...',
    background: 'kingsLandingBg',
    minTemp: 21,
    maxTemp: 30,
  ),
  GOTWeather(
    appTheme: AppTheme.dorne,
    title: 'Feels\nLike\nDorne',
    subtitle: 'You might catch a snake...',
    background: 'dorneBg',
    minTemp: 31,
    maxTemp: 100,
  ),
];

enum GOTCity {
  beyondTheWall,
  winterfell,
  kingsLanding,
  dorne,
}
