import 'package:equatable/equatable.dart';

class GOTWeather extends Equatable {
  final int avgTemp;
  final String cityName;
  final String background;
  final String description;

  const GOTWeather({
    required this.description,
    required this.cityName,
    required this.avgTemp,
    required this.background,
  });

  @override
  List<Object?> get props => [
        cityName,
        avgTemp,
        background,
        description,
      ];
}
