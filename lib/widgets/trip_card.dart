import 'package:flutter/material.dart';

class TripCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ClipRRect(borderRadius: BorderRadius.circular(10),child: Image.network('https://simlock24.pl/foto/09_27_20_Apple_Maps.png',width: 90,height: 90,fit: BoxFit.cover,)),
          )
        ],
      ),
    );
  }
}
