import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/weather.dart';
import '../repositories/weather_repository.dart';

class GetWeatherFromLastCity extends UseCase<Weather, NoParams> {
  final WeatherRepository repository;

  GetWeatherFromLastCity(this.repository);

  @override
  Future<Either<Failure, Weather>> call(NoParams params) async {
    return repository.getWeatherFromLastCity();
  }
}
