import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getWeatherFromCity(String cityName);
  Future<Either<Failure, Weather>> getWeatherFromLocation();
}
