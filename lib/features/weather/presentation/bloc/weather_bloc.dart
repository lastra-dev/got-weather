import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:got_weather/core/error/failures.dart';
import 'package:got_weather/features/weather/domain/entities/weather.dart';
import 'package:got_weather/features/weather/domain/usecases/get_weather_from_city.dart';
import 'package:got_weather/features/weather/domain/usecases/get_weather_from_location.dart';

part 'weather_event.dart';
part 'weather_state.dart';

const serverFailureMessage = 'Server Failure';
const cacheFailureMessage = 'Cache Failure';
const networkFailureMessage = 'Network Failure';
const permissionFailureMessage = 'Location permission denied';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherFromCity getWeatherFromCity;
  final GetWeatherFromLocation getWeatherFromLocation;

  WeatherBloc({
    required GetWeatherFromCity cityWeather,
    required GetWeatherFromLocation locationWeather,
  })  : getWeatherFromCity = cityWeather,
        getWeatherFromLocation = locationWeather,
        super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is GetWeatherForCity) {
      yield Loading();
      final failureOrWeather = await getWeatherFromCity(
          WeatherFromCityParams(cityName: event.cityName));
      yield* _eitherLoadedOrErrorState(failureOrWeather);
    }

    if (event is GetWeatherForLocation) {
      yield Loading();
      final failureOrWeather = await getWeatherFromLocation(
          WeatherFromLocationParams(
              latitude: event.latitude, longitude: event.longitude));
      yield* _eitherLoadedOrErrorState(failureOrWeather);
    }
  }

  Stream<WeatherState> _eitherLoadedOrErrorState(
      Either<Failure, Weather> failureOrWeather) async* {
    yield failureOrWeather.fold(
      (failure) => Error(
        message: _mapFailureToMessage(failure),
      ),
      (weather) => Loaded(weather: weather),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      case NetworkFailure:
        return networkFailureMessage;
      case PermissionFailure:
        return permissionFailureMessage;
      default:
        return 'Unexpected Error';
    }
  }
}
