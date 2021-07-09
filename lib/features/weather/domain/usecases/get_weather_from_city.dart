import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:got_weather/core/error/failures.dart';
import 'package:got_weather/core/usecases/usecase.dart';
import 'package:got_weather/features/weather/domain/entities/weather.dart';
import 'package:got_weather/features/weather/domain/repositories/weather_repository.dart';

class GetWeatherFromCity extends UseCase<Weather, Params> {
  final WeatherRepository repository;

  GetWeatherFromCity(this.repository);

  @override
  Future<Either<Failure, Weather>> call(Params params) async {
    return repository.getWeatherFromCity(params.cityName);
  }
}

class Params extends Equatable {
  final String cityName;

  const Params({
    required this.cityName,
  });

  @override
  List<Object?> get props => [cityName];
}
