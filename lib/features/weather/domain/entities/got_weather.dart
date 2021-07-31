import 'package:equatable/equatable.dart';
import 'package:got_weather/core/theme/app_themes.dart';

class GOTWeather extends Equatable {
  final int minTemp;
  final int maxTemp;
  final String title;
  final String background;
  final String subtitle;
  final AppTheme appTheme;

  const GOTWeather({
    required this.subtitle,
    required this.title,
    required this.background,
    required this.minTemp,
    required this.appTheme,
    required this.maxTemp,
  });

  @override
  List<Object?> get props => [
        title,
        background,
        subtitle,
        minTemp,
        maxTemp,
      ];
}
