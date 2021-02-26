import 'package:geolocator/geolocator.dart';

class LocationHelper {
  static Stream<Position> getCurrentLocation() {
    return Geolocator.getPositionStream();
  }
}
