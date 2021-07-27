import '../../domain/entities/location_entity.dart';

class LocationModel extends LocationEntity {
  const LocationModel({
    required double lat,
    required double lon,
  }) : super(
          lat: lat,
          lon: lon,
        );

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      lat: double.parse(json['lat'].toString()),
      lon: double.parse(json['lon'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lon': lon,
    };
  }
}
