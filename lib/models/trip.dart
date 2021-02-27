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

  void calculateAverageSpeed(double speed){
      var totalSpeed = this.averageSpeed * (this.coordinatesList.length-1);
      this.averageSpeed = (totalSpeed + speed) / this.coordinatesList.length;
  }

  void calculateCalories(){
    this.calories = 60*(this.duration/60)*(0.6345*this.averageSpeed*this.averageSpeed+0.7563*this.averageSpeed+36.725)~/(3600); /// -> te 60 to masa ciała :]
  }

}
