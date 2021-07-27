import 'dart:convert';

import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exception.dart';
import '../models/location_model.dart';

abstract class WeatherLocalDataSource {
  Future<LocationModel> getLastLocation();
  Future<void> cacheLocation(LocationModel locData);
  Future<LocationModel> getUserLocation();
}

const cachedLocation = 'CACHED_LOCATION';

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  final SharedPreferences sharedPreferences;
  final Location location;

  WeatherLocalDataSourceImpl({
    required this.sharedPreferences,
    required this.location,
  });

  @override
  Future<void> cacheLocation(LocationModel locData) {
    final jsonString = locData.toJson();
    return sharedPreferences.setString(cachedLocation, json.encode(jsonString));
  }

  @override
  Future<LocationModel> getLastLocation() {
    final jsonString = sharedPreferences.getString(cachedLocation);
    if (jsonString != null) {
      final location = LocationModel.fromJson(
          json.decode(jsonString) as Map<String, dynamic>);
      return Future.value(location);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<LocationModel> getUserLocation() async {
    final location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        throw ServiceDisabledException();
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        throw PermissionException();
      }
    }

    final locData = await location.getLocation();
    return LocationModel(
      lat: locData.latitude!,
      lon: locData.longitude!,
    );
  }
}
