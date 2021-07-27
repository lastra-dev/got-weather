import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:got_weather/core/usecases/usecase.dart';
import 'package:got_weather/features/weather/domain/entities/weather.dart';
import 'package:got_weather/features/weather/domain/repositories/weather_repository.dart';
import 'package:got_weather/features/weather/domain/usecases/get_weather_from_last_city.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  late GetWeatherFromLastCity usecase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    usecase = GetWeatherFromLastCity(mockWeatherRepository);
  });

  const tWeather = Weather(
    cityName: 'Tampico',
    temperature: 20,
    icon: '01d',
  );

  test('should get weather from the repository', () async {
    // arrange
    when(() => mockWeatherRepository.getWeatherFromLastLocation())
        .thenAnswer((_) async => const Right(tWeather));
    // act
    final result = await usecase(NoParams());
    // assert
    expect(result, const Right(tWeather));
    verify(() => mockWeatherRepository.getWeatherFromLastLocation());
    verifyNoMoreInteractions(mockWeatherRepository);
  });
}
