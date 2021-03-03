import 'package:geolocator/geolocator.dart';
import '../helpers/snack_helper.dart';
import 'package:flutter/material.dart';

class LocationHelper {
  static const GOOGLE_MAP_API = 'AIzaSyAItiMAoZ9HKXS-nhWbCo9oYgLaFKCFmB8';

  static Stream<Position> getCurrentLocation() {
    return Geolocator.getPositionStream();
  }

  static Future<void> checkPermissions(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return SnackHelper.showContentSnack(
          'You must enable location services !', context);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return SnackHelper.showContentSnack(
          'Location permissions are permantly denied, we cannot request permissions.',
          context);
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return SnackHelper.showContentSnack(
            'Location permissions are denied (actual value: $permission).',
            context);
      }
    }
  }

  static String getTripImage() {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=Brooklyn+Bridge,New+York,NY&zoom=13&size=600x300&maptype=roadmap &markers=color:blue%7Clabel:S%7C40.702147,-74.015794&markers=color:green%7Clabel:G%7C40.711614,-74.012318 &markers=color:red%7Clabel:C%7C40.718217,-73.998284&key=$GOOGLE_MAP_API';
  }
}
