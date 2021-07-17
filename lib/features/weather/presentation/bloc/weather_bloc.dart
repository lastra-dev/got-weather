import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:got_weather/core/error/failures.dart';
import 'package:got_weather/core/usecases/usecase.dart';
import 'package:got_weather/features/weather/domain/entities/got_weather.dart';
import 'package:got_weather/features/weather/domain/entities/weather.dart';
import 'package:got_weather/features/weather/domain/usecases/get_got_weather.dart';
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
  final GetGOTWeather getGOTWeather;

  WeatherBloc({
    required GetGOTWeather gotWeather,
    required GetWeatherFromCity cityWeather,
    required GetWeatherFromLocation locationWeather,
  })  : getWeatherFromCity = cityWeather,
        getWeatherFromLocation = locationWeather,
        getGOTWeather = gotWeather,
        super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is GetWeatherForCity) {
      yield Loading();
      final failureOrWeather = await getWeatherFromCity(
          WeatherFromCityParams(cityName: event.cityName));
      yield* _getLoadedOrErrorState(failureOrWeather);
    } else if (event is GetWeatherForLocation) {
      yield Loading();
      final failureOrWeather = await getWeatherFromLocation(NoParams());
      yield* _getLoadedOrErrorState(failureOrWeather);
    }
  }

  Stream<WeatherState> _getLoadedOrErrorState(
      Either<Failure, Weather> failureOrWeather) async* {
    yield* failureOrWeather.fold(
      (failure) async* {
        yield Error(
          message: _mapFailureToMessage(failure),
        );
      },
      (weather) async* {
        final failureOrGOTWeather = await getGOTWeather(
            GOTWeatherParams(temperature: weather.temperature));
        yield failureOrGOTWeather.fold(
          (failure) => Error(message: _mapFailureToMessage(failure)),
          (gotWeather) => Loaded(
            weather: weather,
            gotWeather: gotWeather,
          ),
        );
      },
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
