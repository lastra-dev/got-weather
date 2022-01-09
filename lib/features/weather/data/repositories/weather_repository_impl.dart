import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/weather.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_local_data_source.dart';
import '../datasources/weather_remote_data_source.dart';

typedef RemoteWeather = Future<Weather> Function();

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
    return _getWeather(
      () async => remoteDataSource.getWeatherFromCity(cityName),
    );
  }

  @override
  Future<Either<Failure, Weather>> getWeatherFromLocation() async {
    return _getWeather(() async {
      final location = await localDataSource.getUserLocation();
      await localDataSource.cacheLocation(location);
      final remoteWeather = await remoteDataSource.getWeatherFromLocation(
        location.lat.toString(),
        location.lon.toString(),
      );
      return remoteWeather;
    });
  }

  @override
  Future<Either<Failure, Weather>> getWeatherFromLastLocation() async {
    return _getWeather(
      () async {
        final location = await localDataSource.getLastLocation();
        final remoteWeather = await remoteDataSource.getWeatherFromLocation(
          location.lat.toString(),
          location.lon.toString(),
        );
        return remoteWeather;
      },
    );
  }

  Future<Either<Failure, Weather>> _getWeather(
    RemoteWeather getRemoteWeather,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await getRemoteWeather());
      } on ServerException {
        return Left(ServerFailure());
      } on CacheException {
        return Left(CacheFailure());
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
