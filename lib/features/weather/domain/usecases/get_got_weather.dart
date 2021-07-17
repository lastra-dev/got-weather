import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/got_weather.dart';
import '../repositories/got_weather_repository.dart';

class GetGOTWeather extends UseCase<GOTWeather, GOTWeatherParams> {
  final GOTWeatherRepository repository;

  GetGOTWeather(this.repository);

  @override
  Future<Either<Failure, GOTWeather>> call(GOTWeatherParams params) async {
    return repository.getGOTWeather(params.temperature);
  }
}

class GOTWeatherParams extends Equatable {
  final int temperature;

  const GOTWeatherParams({required this.temperature});

  @override
  List<Object?> get props => [temperature];
}
