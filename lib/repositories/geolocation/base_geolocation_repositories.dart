import 'package:geolocator/geolocator.dart';

abstract class BaseGeolocationRepositories{
  // ignore: body_might_complete_normally_nullable
  Future<Position?> getCurrentLocation()async{}
}