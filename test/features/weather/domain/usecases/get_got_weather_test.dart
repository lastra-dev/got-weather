import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:got_weather/core/theme/app_themes.dart';
import 'package:got_weather/features/weather/domain/entities/got_weather.dart';
import 'package:got_weather/features/weather/domain/repositories/got_weather_repository.dart';
import 'package:got_weather/features/weather/domain/usecases/get_got_weather.dart';
import 'package:mocktail/mocktail.dart';

class MockGOTWeatherRepository extends Mock implements GOTWeatherRepository {}

void main() {
  late GetGOTWeather usecase;
  late MockGOTWeatherRepository mockGOTWeatherRepository;

  const tTemperature = 3;
  const tGOTWeather = GOTWeather(
    appTheme: AppTheme.winterfell,
    subtitle: 'a description',
    title: 'Winterfell',
    minTemp: -4,
    maxTemp: 5,
    background: 'background',
  );

  setUp(() {
    mockGOTWeatherRepository = MockGOTWeatherRepository();
    usecase = GetGOTWeather(mockGOTWeatherRepository);
  });

  test(
    'should get GOTWeather from the repository',
    () async {
      // arrange
      when(() => mockGOTWeatherRepository.getGOTWeather(any()))
          .thenAnswer((_) async => const Right(tGOTWeather));
      // act
      final result =
          await usecase(const GOTWeatherParams(temperature: tTemperature));
      // assert
      verify(() => mockGOTWeatherRepository.getGOTWeather(tTemperature));
      verifyNoMoreInteractions(mockGOTWeatherRepository);
      expect(result, const Right(tGOTWeather));
    },
  );

  test(
    'GOTWeatherParams should have repository parameters',
    () {
      // act
      final result = const GOTWeatherParams(temperature: tTemperature).props;
      // assert
      expect(result, [tTemperature]);
    },
  );

  test(
    'GOTWeather should extend Equatable',
    () {
      // assert
      expect(tGOTWeather.props, equals([...tGOTWeather.props]));
    },
  );
}
