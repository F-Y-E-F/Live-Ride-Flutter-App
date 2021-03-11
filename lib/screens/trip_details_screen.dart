import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import '../screens/map_screen.dart';
import '../widgets/trip_chart.dart';
import '../models/trip.dart';
import '../providers/trips_provider.dart';
import 'package:provider/provider.dart';

class TripDetailsScreen extends StatelessWidget {
  final int index;
  final int id;

  TripDetailsScreen(this.id, this.index);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Trip trip =
        Provider.of<TripsProvider>(context, listen: false).getTripById(id);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: 'map$index',
              child: InteractiveViewer(
                child: Image.network(
                  trip.mapStaticView,
                  width: double.infinity,
                  height: 280,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              trip.name,
              style: theme.textTheme.headline4.copyWith(fontSize: 22),
            ),
            Container(
              width: 200,
              height: 3,
              color: Color(int.parse(trip.color)),
              margin: EdgeInsets.only(top: 5, bottom: 30),
            ),
            Row(
              children: [
                _getTripSquareInfo(
                    theme, 0.5, 1, 1, 0.5, "DURATION", trip.refactoredDuration),
                _getTripSquareInfo(theme, 0.5, 0.5, 1, 1, "AVG. SPEED (KM/H)",
                    trip.averageSpeed.toStringAsFixed(2))
              ],
            ),
            Row(
              children: [
                _getTripSquareInfo(theme, 0.5, 1, 0.5, 0.5, "MAX SPEED (KM/H)",
                    trip.maxSpeed.toStringAsFixed(2)),
                _getTripSquareInfo(theme, 0.5, 0.5, 0.5, 1, "DISTANCE (KM)",
                    (trip.distance / 1000).toStringAsFixed(2))
              ],
            ),
            Row(
              children: [
                _getTripSquareInfo(theme, 0.5, 1, 0.5, 0.5, "ALTITUDE (M)",
                    trip.altitude.toStringAsFixed(1)),
                _getTripSquareInfo(theme, 0.5, 0.5, 0.5, 1, "CALORIES (KCAL)",
                    trip.calories.toString())
              ],
            ),
            Row(
              children: [
                _getTripSquareInfo(
                    theme,
                    1,
                    1,
                    0.5,
                    0.5,
                    "START TIME",
                    DateFormat(DateFormat.HOUR24_MINUTE)
                        .format(trip.startTime)),
                _getTripSquareInfo(theme, 1, 0.5, 0.5, 1, "END TIME",
                    DateFormat(DateFormat.HOUR24_MINUTE).format(trip.endTime))
              ],
            ),
            SizedBox(
              height: 24,
            ),
            TextButton.icon(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MapScreen(
                          title: trip.name,
                          startPosition: trip.coordinatesList.isNotEmpty
                              ? trip.coordinatesList[0]
                              : LatLng(40, 40),
                          endPosition: trip.coordinatesList.isNotEmpty
                              ? trip.coordinatesList[
                                  trip.coordinatesList.length - 1]
                              : LatLng(40, 40),polylines: trip.polylines,
                        ),
                    fullscreenDialog: true)),
                icon: Icon(
                  Icons.location_pin,
                  color: Colors.white,
                ),
                label: Text(
                  'View On Map',
                  style: TextStyle(
                      color: Colors.white, fontSize: 18, fontFamily: 'Nunito'),
                ),
                style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    backgroundColor: theme.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)))),
            SizedBox(
              height: 24,
            ),
            if(trip.intervalSpeeds.isNotEmpty) TripChart(trip.intervalSpeeds),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getTripSquareInfo(ThemeData theme, double bt, double lt, double tp,
          double rg, String title, String text) =>
      Expanded(
          child: Container(
        padding: const EdgeInsets.fromLTRB(12, 16, 12, 12),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Colors.grey[300], width: bt),
                left: BorderSide(color: Colors.grey[300], width: lt),
                top: BorderSide(color: Colors.grey[300], width: tp),
                right: BorderSide(color: Colors.grey[300], width: rg))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              child: Text(
                title,
                style: theme.textTheme.headline3.copyWith(fontSize: 15),
              ),
            ),
            FittedBox(
                child: Text(
              text,
              style: theme.textTheme.headline4,
            )),
          ],
        ),
        height: 100,
      ));
}
