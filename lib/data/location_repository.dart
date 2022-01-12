import 'package:geolocator/geolocator.dart';

class LocationRepository {
  // final _geolocator = Geolocator();

  Future<Position> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return position;
  }
}
