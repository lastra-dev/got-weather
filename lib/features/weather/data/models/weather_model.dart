import 'package:got_weather/features/weather/domain/entities/weather.dart';

class WeatherModel extends Weather {
  const WeatherModel({
    required int temperature,
    required String cityName,
    required String icon,
  }) : super(
          temperature: temperature,
          cityName: cityName,
          icon: icon,
        );

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temperature: (json['list'][0]['main']['temp'] as num).toInt(),
      cityName: json['list'][0]['name'].toString(),
      icon: json['list'][0]['weather'][0]['icon'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temperature': temperature,
      'cityName': cityName,
      'icon': icon,
    };
  }
}
