import 'package:geolocator/geolocator.dart';
import 'package:lapakberkah77/repositories/geolocation/base_geolocation_repositories.dart';

class GeolocationRepositories extends BaseGeolocationRepositories{
  GeolocationRepositories();

  @override
  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
}