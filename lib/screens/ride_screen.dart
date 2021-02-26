import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:live_ride/helpers/snack_helper.dart';
import 'package:live_ride/models/trip.dart';
import '../helpers/location_helper.dart';

class RideScreen extends StatefulWidget {
  @override
  _RideScreenState createState() => _RideScreenState();
}

class _RideScreenState extends State<RideScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  final _locationStream = LocationHelper.getCurrentLocation();

  final Trip _trip = Trip(
      startTime: DateTime.now(),
      isStart: false,
      altitude: 0.0,
      averageSpeed: 0.0,
      calories: 0,
      distance: 0.0,
      maxSpeed: 0.0,
      nbOfAverageSpeeds: 0,
      duration: 0);

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    _checkPermissions();
    _listenLocationChanges();
    super.initState();
  }

  void _listenLocationChanges() {
    _locationStream.listen((Position event) {
      if (_trip.isStart) {
        //print(event.speed * 3.6);
        print(_trip.duration);
      }
    });
  }

  Future<void> _checkPermissions() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return SnackHelper.showContentSnack(
          'You must enable location services !', context);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return SnackHelper.showContentSnack(
          'Location permissions are permantly denied, we cannot request permissions.',
          context);
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return SnackHelper.showContentSnack(
            'Location permissions are denied (actual value: $permission).',
            context);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return StreamBuilder<Position>(
      stream: _locationStream,
      builder: (context, snapshot) => Scaffold(
        body: snapshot.hasData
            ? SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        child: Text(
                          "Your Trip",
                          style: theme.textTheme.headline4.copyWith(
                              color: Colors.grey.shade900, fontSize: 28),
                          textAlign: TextAlign.center,
                        ),
                        padding: const EdgeInsets.only(top: 25),
                        width: double.infinity),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 70.0),
                      child: Divider(
                        thickness: 3,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 60,
                        ),
                        Text(
                          "GPS",
                          style: theme.textTheme.headline6,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.signal_cellular_alt,
                          color: Colors.red,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FittedBox(
                        child: Text(
                      _trip.isStart
                          ? (snapshot.data.speed * 3.6).toStringAsFixed(1)
                          : "0.0",
                      style: TextStyle(
                          fontSize: 120,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w700,
                          letterSpacing: -5,
                          height: 1),
                    )),
                    Text(
                      "km/h",
                      style: theme.textTheme.headline6,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(_trip.distance.toStringAsFixed(1),
                                    style: theme.textTheme.headline4
                                        .copyWith(height: 1)),
                                Text("kilometers",
                                    style: theme.textTheme.headline5
                                        .copyWith(height: 1)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text("0:23",
                                    style: theme.textTheme.headline4
                                        .copyWith(height: 1)),
                                Text("Duration",
                                    style: theme.textTheme.headline5
                                        .copyWith(height: 1)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text("14.7",
                                    style: theme.textTheme.headline4
                                        .copyWith(height: 1)),
                                Text("avg. speed",
                                    style: theme.textTheme.headline5
                                        .copyWith(height: 1)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text("243",
                                    style: theme.textTheme.headline4
                                        .copyWith(height: 1)),
                                Text("calories",
                                    style: theme.textTheme.headline5
                                        .copyWith(height: 1)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text("231",
                                    style: theme.textTheme.headline4
                                        .copyWith(height: 1)),
                                Text("altitude",
                                    style: theme.textTheme.headline5
                                        .copyWith(height: 1)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text("42.3",
                                    style: theme.textTheme.headline4
                                        .copyWith(height: 1)),
                                Text("max speed",
                                    style: theme.textTheme.headline5
                                        .copyWith(height: 1)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(7),
                            margin: const EdgeInsets.only(bottom: 40),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade400),
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              tooltip: 'View Map',
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              icon: Icon(
                                Icons.location_on_rounded,
                                color: Colors.grey.shade900,
                              ),
                              iconSize: 35,
                              onPressed: () {},
                            )),
                        Container(
                            padding: const EdgeInsets.all(7),
                            margin: const EdgeInsets.only(bottom: 55),
                            decoration: BoxDecoration(
                              color: theme.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              tooltip: 'Start Trip',
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              icon: AnimatedIcon(
                                icon: AnimatedIcons.play_pause,
                                progress: _animationController,
                                color: Colors.white,
                              ),
                              iconSize: 50,
                              onPressed: _startStopTrip,
                            )),
                        Container(
                            padding: const EdgeInsets.all(7),
                            margin: const EdgeInsets.only(bottom: 40),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade400),
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              tooltip: 'Info',
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              icon: Icon(
                                Icons.info,
                                color: Colors.grey.shade900,
                              ),
                              iconSize: 35,
                              onPressed: () {},
                            )),
                      ],
                    )
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  //------------------------| Start / Stop Trip |-----------------------------
  void _startStopTrip() {
    _trip.isStart = !_trip.isStart;
    SnackHelper.showContentSnack(
        _trip.isStart ? "Trip started" : "Trip stopped", context);
    _trip.isStart
        ? _animationController.forward()
        : _animationController.reverse();
  }

//==========================================================================

}
