import 'package:dartz/dartz.dart';
import 'package:got_weather/features/weather/domain/entities/weather.dart';

import '../../../../core/error/failures.dart';
import '../entities/got_weather.dart';

abstract class GOTWeatherRepository {
  Either<Failure, GOTWeather> getGOTWeather(Weather weather);
}
