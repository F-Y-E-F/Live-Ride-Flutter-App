import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../helpers/fade_route.dart';
import '../models/trip.dart';
import '../providers/trips_provider.dart';
import '../screens/trip_details_screen.dart';
import 'package:provider/provider.dart';

class TripCard extends StatelessWidget {
  final int index;
  final int id;

  TripCard(this.id,this.index);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Trip trip = Provider.of<TripsProvider>(context,listen: false).getTripById(id);
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .push(FadeRoute(builder: (context) => TripDetailsScreen(index))),
      child: Card(
        elevation: 0.8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Hero(
                    tag: 'map$index',
                    child: Image.network(
                      'https://i.imgur.com/BDxieQD.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 10, bottom: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Color(int.parse(trip.color))),
                        width: 12,
                        height: 12,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        trip.name,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            fontFamily: 'Nunito'),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Row(
                              children: [
                                Icon(Icons.directions, size: 23),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "${(trip.distance/1000).toStringAsFixed(1)}km",
                                  style: theme.textTheme.headline3,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Row(
                              children: [
                                Icon(Icons.timer, size: 23),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  trip.refactoredDuration,
                                  style: theme.textTheme.headline3,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Row(
                              children: [
                                Icon(CupertinoIcons.color_filter, size: 23),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "${trip.calories}kcal",
                                  style: theme.textTheme.headline3,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Row(
                              children: [
                                Icon(Icons.speed, size: 23),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "${trip.averageSpeed.toStringAsFixed(1)}km/h",
                                  style: theme.textTheme.headline3,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.more_time,
                                  size: 23,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  DateFormat(DateFormat.HOUR24_MINUTE).format(trip.startTime),
                                  style: theme.textTheme.headline3,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Row(
                              children: [
                                Icon(Icons.timer_off, size: 23),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  DateFormat(DateFormat.HOUR24_MINUTE).format(trip.endTime),
                                  style: theme.textTheme.headline3,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
