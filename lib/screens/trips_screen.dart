import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
            padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Here your trips",
                    style: theme.textTheme.headline4.copyWith(fontSize: 28)),
                Text("Easily Explore your trips",
                    style: theme.textTheme.headline5.copyWith(fontSize: 20)),
                SizedBox(height: 30,),
                ListView.builder(
                  primary: false,
                  itemBuilder: (context, index) => TripCard(),
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
            Navigator.of(context).pushNamed(AddTripScreen.routeName),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
