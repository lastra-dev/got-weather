import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:got_weather/features/weather/domain/entities/weather.dart';
import 'package:got_weather/features/weather/domain/repositories/weather_repository.dart';
import 'package:got_weather/features/weather/domain/usecases/get_weather_from_location.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  late GetWeatherFromLocation usecase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    usecase = GetWeatherFromLocation(mockWeatherRepository);
  });

  const tLatitude = 22.230108;
  const tLongitude = -97.856055;

  const tWeather = Weather(
    cityName: 'Tampico',
    temperature: 20,
    icon: '01d',
  );

  test('should get weather from the repository', () async {
    // arrange
    when(() => mockWeatherRepository.getWeatherFromLocation(any(), any()))
        .thenAnswer((_) async => const Right(tWeather));
    // act
    final result = await usecase(const WeatherFromLocationParams(
      latitude: tLatitude,
      longitude: tLongitude,
    ));
    // assert
    expect(result, const Right(tWeather));
    verify(() =>
        mockWeatherRepository.getWeatherFromLocation(tLatitude, tLongitude));
    verifyNoMoreInteractions(mockWeatherRepository);
  });
}
