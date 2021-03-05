import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:live_ride/helpers/slide_route.dart';
import '../screens/ride_screen.dart';

class AddTripScreen extends StatefulWidget {
  static const routeName = "/add-trip-screen";

  @override
  _AddTripScreenState createState() => _AddTripScreenState();
}

class _AddTripScreenState extends State<AddTripScreen> {
  Color _pickerColor =
      Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  Color _currentColor =
      Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);

  @override
  Widget build(BuildContext context) {
    if (_pickerColor != _currentColor) _currentColor = _pickerColor;
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Color(0xFFF3F3F3),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 42, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, bottom: 36),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 28,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Add new trip",
                        style:
                            theme.textTheme.headline4.copyWith(fontSize: 28)),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                child: Text(
                  'Name',
                  style: TextStyle(
                      color: theme.primaryColor, fontWeight: FontWeight.w600),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  hintText: 'Trip Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none),
                  fillColor: Colors.white,
                  filled: true,
                  hintStyle:
                      TextStyle(color: theme.primaryColor.withOpacity(0.5)),
                ),
                style: TextStyle(
                    color: theme.primaryColor, fontWeight: FontWeight.w600),
                cursorColor: theme.primaryColor,
              ),
              const SizedBox(
                height: 42,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Trip Color (click to change)',
                    style:
                        theme.textTheme.headline5.copyWith(color: Colors.black),
                  )),
              const SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text('Pick a color!'),
                            content: SingleChildScrollView(
                              child: ColorPicker(
                                pickerColor: _pickerColor,
                                onColorChanged: (Color color){
                                  _pickerColor = color;
                                },
                                showLabel: true,
                                pickerAreaHeightPercent: 0.8,
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: TextButton.styleFrom(
                                    textStyle: TextStyle(
                                        color: theme.primaryColor,
                                        fontWeight: FontWeight.w600)),
                              ),
                              TextButton(
                                child: const Text('Choose'),
                                onPressed: () {
                                  setState(() => _currentColor = _pickerColor);
                                  Navigator.of(context).pop();
                                },
                                style: TextButton.styleFrom(
                                    textStyle: TextStyle(
                                        color: theme.primaryColor,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ],
                          )),
                  child: Container(
                    height: 100,
                    width: 100,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                color: _currentColor, shape: BoxShape.circle),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            child: Icon(
                              Icons.edit,
                              size: 18,
                              color: Colors.white,
                            ),
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                                color: theme.primaryColor,
                                shape: BoxShape.circle),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 7),
        child: TextButton.icon(
          icon: Icon(
            Icons.directions_bike,
            color: Colors.white,
            size: 26,
          ),
          style: TextButton.styleFrom(
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            backgroundColor: theme.primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
          ),
          onPressed: () =>
              Navigator.of(context).pushAndRemoveUntil(SlideRoute(builder: (context) => RideScreen()),(r)=>false),
          label: Text(
            "GO",
            style: theme.textTheme.headline4
                .copyWith(color: Colors.white, fontSize: 26),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

}
