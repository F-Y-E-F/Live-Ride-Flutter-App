import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './screens/ride_screen.dart';

void main() {
  runApp(LiveRide());
}

class LiveRide extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Nunito',
        primaryColor: const Color(0xff3061D7),
        dividerColor: const Color(0xff3061D7),
        textTheme: ThemeData.light().textTheme.copyWith(
          headline4: TextStyle(color: const Color(0xff000000),fontSize: 32,fontWeight: FontWeight.w700,fontFamily: 'Nunito'),
          headline5: TextStyle(color: const Color(0xff9e9e9e),fontSize: 18,fontWeight: FontWeight.w700,fontFamily: 'Nunito'),
          headline6: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w700,fontFamily: 'Nunito'),
        )
      ),
      home: RideScreen()
    );
  }
}


