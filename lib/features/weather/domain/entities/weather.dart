import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final int temperature;
  final String cityName;
  final String icon;

  const Weather({
    required this.temperature,
    required this.cityName,
    required this.icon,
  });

  @override
  List<Object?> get props => [temperature, cityName, icon];
}
