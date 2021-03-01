import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../screens/ride_screen.dart';

class AddTripScreen extends StatefulWidget {
  static const routeName = "/";

  @override
  _AddTripScreenState createState() => _AddTripScreenState();
}

class _AddTripScreenState extends State<AddTripScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Color(0xFFF3F3F3),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20,42,20,0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Padding(
                  padding: const EdgeInsets.only(left:10.0,bottom: 36),
                  child: Row(
                    children: [
                      Text("Add new trip",style:theme.textTheme.headline4),
                      SizedBox(width: 10,),
                      Icon(Icons.directions_bike,size: 36,)
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(left:15.0,bottom: 5),
                child: Text('Name',style: TextStyle(
                    color: theme.primaryColor,
                    fontWeight: FontWeight.w600
                ),),
              ),
              TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25,vertical: 20),
                  hintText: 'Trip Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  hintStyle: TextStyle(
                    color: theme.primaryColor.withAlpha(85)
                  ),
                ),
                style: TextStyle(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.w600
                ),
                cursorColor: theme.primaryColor,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: TextButton.icon(
        icon: Icon(
          Icons.directions_bike,
          color: Colors.white,
          size: 26,
        ),
        style: TextButton.styleFrom(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          backgroundColor: theme.primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
        ),
        onPressed: () => Navigator.of(context).pushNamed(RideScreen.routeName),
        label: Text(
          "GO",
          style: theme.textTheme.headline4.copyWith(color: Colors.white,fontSize: 26),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
