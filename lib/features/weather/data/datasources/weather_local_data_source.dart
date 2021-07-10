abstract class WeatherLocalDataSource {
  Future<String> getLastCityName();
  Future<void> cacheCityName(String cityName);
}
