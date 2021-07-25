import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:got_weather/core/error/failures.dart';
import 'package:got_weather/core/theme/app_themes.dart';
import 'package:got_weather/core/usecases/usecase.dart';
import 'package:got_weather/features/weather/domain/entities/got_weather.dart';
import 'package:got_weather/features/weather/domain/entities/weather.dart';
import 'package:got_weather/features/weather/domain/usecases/get_got_weather.dart';
import 'package:got_weather/features/weather/domain/usecases/get_weather_from_city.dart';
import 'package:got_weather/features/weather/domain/usecases/get_weather_from_last_city.dart';
import 'package:got_weather/features/weather/domain/usecases/get_weather_from_location.dart';
import 'package:got_weather/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockGetWeatherFromCity extends Mock implements GetWeatherFromCity {}

class MockGetWeatherFromLocation extends Mock
    implements GetWeatherFromLocation {}

class MockGetWeatherFromLastCity extends Mock
    implements GetWeatherFromLastCity {}

class MockGetGOTWeather extends Mock implements GetGOTWeather {}

void main() {
  late WeatherBloc bloc;
  late MockGetWeatherFromCity mockGetWeatherFromCity;
  late MockGetWeatherFromLocation mockGetWeatherFromLocation;
  late MockGetWeatherFromLastCity mockGetWeatherFromLastCity;
  late MockGetGOTWeather mockGetGOTWeather;

  const tGOTWeather = GOTWeather(
    appTheme: AppTheme.initial,
    description: 'test',
    cityName: 'test',
    background: 'test',
    minTemp: 0,
    maxTemp: 0,
  );
  const tWeather = Weather(cityName: 'Tampico', icon: '01d', temperature: 20);
  const tCityName = 'Tampico';
  const tEventCity = GetWeatherForCity(tCityName);
  final tEventLocation = GetWeatherForLocation();
  final tEventLastCity = GetWeatherForLastCity();

  setUp(() {
    mockGetWeatherFromCity = MockGetWeatherFromCity();
    mockGetWeatherFromLocation = MockGetWeatherFromLocation();
    mockGetWeatherFromLastCity = MockGetWeatherFromLastCity();
    mockGetGOTWeather = MockGetGOTWeather();

    bloc = WeatherBloc(
      cityWeather: mockGetWeatherFromCity,
      locationWeather: mockGetWeatherFromLocation,
      lastCityWeather: mockGetWeatherFromLastCity,
      gotWeather: mockGetGOTWeather,
    );
  });

  // Necessary setup to use Params with mocktail null safety
  setUpAll(() {
    registerFallbackValue(const WeatherFromCityParams(cityName: 'Tampico'));
    registerFallbackValue(NoParams());
    registerFallbackValue(const GOTWeatherParams(temperature: 3));
  });

  test('initialState should be empty', () {
    // assert
    expect(bloc.state, equals(WeatherInitial()));
  });

  test(
    'retry should add previousEvent to bloc event',
    () async {
      // arrange
      bloc.previousEvent = tEventCity;
      when(() => mockGetWeatherFromCity(any()))
          .thenAnswer((_) async => const Right(tWeather));
      when(() => mockGetGOTWeather(any()))
          .thenAnswer((_) async => const Right(tGOTWeather));
      // assert later
      final expected = [
        Loading(),
        const Loaded(weather: tWeather, gotWeather: tGOTWeather),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.retry();
    },
  );

  group('GetWeatherFromCity', () {
    const tWeather = Weather(cityName: 'Tampico', icon: '01d', temperature: 20);

    test('should get data from the city use case', () async {
      // arrange
      when(() => mockGetWeatherFromCity(any()))
          .thenAnswer((_) async => const Right(tWeather));
      when(() => mockGetGOTWeather(any()))
          .thenAnswer((_) async => const Right(tGOTWeather));
      // act
      bloc.add(tEventCity);
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
      when(() => mockGetGOTWeather(any()))
          .thenAnswer((_) async => const Right(tGOTWeather));
      // assert later
      final expected = [
        Loading(),
        const Loaded(weather: tWeather, gotWeather: tGOTWeather),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(tEventCity);
    });

    test(
        'should emit [Loading, Error] with serverFailureMessage when mockGetWeatherFromCity returns ServerFailure',
        () async {
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
      bloc.add(tEventCity);
    });

    test(
        'should emit [Loading, Error] with cacheFailureMessage when mockGetWeatherFromCity returns CacheFailure',
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
      bloc.add(tEventCity);
    });

    test(
        'should emit [Loading, Error] with networkFailureMessage when mockGetWeatherFromCity returns NetworkFailure',
        () async {
      // arrange
      when(() => mockGetWeatherFromCity(any()))
          .thenAnswer((_) async => Left(NetworkFailure()));
      // assert later
      final expected = [
        Loading(),
        const Error(message: networkFailureMessage),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(tEventCity);
    });

    test(
        'should emit [Loading, Error] with permissionFailureMessage when mockGetWeatherFromCity returns PermissionFailure',
        () async {
      // arrange
      when(() => mockGetWeatherFromCity(any()))
          .thenAnswer((_) async => Left(PermissionFailure()));
      // assert later
      final expected = [
        Loading(),
        const Error(message: permissionFailureMessage),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(tEventCity);
    });

    test(
        'should emit [Loading, Error] with serviceDisabledFailureMessage when mockGetWeatherFromCity returns ServiceDisabledFailure',
        () async {
      // arrange
      when(() => mockGetWeatherFromCity(any()))
          .thenAnswer((_) async => Left(ServiceDisabledFailure()));
      // assert later
      final expected = [
        Loading(),
        const Error(message: serviceDisabledFailureMessage),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(tEventCity);
    });
  });

  group('GetWeatherFromLocation', () {
    test('should get data from the location use case', () async {
      // arrange
      when(() => mockGetWeatherFromLocation(any()))
          .thenAnswer((_) async => const Right(tWeather));
      when(() => mockGetGOTWeather(any()))
          .thenAnswer((_) async => const Right(tGOTWeather));
      // act
      bloc.add(tEventLocation);
      await untilCalled(() => mockGetWeatherFromLocation(any()));
      // assert
      verify(() => mockGetWeatherFromLocation(NoParams()));
    });

    test('should emit [Loading, Loaded] when data is gotten successfuly',
        () async {
      // arrange
      when(() => mockGetWeatherFromLocation(any()))
          .thenAnswer((_) async => const Right(tWeather));
      when(() => mockGetGOTWeather(any()))
          .thenAnswer((_) async => const Right(tGOTWeather));
      // assert later
      final expected = [
        Loading(),
        const Loaded(weather: tWeather, gotWeather: tGOTWeather),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      // act
      bloc.add(tEventLocation);
    });
  });

  group('GetWeatherFromLastCity', () {
    test(
      'should get data from GetWeatherFromLastCity usecase',
      () async {
        // arrange
        when(() => mockGetWeatherFromLastCity(any()))
            .thenAnswer((_) async => const Right(tWeather));
        when(() => mockGetGOTWeather(any()))
            .thenAnswer((_) async => const Right(tGOTWeather));
        // act
        bloc.add(tEventLastCity);
        await untilCalled(() => mockGetWeatherFromLastCity(any()));
        // assert
        verify(() => mockGetWeatherFromLastCity(any()));
      },
    );

    test(
      'should emit [Loading, WeatherInitial] if GetWeatherFromLastCity returns a failure',
      () async {
        // arrange
        when(() => mockGetWeatherFromLastCity(any()))
            .thenAnswer((_) async => Left(CacheFailure()));
        // assert later
        final expected = [
          Loading(),
          WeatherInitial(),
        ];
        expectLater(bloc.stream, emitsInOrder(expected));
        // act
        bloc.add(tEventLastCity);
      },
    );
  });

  group('GetGOTWeather', () {
    test(
      'should get data from getGOTWeather usecase',
      () async {
        // arrange
        when(() => mockGetWeatherFromCity(any()))
            .thenAnswer((_) async => const Right(tWeather));
        when(() => mockGetGOTWeather(any()))
            .thenAnswer((_) async => const Right(tGOTWeather));
        // act
        bloc.add(tEventCity);
        await untilCalled(() => mockGetGOTWeather(any()));
        // assert
        verify(() => mockGetGOTWeather(any()));
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        // arrange
        when(() => mockGetWeatherFromCity(any()))
            .thenAnswer((_) async => const Right(tWeather));
        when(() => mockGetGOTWeather(any()))
            .thenAnswer((_) async => Left(CacheFailure()));
        // assert later
        final expected = [
          Loading(),
          const Error(message: cacheFailureMessage),
        ];
        expectLater(bloc.stream, emitsInOrder(expected));
        // act
        bloc.add(tEventCity);
      },
    );

    test(
      'Events should extend Equatable',
      () async {
        // act
        final result = tEventCity.props;
        // assert
        expect(result, equals([]));
      },
    );
  });
}
