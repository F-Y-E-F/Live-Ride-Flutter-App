import 'package:flutter/material.dart';
import '../helpers/slide_route.dart';
import '../widgets/trip_card.dart';
import '../screens/add_trip_screen.dart';

class TripsScreen extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:15.0),
                  child: Text("Here your trips",
                      style: theme.textTheme.headline4.copyWith(fontSize: 28)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:15.0),
                  child: Text("Easily Explore your trips",
                      style: theme.textTheme.headline5.copyWith(fontSize: 20)),
                ),
                SizedBox(height: 30,),
                ListView.builder(
                  primary: false,
                  itemBuilder: (context, index) => TripCard(index),
                  itemCount: 20,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.primaryColor,
        elevation: 2,
        highlightElevation: 4,
        splashColor: const Color(0xff020063),
        child: Icon(Icons.add_rounded),
        onPressed: () =>
            Navigator.of(context).push(SlideRoute(builder: (context) => AddTripScreen()))
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
