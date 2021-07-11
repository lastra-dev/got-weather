part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class GetWeatherForCity extends WeatherEvent {
  final String cityName;

  const GetWeatherForCity(this.cityName);
}

class GetWeatherForLocation extends WeatherEvent {
  final double latitude;
  final double longitude;

  const GetWeatherForLocation(this.latitude, this.longitude);
}
