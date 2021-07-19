import '../../domain/entities/got_weather.dart';

class GOTWeatherModel extends GOTWeather {
  const GOTWeatherModel({
    required int minTemp,
    required int maxTemp,
    required String cityName,
    required String background,
    required String description,
    required int primaryColor,
  }) : super(
          primaryColor: primaryColor,
          minTemp: minTemp,
          maxTemp: maxTemp,
          cityName: cityName,
          background: background,
          description: description,
        );
}
