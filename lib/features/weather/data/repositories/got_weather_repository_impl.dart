import 'package:dartz/dartz.dart';
import '../../../../core/error/exception.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/got_weather.dart';
import '../../domain/repositories/got_weather_repository.dart';
import '../datasources/got_weather_local_data_source.dart';

class GOTWeatherRepositoryImpl implements GOTWeatherRepository {
  final GOTWeatherLocalDataSource localDataSource;

  GOTWeatherRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, GOTWeather>> getGOTWeather(int temperature) async {
    try {
      return Right(localDataSource.getGOTWeather(temperature));
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
