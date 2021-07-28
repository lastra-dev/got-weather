import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:got_weather/features/weather/data/models/weather_model.dart';
import 'package:got_weather/features/weather/domain/entities/weather.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tWeatherModel = WeatherModel(
    temperature: 20,
    cityName: 'Tampico',
    country: 'MX',
    icon: '01d',
  );
  const tWeatherModelNoCountry = WeatherModel(
    temperature: 0,
    cityName: '',
    icon: '04n',
  );

  test('should be a subclass of Weather entity', () {
    // assert
    expect(tWeatherModel, isA<Weather>());
  });

  group('fromJson', () {
    test(
        'should return a valid model when the JSON weather temperature is an integer',
        () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('weather.json')) as Map<String, dynamic>;
      // act
      final result = WeatherModel.fromJson(jsonMap);
      // assert
      expect(result, tWeatherModel);
    });

    test(
        'should return a valid model when the JSON weather temperature is regarded as a double',
        () {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('weather_double.json')) as Map<String, dynamic>;
      // act
      final result = WeatherModel.fromJson(jsonMap);
      // assert
      expect(result, tWeatherModel);
    });

    test(
      'should return a model with country null when is not available',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json
            .decode(fixture('weather_no_country.json')) as Map<String, dynamic>;
        // act
        final result = WeatherModel.fromJson(jsonMap);
        // assert
        expect(result, tWeatherModelNoCountry);
      },
    );
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      // act
      final result = tWeatherModel.toJson();
      // assert
      final expectedJsonMap = {
        'temperature': 20,
        'cityName': 'Tampico',
        'country': 'MX',
        'icon': '01d',
      };
      expect(result, expectedJsonMap);
    });

    test(
      'should return a JSON map with country null when is not available',
      () async {
        // arrange
        final result = tWeatherModelNoCountry.toJson();
        // assert
        final expectedJsonMap = {
          'temperature': 0,
          'cityName': '',
          'country': null,
          'icon': '04n',
        };
        expect(result, expectedJsonMap);
      },
    );
  });
}
