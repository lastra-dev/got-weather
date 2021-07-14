import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:got_weather/core/error/failures.dart';
import 'package:got_weather/core/usecases/usecase.dart';
import 'package:got_weather/features/weather/domain/entities/weather.dart';
import 'package:got_weather/features/weather/domain/usecases/get_weather_from_city.dart';
import 'package:got_weather/features/weather/domain/usecases/get_weather_from_location.dart';
import 'package:got_weather/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockGetWeatherFromCity extends Mock implements GetWeatherFromCity {}

class MockGetWeatherFromLocation extends Mock
    implements GetWeatherFromLocation {}

void main() {
  late WeatherBloc bloc;
  late MockGetWeatherFromCity mockGetWeatherFromCity;
  late MockGetWeatherFromLocation mockGetWeatherFromLocation;

  setUp(() {
    mockGetWeatherFromCity = MockGetWeatherFromCity();
    mockGetWeatherFromLocation = MockGetWeatherFromLocation();

    bloc = WeatherBloc(
      cityWeather: mockGetWeatherFromCity,
      locationWeather: mockGetWeatherFromLocation,
    );
  });

  // Necessary setup to use Params with mocktail null safety
  setUpAll(() {
    registerFallbackValue(const WeatherFromCityParams(cityName: 'Tampico'));
    registerFallbackValue(NoParams());
  });

  test('initialState should be empty', () {
    // assert
    expect(bloc.state, equals(WeatherInitial()));
  });

  group('GetWeatherFromCity', () {
    const tCityName = 'Tampico';
    const tWeather = Weather(cityName: 'Tampico', icon: '01d', temperature: 20);

    test('should get data from the city use case', () async {
      // arrange
      when(() => mockGetWeatherFromCity(any()))
          .thenAnswer((_) async => const Right(tWeather));
      // act
      bloc.add(const GetWeatherForCity(tCityName));
      await untilCalled(() => mockGetWeatherFromCity(any()));
      // assert
      verify(() => mockGetWeatherFromCity(
          const WeatherFromCityParams(cityName: tCityName)));
    });

    test('should emit [Loading, Loaded] when data is gotten successfuly',
        () async {
      // arrange
      when(() => mockGetWeatherFromCity(any()))
          .thenAnswer((_) async => const Right(tWeather));
      // assert later
      final expected = [
        Loading(),
        const Loaded(weather: tWeather),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(const GetWeatherForCity(tCityName));
    });

    test('should emit [Loading, Error] when getting data fails', () async {
      // arrange
      when(() => mockGetWeatherFromCity(any()))
          .thenAnswer((_) async => Left(ServerFailure()));
      // assert later
      final expected = [
        Loading(),
        const Error(message: serverFailureMessage),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(const GetWeatherForCity(tCityName));
    });

    test(
        'should emit [Loading, Error] with a proper message for the error when getting data fails',
        () async {
      // arrange
      when(() => mockGetWeatherFromCity(any()))
          .thenAnswer((_) async => Left(CacheFailure()));
      // assert later
      final expected = [
        Loading(),
        const Error(message: cacheFailureMessage),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(const GetWeatherForCity(tCityName));
    });
  });

  group('GetWeatherFromLocation', () {
    const tWeather = Weather(cityName: 'Tampico', icon: '01d', temperature: 20);

    test('should get data from the location use case', () async {
      // arrange
      when(() => mockGetWeatherFromLocation(any()))
          .thenAnswer((_) async => const Right(tWeather));
      // act
      bloc.add(GetWeatherForLocation());
      await untilCalled(() => mockGetWeatherFromLocation(any()));
      // assert
      verify(() => mockGetWeatherFromLocation(NoParams()));
    });

    test('should emit [Loading, Loaded] when data is gotten successfuly',
        () async {
      // arrange
      when(() => mockGetWeatherFromLocation(any()))
          .thenAnswer((_) async => const Right(tWeather));
      // assert later
      final expected = [
        Loading(),
        const Loaded(weather: tWeather),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(GetWeatherForLocation());
    });

    test('should emit [Loading, Error] when getting data fails', () async {
      // arrange
      when(() => mockGetWeatherFromLocation(any()))
          .thenAnswer((_) async => Left(ServerFailure()));
      // assert later
      final expected = [
        Loading(),
        const Error(message: serverFailureMessage),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(GetWeatherForLocation());
    });

    test(
        'should emit [Loading, Error] with a proper message for the error when getting data fails',
        () async {
      // arrange
      when(() => mockGetWeatherFromLocation(any()))
          .thenAnswer((_) async => Left(CacheFailure()));
      // assert later
      final expected = [
        Loading(),
        const Error(message: cacheFailureMessage),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(GetWeatherForLocation());
    });
  });
}
