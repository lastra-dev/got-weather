import 'package:flutter_test/flutter_test.dart';
import 'package:got_weather/core/error/exception.dart';
import 'package:got_weather/features/weather/data/datasources/got_weather_local_data_source.dart';

void main() {
  late GOTWeatherLocalDataSourceImpl gotWeatherLocalDataSourceImpl;

  setUp(() {
    gotWeatherLocalDataSourceImpl = GOTWeatherLocalDataSourceImpl();
  });

  const tTemperature = 3;

  test(
    'should return the correct GOTWeather for the given temperature',
    () {
      // act
      final result = gotWeatherLocalDataSourceImpl.getGOTWeather(tTemperature);
      // assert
      expect(
        result,
        equals(gotWeatherData[GOTCity.winterfell.index]),
      );
    },
  );

  test(
    'should throw CacheException when there is no matching GOTWeather for the given temperature',
    () async {
      // act
      final call = gotWeatherLocalDataSourceImpl.getGOTWeather;
      // assert
      const outOfRangeNumber = 1000;
      expect(
        () => call(outOfRangeNumber),
        throwsA(isInstanceOf<CacheException>()),
      );
    },
  );
}
