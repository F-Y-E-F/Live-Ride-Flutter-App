import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:live_ride/helpers/slide_route.dart';
import 'package:live_ride/screens/trip_details_screen.dart';

class TripCard extends StatelessWidget {
  final int index;

  TripCard(this.index);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .push(SlideRoute(builder: (context) => TripDetailsScreen(index))),
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
                      'https://simlock24.pl/foto/09_27_20_Apple_Maps.png',
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
                            shape: BoxShape.circle, color: Colors.green),
                        width: 12,
                        height: 12,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Jazda rekreacyjna",
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
                                  "23km",
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
                                  "01:23:00",
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
                                  "432 kcal",
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
                                Icon(Icons.height_rounded, size: 23),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "242 m",
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
                                  "12:32",
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
                                  "14:12",
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
