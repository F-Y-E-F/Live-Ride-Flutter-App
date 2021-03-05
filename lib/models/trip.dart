import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Trip {
  int id;
  String name;
  String color;
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
      this.duration,
      @required this.name,
      @required this.color});

  String get refactoredDuration =>
      Duration(seconds: duration).toString().split('.')[0];

  void addDistance() {
    if (this.coordinatesList.length > 1) {
      this.distance += Geolocator.distanceBetween(
          this.coordinatesList[this.coordinatesList.length - 1].latitude,
          this.coordinatesList[this.coordinatesList.length - 1].longitude,
          this.coordinatesList[this.coordinatesList.length - 2].latitude,
          this.coordinatesList[this.coordinatesList.length - 2].longitude);
    }
  }

  void calculateAverageSpeed(double speed) {
    var totalSpeed = this.averageSpeed * (this.coordinatesList.length - 1);
    this.averageSpeed = (totalSpeed + speed) / this.coordinatesList.length;
  }

  void calculateCalories() {
    this.calories = 60 *
        (this.duration / 60) *
        (0.6345 * this.averageSpeed * this.averageSpeed +
            0.7563 * this.averageSpeed +
            36.725) ~/
        (3600);

    /// -> te 60 to masa ciała :]
  }

  void calculateAverageAltitude(double altitude) {
    var totalAltitude = this.altitude * (this.coordinatesList.length - 1);
    this.altitude = (totalAltitude + altitude) / this.coordinatesList.length;
  }

  Set<Polygon> get polylines {
    if (this.coordinatesList.isNotEmpty)
      return Set<Polygon>.of(<Polygon>[
        Polygon(
            polygonId: PolygonId('area'),
            points: this.coordinatesList,
            geodesic: true,
            strokeColor: new Color(0xff3061D7),
            strokeWidth: 5,
            fillColor: new Color(0xff3061D7),
            visible: true),
      ]);
    else
      return null;
  }


  Map<String,dynamic> toMap(){
    return {
      'id': id,
      'name': name,
      'color': color,
      'startTime': startTime.toString(),
      'endTime': endTime.toString(),
      'maxSpeed': maxSpeed,
      'duration': duration,
      'averageSpeed': averageSpeed,
      'distance' : distance,
      'calories': calories,
      'altitude': altitude,
      'coordinatesList': json.encode(coordinatesList)
    };
  }


  static Trip fromMap(Map<String,dynamic> map){
    return Trip(
        startTime: DateTime.now(),
        isStart: false,
        altitude: 0.0,
        averageSpeed: 0.0,
        calories: 0,
        distance: 0.0,
        maxSpeed: 0.0,
        coordinatesList: [],
        duration: 0,
        color: '0xffff0000',
        name: 'Nice trip');
  }
}
