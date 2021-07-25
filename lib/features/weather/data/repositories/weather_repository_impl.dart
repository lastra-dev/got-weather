import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/weather.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_local_data_source.dart';
import '../datasources/weather_remote_data_source.dart';

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
    return _getWeather(
      () => remoteDataSource.getWeatherFromLocation(),
      cacheCityName: true,
    );
  }

  @override
  Future<Either<Failure, Weather>> getWeatherFromLastCity() async {
    try {
      final lastCityName = await localDataSource.getLastCityName();
      return getWeatherFromCity(lastCityName);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  Future<Either<Failure, Weather>> _getWeather(
    CityOrLocationChooser getWeatherFromCityOrLocation, {
    bool cacheCityName = false,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteWeather = await getWeatherFromCityOrLocation();
        if (cacheCityName) {
          localDataSource.cacheCityName(remoteWeather.cityName);
        }
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
