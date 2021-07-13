import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:got_weather/core/error/exception.dart';
import 'package:got_weather/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:got_weather/features/weather/data/models/weather_model.dart';
import 'package:location/location.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockLocation extends Mock implements Location {}

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  late WeatherRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;
  late MockLocation mockLocation;

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

  void setUpMockGetLocation() {
    const double tLatitude = 22;
    const double tLongitude = -97;
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
    mockHttpClient = MockHttpClient();
    mockLocation = MockLocation();
    Location.instance = mockLocation;
    final Location mockLocationInstance = Location();
    dataSource = WeatherRemoteDataSourceImpl(
      client: mockHttpClient,
      location: mockLocationInstance,
    );
  });

  final appid = dotenv.env[weatherApi];

  const double tLatitude = 22;
  const double tLongitude = -97;

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
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$tLatitude&lon=$tLongitude&appid=$appid&units=metric');

    test('should call getLocation when getUserLocation is called', () async {
      // arrange
      setUpMockGrantLocationPermissions();
      setUpMockGetLocation();
      setUpMockClientSuccess200(url);
      // act
      await dataSource.getUserLocation();
      // assert
      verify(() => mockLocation.getLocation());
    });

    test('should throw PermissionException when location permission is denied',
        () async {
      // arrange
      when(() => mockLocation.serviceEnabled()).thenAnswer((_) async => true);
      when(() => mockLocation.hasPermission())
          .thenAnswer((_) async => PermissionStatus.denied);
      when(() => mockLocation.requestPermission())
          .thenAnswer((_) async => PermissionStatus.denied);
      // act
      final call = dataSource.getWeatherFromLocation;
      // assert
      expect(() => call(tLatitude, tLongitude),
          throwsA(isInstanceOf<PermissionException>()));
    });

    test(
        'should throw ServiceDisabledException when location service is disabled',
        () {
      // arrange
      when(() => mockLocation.serviceEnabled()).thenAnswer((_) async => false);
      when(() => mockLocation.requestService()).thenAnswer((_) async => false);
      // act
      final call = dataSource.getWeatherFromLocation;
      // assert
      expect(() => call(tLatitude, tLongitude),
          throwsA(isInstanceOf<ServiceDisabledException>()));
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

    test(
        'should perform a GET request on a URL with latitude and longitude endpoints',
        () async {
      // arrange
      setUpMockGrantLocationPermissions();
      setUpMockGetLocation();
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
      setUpMockGrantLocationPermissions();
      setUpMockGetLocation();
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
      setUpMockGrantLocationPermissions();
      setUpMockGetLocation();
      setUpMockClientFailure404(url);
      // act
      final call = dataSource.getWeatherFromLocation;
      // assert
      expect(() => call(tLatitude, tLongitude),
          throwsA(isInstanceOf<ServerException>()));
    });
  });
}
