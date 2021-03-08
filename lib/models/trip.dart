import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:live_ride/helpers/location_helper.dart';

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
      @required this.color,
      this.id});

  String get refactoredDuration =>
      Duration(seconds: duration).toString().split('.')[0];

  String get mapStaticView {
    if (coordinatesList.length > 0)
      return LocationHelper.getTripImage(coordinatesList);
    else
      return 'https://i.imgur.com/OZyMbHc.png';
  }

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

  Set<Polyline> get polylines {
    Set<Polyline> set = {};
    if (this.coordinatesList.isNotEmpty) {
      for (int i = 1; i < coordinatesList.length; i++) {
        set.add(Polyline(
            polylineId: PolylineId(Random().nextInt(10000).toString()),
            color: const Color(0xff3061D7),
            points: [
              coordinatesList[i],
              coordinatesList[i - 1],
            ],
            width: 3));
      }
      return set;
    } else
      return null;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'color': color,
      'startTime': startTime.toString(),
      'endTime': endTime.toString(),
      'maxSpeed': maxSpeed,
      'duration': duration,
      'averageSpeed': averageSpeed,
      'distance': distance,
      'calories': calories,
      'altitude': altitude,
      'coordinatesList': json.encode(coordinatesList)
    };
  }

  static Trip fromMap(Map<String, dynamic> map) {
    return Trip(
        startTime: DateTime.parse(map['startTime']),
        endTime: DateTime.parse(map['endTime']),
        isStart: false,
        altitude: map['altitude'],
        averageSpeed: map['averageSpeed'],
        calories: map['calories'],
        distance: map['distance'],
        maxSpeed: map['maxSpeed'],
        coordinatesList: _getCoordinatesList(map),
        duration: map['duration'],
        color: map['color'],
        name: map['name'],
        id: map['id']);
  }

  static List<LatLng> _getCoordinatesList(Map<String, dynamic> map) {
    List<dynamic> listOfCoordinates =
        (jsonDecode(map['coordinatesList']) as List<dynamic>);
    if (listOfCoordinates.length <= 0) {
      return [];
    } else {
      return listOfCoordinates.map((e) => LatLng(e[0], e[1])).toList();
    }
  }
}
