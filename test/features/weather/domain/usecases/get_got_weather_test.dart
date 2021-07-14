import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:got_weather/features/weather/domain/entities/got_weather.dart';
import 'package:got_weather/features/weather/domain/entities/weather.dart';
import 'package:got_weather/features/weather/domain/repositories/got_weather_repository.dart';
import 'package:got_weather/features/weather/domain/usecases/get_got_weather.dart';
import 'package:mocktail/mocktail.dart';

class MockGOTWeatherRepository extends Mock implements GOTWeatherRepository {}

void main() {
  late GetGOTWeather usecase;
  late MockGOTWeatherRepository mockGOTWeatherRepository;

  const tWeather = Weather(
    cityName: 'Tampico',
    icon: '01d',
    temperature: 20,
  );

  const tGOTWeather = GOTWeather(
    description: 'a description',
    cityName: 'Winterfell',
    avgTemp: -5,
    background: 'background',
  );

  setUp(() {
    mockGOTWeatherRepository = MockGOTWeatherRepository();
    usecase = GetGOTWeather(mockGOTWeatherRepository);
  });

  setUpAll(() {
    registerFallbackValue(tWeather);
  });

  test(
    'should get GOTWeather from the repository',
    () async {
      // arrange
      when(() => mockGOTWeatherRepository.getGOTWeather(any()))
          .thenAnswer((_) => const Right(tGOTWeather));
      // act
      final result = await usecase(const GOTWeatherParams(weather: tWeather));
      // assert
      expect(result, const Right(tGOTWeather));
      verify(() => mockGOTWeatherRepository.getGOTWeather(tWeather));
      verifyNoMoreInteractions(mockGOTWeatherRepository);
    },
  );
}
