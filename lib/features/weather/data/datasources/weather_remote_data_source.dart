import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

import '../../../../core/error/exception.dart';
import '../models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  /// Calls the api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}&units=metric endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<WeatherModel> getWeatherFromCity(String cityName);

  /// Calls the api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}&units=metric endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<WeatherModel> getWeatherFromLocation();
}

const weatherApi = 'WEATHER_API';

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client client;
  final Location location;

  WeatherRemoteDataSourceImpl({
    required this.client,
    required this.location,
  });

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
  Future<WeatherModel> getWeatherFromLocation() async {
    final appId = await getAppId();
    final locData = await getUserLocation();
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${locData.latitude}&lon=${locData.longitude}&appid=$appId&units=metric');
    return _getWeatherFromUrl(url);
  }

  Future<LocationData> getUserLocation() async {
    final location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        throw ServiceDisabledException();
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        throw PermissionException();
      }
    }

    return location.getLocation();
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
