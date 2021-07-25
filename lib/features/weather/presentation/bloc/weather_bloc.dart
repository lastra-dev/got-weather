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
import 'package:got_weather/features/weather/domain/usecases/get_weather_from_last_city.dart';
import 'package:got_weather/features/weather/domain/usecases/get_weather_from_location.dart';

part 'weather_event.dart';
part 'weather_state.dart';

const serverFailureMessage = 'City not found!';
const cacheFailureMessage = 'Cache Failure';
const networkFailureMessage = 'Internet connection not found!';
const permissionFailureMessage =
    'Location permission denied, please change location permissions!';
const serviceDisabledFailureMessage =
    'Location service disabled, please enable location service!';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherFromCity getWeatherFromCity;
  final GetWeatherFromLocation getWeatherFromLocation;
  final GetWeatherFromLastCity getWeatherFromLastCity;
  final GetGOTWeather getGOTWeather;
  WeatherEvent? previousEvent;

  WeatherBloc({
    required GetGOTWeather gotWeather,
    required GetWeatherFromCity cityWeather,
    required GetWeatherFromLastCity lastCityWeather,
    required GetWeatherFromLocation locationWeather,
  })  : getWeatherFromCity = cityWeather,
        getWeatherFromLocation = locationWeather,
        getWeatherFromLastCity = lastCityWeather,
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
    } else if (event is GetWeatherForLastCity) {
      yield Loading();
      final failureOrWeather = await getWeatherFromLastCity(NoParams());
      yield* failureOrWeather.fold((failure) async* {
        yield WeatherInitial();
      }, (_) async* {
        yield* _getLoadedOrErrorState(failureOrWeather);
      });
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

  @override
  void onEvent(WeatherEvent event) {
    previousEvent = event;
    super.onEvent(event);
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
      case ServiceDisabledFailure:
        return serviceDisabledFailureMessage;
      default:
        return 'Unexpected Error';
    }
  }

  Future<void> retry() async {
    if (previousEvent != null) {
      add(previousEvent!);
    }
  }
}
