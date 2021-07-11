import 'package:equatable/equatable.dart';
import 'package:got_weather/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:got_weather/core/usecases/usecase.dart';
import 'package:got_weather/features/weather/domain/entities/weather.dart';
import 'package:got_weather/features/weather/domain/repositories/weather_repository.dart';

class GetWeatherFromLocation
    extends UseCase<Weather, WeatherFromLocationParams> {
  final WeatherRepository repository;

  GetWeatherFromLocation(this.repository);

  @override
  Future<Either<Failure, Weather>> call(WeatherFromLocationParams params) {
    return repository.getWeatherFromLocation(
      params.latitude,
      params.longitude,
    );
  }
}

class WeatherFromLocationParams extends Equatable {
  final double latitude;
  final double longitude;

  const WeatherFromLocationParams({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [latitude, longitude];
}
