import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:got_weather/core/network/network_info.dart';
import 'package:got_weather/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:got_weather/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:got_weather/features/weather/domain/repositories/weather_repository.dart';
import 'package:got_weather/features/weather/domain/usecases/get_weather_from_city.dart';
import 'package:got_weather/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'features/weather/data/datasources/weather_local_data_source.dart';
import 'features/weather/domain/usecases/get_weather_from_location.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Weather
  // Bloc
  sl.registerFactory(() => WeatherBloc(
        cityWeather: sl(),
        locationWeather: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => GetWeatherFromCity(sl()));
  sl.registerLazySingleton(() => GetWeatherFromLocation(sl()));

  // Repository
  sl.registerLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));

  // Data sources
  sl.registerLazySingleton<WeatherRemoteDataSource>(
      () => WeatherRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<WeatherLocalDataSource>(
      () => WeatherLocalDataSourceImpl(sharedPreferences: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
