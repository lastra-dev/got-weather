import '../../domain/entities/weather.dart';

class WeatherModel extends Weather {
  const WeatherModel({
    required int temperature,
    required String cityName,
    String? country,
    required String icon,
  }) : super(
          temperature: temperature,
          cityName: cityName,
          country: country,
          icon: icon,
        );

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temperature: (json['main']['temp'] as num).toInt(),
      cityName: json['name'].toString(),
      country: json['sys']['country'] as String?,
      icon: json['weather'][0]['icon'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temperature': temperature,
      'cityName': cityName,
      'country': country,
      'icon': icon,
    };
  }
}
