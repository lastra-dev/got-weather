part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class Loading extends WeatherState {}

class Loaded extends WeatherState {
  final Weather weather;

  const Loaded({required this.weather});
}

class Error extends WeatherState {
  final String message;

  const Error({required this.message});
}
