import 'package:got_weather/features/weather/data/models/weather_model.dart';

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
