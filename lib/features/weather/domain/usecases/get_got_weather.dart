import 'package:equatable/equatable.dart';
import 'package:got_weather/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:got_weather/core/usecases/usecase.dart';
import 'package:got_weather/features/weather/domain/entities/got_weather.dart';
import 'package:got_weather/features/weather/domain/entities/weather.dart';
import 'package:got_weather/features/weather/domain/repositories/got_weather_repository.dart';

class GetGOTWeather extends UseCase<GOTWeather, GOTWeatherParams> {
  final GOTWeatherRepository repository;

  GetGOTWeather(this.repository);

  @override
  Future<Either<Failure, GOTWeather>> call(GOTWeatherParams params) async {
    return repository.getGOTWeather(params.weather);
  }
}

class GOTWeatherParams extends Equatable {
  final Weather weather;

  const GOTWeatherParams({required this.weather});

  @override
  List<Object?> get props => [weather];
}
