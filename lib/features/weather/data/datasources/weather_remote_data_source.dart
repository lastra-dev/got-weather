import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:got_weather/core/error/exception.dart';
import 'package:got_weather/features/weather/data/models/weather_model.dart';
import 'package:http/http.dart' as http;

abstract class WeatherRemoteDataSource {
  /// Calls the api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}&units=metric endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<WeatherModel> getWeatherFromCity(String cityName);

  /// Calls the api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}&units=metric endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<WeatherModel> getWeatherFromLocation(
    double latitude,
    double longitude,
  );
}

const weatherApi = 'WEATHER_API';

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client client;

  WeatherRemoteDataSourceImpl({required this.client});

  Future<String?> getAppId() async {
    final dotenvSingleton = DotEnv();
    await dotenvSingleton.load();
    return dotenvSingleton.env[weatherApi];
  }

  @override
  Future<WeatherModel> getWeatherFromCity(String cityName) async {
    final appId = await getAppId();
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$appId&units=metric');
    return _getWeatherFromUrl(url);
  }

  @override
  Future<WeatherModel> getWeatherFromLocation(
      double latitude, double longitude) async {
    final appId = await getAppId();
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$appId&units=metric');
    return _getWeatherFromUrl(url);
  }

  Future<WeatherModel> _getWeatherFromUrl(Uri url) async {
    final response = await client.get(url);

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(
          json.decode(response.body) as Map<String, dynamic>);
    } else {
      throw ServerException();
    }
  }
}
