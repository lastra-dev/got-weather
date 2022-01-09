import '../../../../core/theme/app_themes.dart';

import '../../domain/entities/got_weather.dart';

class GOTWeatherModel extends GOTWeather {
  const GOTWeatherModel({
    required int minTemp,
    required int maxTemp,
    required String cityName,
    required String background,
    required String description,
    required AppTheme appTheme,
  }) : super(
          appTheme: appTheme,
          minTemp: minTemp,
          maxTemp: maxTemp,
          title: cityName,
          background: background,
          subtitle: description,
        );
}
