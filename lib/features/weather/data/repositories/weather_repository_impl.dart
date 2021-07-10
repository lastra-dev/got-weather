import 'package:got_weather/core/network/network_info.dart';
import 'package:got_weather/features/weather/data/datasources/weather_local_data_source.dart';
import 'package:got_weather/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:got_weather/features/weather/domain/entities/weather.dart';
import 'package:got_weather/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:got_weather/features/weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  final WeatherLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  WeatherRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Weather>> getWeatherFromCity(String cityName) {
    // TODO: implement getWeatherFromCity
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Weather>> getWeatherFromLocation(
      double latitude, double longitude) {
    // TODO: implement getWeatherFromLocation
    throw UnimplementedError();
  }
}
