import 'package:flutter/material.dart';


class TripDetailsScreen extends StatelessWidget {
  static const routeName = '/trip-details-screen';
  final int index;
  TripDetailsScreen(this.index);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Hero(
            tag: 'map$index',
            child: Image.network(
              'https://simlock24.pl/foto/09_27_20_Apple_Maps.png',
              width: double.infinity,
              height: 280,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
}
