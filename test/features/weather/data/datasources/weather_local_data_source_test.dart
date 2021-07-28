import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:got_weather/core/error/exception.dart';
import 'package:got_weather/features/weather/data/datasources/weather_local_data_source.dart';
import 'package:got_weather/features/weather/data/models/location_model.dart';
import 'package:location/location.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockLocation extends Mock implements Location {}

void main() {
  late WeatherLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;
  late MockLocation mockLocation;

  const double tLatitude = 22;
  const double tLongitude = -97;
  const tLocationModel = LocationModel(lat: tLatitude, lon: tLongitude);

  void setUpMockGetLocation() {
    final tLocation = LocationData.fromMap({
      'latitude': tLatitude,
      'longitude': tLongitude,
    });
    when(() => mockLocation.getLocation()).thenAnswer((_) async => tLocation);
  }

  void setUpMockGrantLocationPermissions() {
    when(() => mockLocation.serviceEnabled()).thenAnswer((_) async => true);
    when(() => mockLocation.hasPermission())
        .thenAnswer((_) async => PermissionStatus.granted);
  }

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    mockLocation = MockLocation();
    Location.instance = mockLocation;
    final Location mockLocationInstance = Location();
    dataSource = WeatherLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
      location: mockLocationInstance,
    );
  });

  group('getLastLocation', () {
    test(
        'should return location from SharedPreferences when there is one in cache',
        () async {
      // arrange
      when(() => mockSharedPreferences.getString(any()))
          .thenReturn(fixture('location_cached.json'));
      // act
      final result = await dataSource.getLastLocation();
      // assert
      verify(() => mockSharedPreferences.getString(cachedLocation));
      expect(result, equals(tLocationModel));
    });

    test('should throw a CacheException when there is not a cached value', () {
      // arrange
      when(() => mockSharedPreferences.getString(any())).thenReturn(null);
      // act
      final call = dataSource.getLastLocation;
      // assert
      expect(() => call(), throwsA(isInstanceOf<CacheException>()));
    });
  });

  group('cacheLocation', () {
    test('should call SharedPreferences to cache the data', () {
      // arrange
      when(() => mockSharedPreferences.setString(cachedLocation, any()))
          .thenAnswer((_) async => true);
      // act
      dataSource.cacheLocation(tLocationModel);
      // assert
      final jsonString = tLocationModel.toJson();
      verify(
        () => mockSharedPreferences.setString(
          cachedLocation,
          json.encode(jsonString),
        ),
      );
    });
  });

  group('getUserLocation', () {
    test(
      'should call getLocation when getUserLocation is called',
      () async {
        // arrange
        setUpMockGrantLocationPermissions();
        setUpMockGetLocation();
        await dataSource.getUserLocation();
        // assert
        verify(() => mockLocation.getLocation());
      },
    );

    test('should throw PermissionException when location permission is denied',
        () async {
      // arrange
      when(() => mockLocation.serviceEnabled()).thenAnswer((_) async => true);
      when(() => mockLocation.hasPermission())
          .thenAnswer((_) async => PermissionStatus.denied);
      when(() => mockLocation.requestPermission())
          .thenAnswer((_) async => PermissionStatus.denied);
      // act
      final call = dataSource.getUserLocation;
      // assert
      expect(() => call(), throwsA(isInstanceOf<PermissionException>()));
    });

    test(
        'should throw ServiceDisabledException when location service is disabled',
        () {
      // arrange
      when(() => mockLocation.serviceEnabled()).thenAnswer((_) async => false);
      when(() => mockLocation.requestService()).thenAnswer((_) async => false);
      // act
      final call = dataSource.getUserLocation;
      // assert
      expect(() => call(), throwsA(isInstanceOf<ServiceDisabledException>()));
    });

    test(
      'should requestPermission() when hasPermission() returns PermissionStatus.denied',
      () async {
        // arrange
        when(() => mockLocation.serviceEnabled()).thenAnswer((_) async => true);
        when(() => mockLocation.hasPermission())
            .thenAnswer((_) async => PermissionStatus.denied);
        when(() => mockLocation.requestPermission())
            .thenAnswer((_) async => PermissionStatus.granted);
        setUpMockGetLocation();
        // act
        await dataSource.getUserLocation();
        // assert
        verify(() => mockLocation.requestPermission());
      },
    );

    test(
      'should requestService() when serviceEnabled() returns false',
      () async {
        // arrange
        when(() => mockLocation.serviceEnabled())
            .thenAnswer((_) async => false);
        when(() => mockLocation.requestService()).thenAnswer((_) async => true);
        when(() => mockLocation.hasPermission())
            .thenAnswer((_) async => PermissionStatus.granted);
        setUpMockGetLocation();
        // act
        await dataSource.getUserLocation();
        // assert
        verify(() => mockLocation.requestService());
      },
    );
  });
}
