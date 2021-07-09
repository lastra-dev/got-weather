import 'package:dartz/dartz.dart';
import 'package:got_weather/core/error/failures.dart';
import 'package:got_weather/features/weather/domain/entities/weather.dart';
import 'package:got_weather/features/weather/domain/repositories/weather_repository.dart';

class GetWeatherFromCity {
  final WeatherRepository repository;

  GetWeatherFromCity(this.repository);

  Future<Either<Failure, Weather>> call({required String cityName}) async {
    return repository.getWeatherFromCity(cityName);
  }
}
