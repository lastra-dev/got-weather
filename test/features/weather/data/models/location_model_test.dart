import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:got_weather/features/weather/data/models/location_model.dart';
import 'package:got_weather/features/weather/domain/entities/location_entity.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tLocationModel = LocationModel(lat: 22, lon: -97);

  test('should be a subclass of LocationEntity', () {
    // assert
    expect(tLocationModel, isA<LocationEntity>());
  });

  test('fromJson should return a valid model', () async {
    // arrange
    final Map<String, dynamic> jsonMap =
        json.decode(fixture('location_cached.json')) as Map<String, dynamic>;
    // act
    final result = LocationModel.fromJson(jsonMap);
    // assert
    expect(result, tLocationModel);
  });

  test('toJson should return a valid JSON map', () async {
    // act
    final result = tLocationModel.toJson();
    // assert
    final expectedJsonMap = {
      'lat': 22,
      'lon': -97,
    };

    expect(result, expectedJsonMap);
  });
}
