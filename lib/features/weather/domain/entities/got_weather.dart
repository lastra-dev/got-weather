import 'package:equatable/equatable.dart';

class GOTWeather extends Equatable {
  final String cityName;
  final int avgTemp;
  final String background;

  const GOTWeather({
    required this.cityName,
    required this.avgTemp,
    required this.background,
  });

  @override
  List<Object?> get props => [cityName, avgTemp, background];
}
