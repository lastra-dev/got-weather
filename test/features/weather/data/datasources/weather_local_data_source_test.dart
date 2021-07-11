import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:got_weather/core/error/exception.dart';
import 'package:got_weather/features/weather/data/datasources/weather_local_data_source.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late WeatherLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource =
        WeatherLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getLastCityName', () {
    const tCityName = 'Tampico';
    test(
        'should return cityName from SharedPreferences when there is one in cache',
        () async {
      // arrange
      when(() => mockSharedPreferences.getString(any()))
          .thenReturn(fixture('cityName_cached.json'));

      // act
      final result = await dataSource.getLastCityName();
      // assert
      verify(() => mockSharedPreferences.getString(cachedCityName));
      expect(result, equals(tCityName));
    });

    test('should throw a CacheException when there is not a cached value', () {
      // arrange
      when(() => mockSharedPreferences.getString(any())).thenReturn(null);

      // act
      final call = dataSource.getLastCityName;

      // assert
      expect(() => call(), throwsA(isInstanceOf<CacheException>()));
    });
  });

  group('cacheCityName', () {
    const tCityName = 'Tampico';

    test('should call SharedPreferences to cache the data', () {
      // arrange
      when(() => mockSharedPreferences.setString(cachedCityName, any()))
          .thenAnswer((_) async => true);
      // act
      dataSource.cacheCityName(tCityName);
      // assert
      final jsonString = {"cityName": tCityName};
      final expectedJsonString = json.encode(jsonString);
      verify(
        () => mockSharedPreferences.setString(
          cachedCityName,
          expectedJsonString,
        ),
      );
    });
  });
}
