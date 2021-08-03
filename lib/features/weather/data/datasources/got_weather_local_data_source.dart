import 'package:got_weather/core/error/exception.dart';
import 'package:got_weather/features/weather/domain/entities/got_weather.dart';
import 'got_weather_data.dart';

abstract class GOTWeatherLocalDataSource {
  /// Matches a temperature with a [GOTWeather] temperature range and returns a GOTWeather
  GOTWeather getGOTWeather(int temperature);
}

class GOTWeatherLocalDataSourceImpl implements GOTWeatherLocalDataSource {
  @override
  GOTWeather getGOTWeather(int temperature) {
    GOTWeather? gotWeather;
    gotWeatherData.forEach((_, data) {
      if (temperature >= data.minTemp && temperature <= data.maxTemp) {
        gotWeather = data;
      }
    });

    if (gotWeather != null) {
      return gotWeather!;
    } else {
      throw CacheException();
    }
  }
}
