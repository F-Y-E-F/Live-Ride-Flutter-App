import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import './lat_lng.dart';

class Trip {
  DateTime startTime;
  DateTime endTime;
  double maxSpeed;
  int duration;
  double averageSpeed;
  bool isStart;
  double distance;
  int calories;
  double altitude;
  List<LatLng> coordinatesList;

  Trip(
      {@required this.startTime,
      this.endTime,
      this.maxSpeed,
      this.averageSpeed,
      @required this.isStart,
      this.distance,
      this.calories,
      this.altitude,
      this.coordinatesList,
      this.duration});


  String get refactoredDuration =>
     Duration(seconds: duration).toString().split('.')[0];


  void addDistance(){
    if (this.coordinatesList.length > 1) {
      this.distance += Geolocator.distanceBetween(
          this.coordinatesList[this.coordinatesList.length - 1].latitude,
          this.coordinatesList[this.coordinatesList.length - 1].longitude,
          this.coordinatesList[this.coordinatesList.length - 2].latitude,
          this.coordinatesList[this.coordinatesList.length-2].longitude);
    }
  }

}
