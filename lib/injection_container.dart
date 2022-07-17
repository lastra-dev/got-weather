import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/weather/data/datasources/got_weather_local_data_source.dart';
import 'features/weather/data/datasources/weather_local_data_source.dart';
import 'features/weather/data/datasources/weather_remote_data_source.dart';
import 'features/weather/data/repositories/got_weather_repository_impl.dart';
import 'features/weather/data/repositories/weather_repository_impl.dart';
import 'features/weather/domain/repositories/got_weather_repository.dart';
import 'features/weather/domain/repositories/weather_repository.dart';
import 'features/weather/domain/usecases/get_got_weather.dart';
import 'features/weather/domain/usecases/get_weather_from_city.dart';
import 'features/weather/domain/usecases/get_weather_from_last_city.dart';
import 'features/weather/domain/usecases/get_weather_from_location.dart';
import 'features/weather/presentation/bloc/weather_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Weather
  // Bloc
  sl.registerFactory(() => WeatherBloc(
        cityWeather: sl(),
        locationWeather: sl(),
        lastCityWeather: sl(),
        gotWeather: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => GetWeatherFromCity(sl()));
  sl.registerLazySingleton(() => GetWeatherFromLocation(sl()));
  sl.registerLazySingleton(() => GetWeatherFromLastCity(sl()));
  sl.registerLazySingleton(() => GetGOTWeather(sl()));

  // Repository
  sl.registerLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<GOTWeatherRepository>(
    () => GOTWeatherRepositoryImpl(
      localDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<WeatherRemoteDataSource>(
      () => WeatherRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<WeatherLocalDataSource>(
      () => WeatherLocalDataSourceImpl(
            sharedPreferences: sl(),
            location: sl(),
          ));
  sl.registerLazySingleton<GOTWeatherLocalDataSource>(
      () => GOTWeatherLocalDataSourceImpl());

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton(() => Location());
}
