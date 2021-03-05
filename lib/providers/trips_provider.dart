import 'package:flutter/foundation.dart';
import 'package:live_ride/helpers/db_helper.dart';
import '../models/trip.dart';

class TripsProvider with ChangeNotifier {
  List<Trip> _trips = [];

  List<Trip> get trips => [..._trips];


  Future<void> insertTrip(Trip trip) async{
      await DBHelper.insertTrip('trips', trip.toMap());
      print("XD");
  }

  Future<void> getAllTrips() async{
    final allTrips = await DBHelper.getAllTrips('trips');
    _trips = allTrips.map((trip) => Trip.fromMap(trip)).toList();
    notifyListeners();
  }


}
