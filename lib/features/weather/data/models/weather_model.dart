import '../../domain/entities/weather.dart';

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
      temperature: (json['main']['temp'] as num).toInt(),
      cityName: json['name'].toString(),
      icon: json['weather'][0]['icon'].toString(),
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
