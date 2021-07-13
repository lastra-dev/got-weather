import 'package:got_weather/core/error/exception.dart';
import 'package:got_weather/core/network/network_info.dart';
import 'package:got_weather/features/weather/data/datasources/weather_local_data_source.dart';
import 'package:got_weather/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:got_weather/features/weather/domain/entities/weather.dart';
import 'package:got_weather/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:got_weather/features/weather/domain/repositories/weather_repository.dart';

typedef CityOrLocationChooser = Future<Weather> Function();

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
  Future<Either<Failure, Weather>> getWeatherFromCity(String cityName) async {
    return _getWeather(() => remoteDataSource.getWeatherFromCity(cityName));
  }

  @override
  Future<Either<Failure, Weather>> getWeatherFromLocation() async {
    return _getWeather(() => remoteDataSource.getWeatherFromLocation());
  }

  Future<Either<Failure, Weather>> _getWeather(
      CityOrLocationChooser getWeatherFromCityOrLocation) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteWeather = await getWeatherFromCityOrLocation();
        localDataSource.cacheCityName(remoteWeather.cityName);
        return Right(remoteWeather);
      } on ServerException {
        return Left(ServerFailure());
      } on PermissionException {
        return Left(PermissionFailure());
      } on ServiceDisabledException {
        return Left(ServiceDisabledFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
