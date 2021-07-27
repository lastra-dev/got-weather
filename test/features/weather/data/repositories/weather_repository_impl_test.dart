import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:got_weather/core/error/exception.dart';
import 'package:got_weather/core/error/failures.dart';
import 'package:got_weather/core/network/network_info.dart';
import 'package:got_weather/features/weather/data/datasources/weather_local_data_source.dart';
import 'package:got_weather/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:got_weather/features/weather/data/models/location_model.dart';
import 'package:got_weather/features/weather/data/models/weather_model.dart';
import 'package:got_weather/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:got_weather/features/weather/domain/entities/weather.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock implements WeatherRemoteDataSource {}

class MockLocalDataSource extends Mock implements WeatherLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late WeatherRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  const tLat = '22.0';
  const tLon = '-97.0';
  const tCityName = 'Tampico';
  const tWeatherModel = WeatherModel(
    cityName: tCityName,
    icon: '01d',
    temperature: 20,
  );
  const Weather tWeather = tWeatherModel;
  const tLocationModel = LocationModel(
    lat: 22,
    lon: -97,
  );

  void _runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void _runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = WeatherRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );

    when(() => mockLocalDataSource.getUserLocation())
        .thenAnswer((_) async => tLocationModel);
  });

  group('getWeatherFromCity', () {
    test('should check if the device is online', () {
      // arrange
      when(() => mockLocalDataSource.cacheLocation(tLocationModel))
          .thenAnswer((_) async {});
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.getWeatherFromCity(tCityName))
          .thenAnswer((_) async => tWeatherModel);
      // act
      repository.getWeatherFromCity(tCityName);
      // assert
      verify(() => mockNetworkInfo.isConnected);
    });

    _runTestsOnline(() {
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(() => mockRemoteDataSource.getWeatherFromCity(tCityName))
            .thenAnswer((_) async => tWeatherModel);
        when(() => mockLocalDataSource.cacheLocation(tLocationModel))
            .thenAnswer((_) async {});
        // act
        final result = await repository.getWeatherFromCity(tCityName);
        // assert
        verify(() => mockRemoteDataSource.getWeatherFromCity(tCityName));
        expect(result, equals(const Right(tWeather)));
      });

      test(
          'should return ServerFailure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(() => mockRemoteDataSource.getWeatherFromCity(tCityName))
            .thenThrow(ServerException());
        // act
        final result = await repository.getWeatherFromCity(tCityName);
        // assert
        verify(() => mockRemoteDataSource.getWeatherFromCity(tCityName));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    _runTestsOffline(() {
      test('should return NetworkFailure when device is offline', () async {
        // act
        final result = await repository.getWeatherFromCity(tCityName);

        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, equals(Left(NetworkFailure())));
      });
    });
  });

  group('getWeatherFromLocation', () {
    const tCityName = 'Tampico';
    const tWeatherModel = WeatherModel(
      cityName: tCityName,
      icon: '01d',
      temperature: 20,
    );
    const Weather tWeather = tWeatherModel;

    test('should check if the device is online', () async {
      // arrange
      when(() => mockLocalDataSource.getUserLocation())
          .thenAnswer((_) async => tLocationModel);
      when(() => mockLocalDataSource.cacheLocation(tLocationModel))
          .thenAnswer((_) async {});
      when(() => mockRemoteDataSource.getWeatherFromLocation(tLat, tLon))
          .thenAnswer((_) async => tWeatherModel);
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      await repository.getWeatherFromLocation();
      // assert
      verify(() => mockNetworkInfo.isConnected);
    });

    _runTestsOnline(() {
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(() => mockRemoteDataSource.getWeatherFromLocation(tLat, tLon))
            .thenAnswer((_) async => tWeatherModel);
        when(() => mockLocalDataSource.cacheLocation(tLocationModel))
            .thenAnswer((_) async {});
        // act
        final result = await repository.getWeatherFromLocation();
        // assert
        verify(() => mockRemoteDataSource.getWeatherFromLocation(tLat, tLon));
        expect(result, equals(const Right(tWeather)));
      });

      test(
          'should cache the data locally when the call to remote data source is successful',
          () async {
        // arrange
        when(() => mockRemoteDataSource.getWeatherFromLocation(tLat, tLon))
            .thenAnswer((_) async => tWeatherModel);
        when(() => mockLocalDataSource.cacheLocation(tLocationModel))
            .thenAnswer((_) async {});
        // act
        await repository.getWeatherFromLocation();
        // assert
        verify(() => mockRemoteDataSource.getWeatherFromLocation(tLat, tLon));
        verify(() => mockLocalDataSource.cacheLocation(tLocationModel));
      });

      test(
          'should return ServerFailure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(() => mockRemoteDataSource.getWeatherFromLocation(tLat, tLon))
            .thenThrow(ServerException());
        when(() => mockLocalDataSource.cacheLocation(tLocationModel))
            .thenAnswer((_) async => {});
        // act
        final result = await repository.getWeatherFromLocation();
        // assert
        verify(() => mockRemoteDataSource.getWeatherFromLocation(tLat, tLon));
        expect(result, equals(Left(ServerFailure())));
      });

      test(
        'should return PermissionFailure when the location is denied and PermissionException is thrown',
        () async {
          // arrange
          when(() => mockLocalDataSource.getUserLocation())
              .thenThrow(PermissionException());
          when(() => mockLocalDataSource.cacheLocation(tLocationModel))
              .thenAnswer((_) async => {});
          // act
          final result = await repository.getWeatherFromLocation();
          // assert
          verify(() => mockLocalDataSource.getUserLocation());
          verifyNever(() => mockLocalDataSource.cacheLocation(tLocationModel));
          expect(result, equals(Left(PermissionFailure())));
        },
      );

      test(
        'should return ServiceDisabledFailure when the service is disabled and ServiceDisabledException is thrown',
        () async {
          // arrange
          when(() => mockLocalDataSource.getUserLocation())
              .thenThrow(ServiceDisabledException());
          when(() => mockLocalDataSource.cacheLocation(tLocationModel))
              .thenAnswer((_) async => {});
          // act
          final result = await repository.getWeatherFromLocation();
          // assert
          verifyNever(() => mockLocalDataSource.cacheLocation(tLocationModel));
          expect(result, equals(Left(ServiceDisabledFailure())));
        },
      );
    });

    _runTestsOffline(() {
      test('should return NetworkFailure when device is offline', () async {
        // arrange
        when(() => mockRemoteDataSource.getWeatherFromLocation(tLat, tLon))
            .thenAnswer((_) async => tWeatherModel);
        when(() => mockLocalDataSource.cacheLocation(tLocationModel))
            .thenAnswer((_) async {});
        // act
        final result = await repository.getWeatherFromLocation();
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, equals(Left(NetworkFailure())));
      });
    });
  });

  group('getWeatherFromLastCity', () {
    _runTestsOnline(() {
      test(
        'should get last city from local data source',
        () async {
          // arrange
          when(() => mockRemoteDataSource.getWeatherFromLocation(tLat, tLon))
              .thenAnswer((_) async => tWeatherModel);
          when(() => mockLocalDataSource.getLastLocation())
              .thenAnswer((_) async => tLocationModel);
          when(() => mockRemoteDataSource.getWeatherFromCity(tCityName))
              .thenAnswer((_) async => tWeatherModel);
          when(() => mockLocalDataSource.cacheLocation(tLocationModel))
              .thenAnswer((_) async {});
          // act
          await repository.getWeatherFromLastLocation();
          // assert
          verify(() => mockLocalDataSource.getLastLocation());
        },
      );

      test(
        'should return Weather when call is successful',
        () async {
          // arrange
          when(() => mockRemoteDataSource.getWeatherFromLocation(tLat, tLon))
              .thenAnswer((_) async => tWeatherModel);
          when(() => mockLocalDataSource.getLastLocation())
              .thenAnswer((_) async => tLocationModel);
          when(() => mockRemoteDataSource.getWeatherFromCity(tCityName))
              .thenAnswer((_) async => tWeatherModel);
          when(() => mockLocalDataSource.cacheLocation(tLocationModel))
              .thenAnswer((_) async {});
          // act
          final result = await repository.getWeatherFromLastLocation();
          // assert
          expect(result, equals(const Right(tWeather)));
        },
      );

      test(
        'should return CacheFailure when call to localDataSource is unsuccessful',
        () async {
          // arrange
          when(() => mockLocalDataSource.getLastLocation())
              .thenThrow(CacheException());
          // act
          final result = await repository.getWeatherFromLastLocation();
          // assert
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });
}
