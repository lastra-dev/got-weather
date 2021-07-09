import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:got_weather/features/weather/domain/entities/weather.dart';
import 'package:got_weather/features/weather/domain/repositories/weather_repository.dart';
import 'package:got_weather/features/weather/domain/usecases/get_weather_from_city.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  late GetWeatherFromCity usecase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    usecase = GetWeatherFromCity(mockWeatherRepository);
  });

  const tCityName = 'Tampico';
  const tWeather = Weather(
    temperature: 20,
    cityName: 'Tampico',
    icon: '01d',
  );

  test('should get weather for the city from the repository', () async {
    // arrange
    when(() => mockWeatherRepository.getWeatherFromCity(any()))
        .thenAnswer((_) async => const Right(tWeather));
    // act
    final result = await usecase(cityName: tCityName);
    // assert
    expect(result, const Right(tWeather));
    verify(() => mockWeatherRepository.getWeatherFromCity(tCityName));
    verifyNoMoreInteractions(mockWeatherRepository);
  });
}
