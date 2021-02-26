import 'package:flutter/foundation.dart';

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
  int nbOfAverageSpeeds;

  Trip(
      {@required this.startTime,
      this.endTime,
      this.maxSpeed,
      this.averageSpeed,
      @required this.isStart,
      this.distance,
      this.calories,
      this.altitude,
      this.nbOfAverageSpeeds,
      this.duration});


  String get refactoredDuration =>
     Duration(seconds: duration).toString().split('.')[0];


}
