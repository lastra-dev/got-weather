import 'package:got_weather/features/weather/domain/entities/weather.dart';

abstract class WeatherLocalDataSource {
  Future<Weather> getLastCityName();
  Future<void> cacheCityName(String cityName);
}
