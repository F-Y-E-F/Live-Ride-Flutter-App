import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../helpers/snack_helper.dart';
import 'package:flutter/material.dart';

class LocationHelper {
  static const GOOGLE_MAP_API = 'AIzaSyDCOQm4ya-yQ-CZSey5VY_3QE5i3irHaiQ';

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

  static String getTripImage(List<LatLng> coordinatesList) {
    String path = "path=";
    coordinatesList.forEach((element) => path = path + element.latitude.toString()+","+element.longitude.toString()+"|");
    path = path.substring(0, path.length - 1);
    double centerLt = (coordinatesList[0].latitude + coordinatesList[coordinatesList.length - 1].latitude) / 2;
    double centerLng = (coordinatesList[0].longitude + coordinatesList[coordinatesList.length - 1].longitude) / 2;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$centerLt,$centerLng&zoom=14&size=900x700&maptype=roadmap&markers=color:green%7Clabel:S%7C${coordinatesList[0].latitude},${coordinatesList[0].longitude}&markers=color:red%7Clabel:E%7C${coordinatesList[coordinatesList.length-1].latitude},${coordinatesList[coordinatesList.length-1].longitude}&$path&sensor=false&key=$GOOGLE_MAP_API';
  }


}
