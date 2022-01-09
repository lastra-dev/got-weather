import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:got_weather/core/error/exception.dart';
import 'package:got_weather/core/error/failures.dart';
import 'package:got_weather/core/theme/app_themes.dart';
import 'package:got_weather/features/weather/data/datasources/got_weather_local_data_source.dart';
import 'package:got_weather/features/weather/data/repositories/got_weather_repository_impl.dart';
import 'package:got_weather/features/weather/domain/entities/got_weather.dart';
import 'package:mocktail/mocktail.dart';

class MockGOTWeatherLocalDataSource extends Mock
    implements GOTWeatherLocalDataSource {}

void main() {
  late MockGOTWeatherLocalDataSource mockGOTWeatherLocalDataSource;
  late GOTWeatherRepositoryImpl repository;

  const tTemperature = 3;

  const tGOTWeather = GOTWeather(
    appTheme: AppTheme.winterfell,
    subtitle: 'a description',
    title: 'Winterfell',
    minTemp: -4,
    maxTemp: 5,
    background: 'background',
  );

  setUp(() {
    mockGOTWeatherLocalDataSource = MockGOTWeatherLocalDataSource();
    repository = GOTWeatherRepositoryImpl(
      localDataSource: mockGOTWeatherLocalDataSource,
    );
  });

  test(
    'should get local data when the call to GOTWeatherLocalDataSource is successful',
    () async {
      // arrange
      when(() => mockGOTWeatherLocalDataSource.getGOTWeather(any()))
          .thenAnswer((_) => tGOTWeather);
      // act
      final result = await repository.getGOTWeather(tTemperature);
      // assert
      verify(() => mockGOTWeatherLocalDataSource.getGOTWeather(tTemperature));
      expect(result, equals(const Right(tGOTWeather)));
    },
  );

  test(
    'should return CacheFailure when the call to local data source is unsuccessful',
    () async {
      // arrange
      when(() => mockGOTWeatherLocalDataSource.getGOTWeather(any()))
          .thenThrow(CacheException());
      // act
      final result = await repository.getGOTWeather(tTemperature);
      // assert
      verify(() => mockGOTWeatherLocalDataSource.getGOTWeather(tTemperature));
      expect(result, equals(Left(CacheFailure())));
    },
  );
}
