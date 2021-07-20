import 'package:equatable/equatable.dart';
import 'package:got_weather/core/theme/app_themes.dart';

class GOTWeather extends Equatable {
  final int minTemp;
  final int maxTemp;
  final String cityName;
  final String background;
  final String description;
  final AppTheme appTheme;

  const GOTWeather({
    required this.description,
    required this.cityName,
    required this.background,
    required this.minTemp,
    required this.appTheme,
    required this.maxTemp,
  });

  @override
  List<Object?> get props => [
        cityName,
        background,
        description,
        minTemp,
        maxTemp,
      ];
}
