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

    // when(() => mockLocalDataSource.getUserLocation())
    // .thenAnswer((_) async => tLocationModel);
  });

  group('getWeatherFromCity', () {
    _runTestsOnline(() {
      test('should check if the device is online', () {
        // arrange
        when(() => mockRemoteDataSource.getWeatherFromCity(tCityName))
            .thenAnswer((_) async => tWeatherModel);
        // act
        repository.getWeatherFromCity(tCityName);
        // assert
        verify(() => mockNetworkInfo.isConnected);
      });

      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(() => mockRemoteDataSource.getWeatherFromCity(tCityName))
            .thenAnswer((_) async => tWeatherModel);
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
    _runTestsOnline(() {
      setUp(() {
        when(() => mockLocalDataSource.cacheLocation(tLocationModel))
            .thenAnswer((_) async {});
        when(() => mockLocalDataSource.getUserLocation())
            .thenAnswer((_) async => tLocationModel);
      });

      test('should check if the device is online', () async {
        // throw exception to avoid more setup
        when(() => mockLocalDataSource.getUserLocation())
            .thenThrow(PermissionException());
        // act
        await repository.getWeatherFromLocation();
        // assert
        verify(() => mockNetworkInfo.isConnected);
      });

      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(() => mockRemoteDataSource.getWeatherFromLocation(tLat, tLon))
            .thenAnswer((_) async => tWeatherModel);
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
        // act
        final result = await repository.getWeatherFromLocation();
        // assert
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, equals(Left(NetworkFailure())));
      });
    });
  });

  group('getWeatherFromLastLocation', () {
    _runTestsOnline(() {
      test(
        'should return local data when the call to local data source is successful',
        () async {
          // arrange
          when(() => mockRemoteDataSource.getWeatherFromLocation(tLat, tLon))
              .thenAnswer((_) async => tWeatherModel);
          when(() => mockLocalDataSource.getLastLocation())
              .thenAnswer((_) async => tLocationModel);
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
