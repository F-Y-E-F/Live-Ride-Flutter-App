import 'package:geolocator/geolocator.dart';
import '../helpers/snack_helper.dart';
import 'package:flutter/material.dart';

class LocationHelper {
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
}
