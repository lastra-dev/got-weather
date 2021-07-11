import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:got_weather/core/error/exception.dart';
import 'package:got_weather/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:got_weather/features/weather/data/models/weather_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  late WeatherRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  void setUpMockClientSuccess200(Uri url) {
    when(() => mockHttpClient.get(url)).thenAnswer(
      (_) async => http.Response(
        fixture('weather.json'),
        200,
      ),
    );
  }

  void setUpMockClientFailure404(Uri url) {
    when(() => mockHttpClient.get(url)).thenAnswer(
      (_) async => http.Response(
        'Something went wrong',
        404,
      ),
    );
  }

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = WeatherRemoteDataSourceImpl(
      client: mockHttpClient,
    );
  });

  final appid = dotenv.env[weatherApi];

  group('getWeatherFromCity', () {
    const tCityName = 'Tampico';
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$tCityName&appid=$appid&units=metric');

    test('should perform a GET request on a URL with the cityName endpoint',
        () async {
      // arrange
      setUpMockClientSuccess200(url);
      // act
      await dataSource.getWeatherFromCity(tCityName);
      // asset
      verify(() => mockHttpClient.get(url));
    });

    final tWeatherModel = WeatherModel.fromJson(
        json.decode(fixture('weather.json')) as Map<String, dynamic>);

    test('should return Weather when the response code is 200 (success)',
        () async {
      //arrange
      setUpMockClientSuccess200(url);
      // act
      final result = await dataSource.getWeatherFromCity(tCityName);
      // assert
      expect(result, equals(tWeatherModel));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      setUpMockClientFailure404(url);
      // act
      final call = dataSource.getWeatherFromCity;
      // assert
      expect(() => call(tCityName), throwsA(isInstanceOf<ServerException>()));
    });
  });

  group('getWeatherFromLocation', () {
    const double tLatitude = 22;
    const double tLongitude = -97;
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$tLatitude&lon=$tLongitude&appid=$appid&units=metric');

    test('should perform a GET request on a URL with the cityName endpoint',
        () async {
      // arrange
      setUpMockClientSuccess200(url);
      // act
      await dataSource.getWeatherFromLocation(tLatitude, tLongitude);
      // assert
      verify(() => mockHttpClient.get(url));
    });

    final tWeatherModel = WeatherModel.fromJson(
        json.decode(fixture('weather.json')) as Map<String, dynamic>);

    test('should return Weather when the response code is 200 (success)',
        () async {
      //arrange
      setUpMockClientSuccess200(url);
      // act
      final result =
          await dataSource.getWeatherFromLocation(tLatitude, tLongitude);
      // assert
      expect(result, equals(tWeatherModel));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      setUpMockClientFailure404(url);
      // act
      final call = dataSource.getWeatherFromLocation;
      // assert
      expect(() => call(tLatitude, tLongitude),
          throwsA(isInstanceOf<ServerException>()));
    });
  });
}
