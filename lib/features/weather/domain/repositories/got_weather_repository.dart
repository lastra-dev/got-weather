import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/got_weather.dart';

abstract class GOTWeatherRepository {
  Future<Either<Failure, GOTWeather>> getGOTWeather(int temperature);
}
