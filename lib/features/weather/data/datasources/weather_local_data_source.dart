import 'dart:convert';

import 'package:got_weather/core/error/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class WeatherLocalDataSource {
  Future<String> getLastCityName();
  Future<void> cacheCityName(String cityName);
}

const cachedCityName = 'CACHED_CITY_NAME';

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  final SharedPreferences sharedPreferences;

  WeatherLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheCityName(String cityName) {
    final jsonString = {"cityName": cityName};
    return sharedPreferences.setString(cachedCityName, json.encode(jsonString));
  }

  @override
  Future<String> getLastCityName() {
    final jsonString = sharedPreferences.getString(cachedCityName);
    if (jsonString != null) {
      final cityName = json.decode(jsonString)['cityName'].toString();
      return Future.value(cityName);
    } else {
      throw CacheException();
    }
  }
}
