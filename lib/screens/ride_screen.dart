import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:live_ride/providers/trips_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/ride_map.dart';
import '../helpers/snack_helper.dart';
import '../models/trip.dart';
import '../helpers/location_helper.dart';

class RideScreen extends StatefulWidget {
  static const routeName = 'ride-screen';
  final String color;
  final String name;

  RideScreen(this.color, this.name);

  @override
  _RideScreenState createState() => _RideScreenState();
}

class _RideScreenState extends State<RideScreen> with TickerProviderStateMixin {
  AnimationController _animationController;
  AnimationController _endAnimationController;
  AnimationController _offsetAnimationController;
  Animation<double> _endTripAnimation;
  Animation<Offset> _offsetAnimation;
  final _locationStream = LocationHelper.getCurrentLocation();

  StreamSubscription<Position> _locationStreamSubscription;
  final Trip _trip = Trip(
      startTime: DateTime.now(),
      isStart: false,
      altitude: 0.0,
      averageSpeed: 0.0,
      calories: 0,
      distance: 0.0,
      maxSpeed: 0.0,
      coordinatesList: [],
      duration: 0,
      color: '0xffff0000',
      name: 'Nice trip',
      id: null);

  Timer _timer;

  @override
  void initState() {
    _trip.name = widget.name == "" ? "Nice trip" : widget.name;
    _trip.color = widget.color;

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));

    _endAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _offsetAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));

    //------------------circular progress tap to end--------------------
    _endTripAnimation =
        Tween<double>(begin: 0, end: 1).animate(_endAnimationController)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              SnackHelper.showContentSnack("FINISHED", context);
              _trip.endTime = DateTime.now();

              /// Tu będzie koniec tripu
              Provider.of<TripsProvider>(context, listen: false)
                  .insertTrip(_trip)
                  .then((_) => Navigator.of(context).pushNamed('/'));
            }
          });

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1),
      end: const Offset(0.0, 0),
    ).animate(CurvedAnimation(
      parent: _offsetAnimationController,
      curve: Curves.easeInOut,
    ));

    _checkPermissions();
    _listenLocationChanges();
    super.initState();
  }

  //----------------| Check Location Permissions---------------------
  Future<void> _checkPermissions() async {
    await LocationHelper.checkPermissions(context);
    setState(() {});
  }

  //===================================================================

  //------------------------| Start / Stop Trip |-----------------------------
  void _startStopTrip() {
    setState(() => _trip.isStart = !_trip.isStart);

    if (_trip.isStart)
      _startDuration();
    else
      _timer.cancel();

    SnackHelper.showContentSnack(
        _trip.isStart ? "Trip started" : "Trip stopped", context);
    _trip.isStart
        ? _animationController.forward()
        : _animationController.reverse();
  }

  //==========================================================================

  //-----------------| Start Duration Timer |----------------------
  void _startDuration() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() => _trip.duration += 1);
    });
  }

  //=================================================================

  void _listenLocationChanges() {
    _locationStreamSubscription = _locationStream.listen((Position position) {
      if (_trip.isStart) {
        setState(() {
          _trip.coordinatesList
              .add(LatLng(position.latitude, position.longitude));
          _trip.addDistance();
          if (position.speed * 3.6 > _trip.maxSpeed)
            _trip.maxSpeed = position.speed * 3.6;
          _trip.calculateAverageSpeed(position.speed * 3.6);
          _trip.calculateCalories();
          _trip.calculateAverageAltitude(position.altitude);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return StreamBuilder<Position>(
      stream: _locationStream,
      builder: (context, snapshot) => Scaffold(
        body: snapshot.hasData
            ? Stack(
                children: [
                  SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            child: Text(
                              _trip.name,
                              style: theme.textTheme.headline4.copyWith(
                                  color: Colors.grey.shade900, fontSize: 28),
                              textAlign: TextAlign.center,
                            ),
                            padding: const EdgeInsets.only(top: 25),
                            width: double.infinity),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 70.0),
                          child: Divider(
                            color: Color(int.parse(_trip.color)),
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
                                    Text(
                                        (_trip.distance / 1000)
                                            .toStringAsFixed(2),
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
                                    FittedBox(
                                      child: Text(
                                          _trip.refactoredDuration.toString(),
                                          style: theme.textTheme.headline4
                                              .copyWith(height: 1)),
                                    ),
                                    Text("Duration",
                                        style: theme.textTheme.headline5
                                            .copyWith(height: 1)),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(_trip.averageSpeed.toStringAsFixed(1),
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
                                    Text(_trip.calories.toString(),
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
                                    FittedBox(
                                      child: Text(
                                          _trip.isStart
                                              ? snapshot.data.altitude
                                                  .toStringAsFixed(1)
                                              : "300.0",
                                          style: theme.textTheme.headline4
                                              .copyWith(height: 1)),
                                    ),
                                    Text("altitude",
                                        style: theme.textTheme.headline5
                                            .copyWith(height: 1)),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(_trip.maxSpeed.toStringAsFixed(1),
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
                              width: 68,
                              height: 68,
                              padding: const EdgeInsets.all(7),
                              margin: const EdgeInsets.only(bottom: 35),
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
                                  onPressed: () =>
                                      _offsetAnimationController.forward()),
                            ),
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
                            GestureDetector(
                              onLongPressUp: () => !_trip.isStart
                                  ? _endAnimationController.reverse()
                                  : null,
                              onLongPress: () => !_trip.isStart
                                  ? _endAnimationController.forward()
                                  : SnackHelper.showContentSnack(
                                      "Cannot end trip when trip is already started. Stop first trip!",
                                      context,
                                      2500),
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Container(
                                      width: 68,
                                      height: 68,
                                      padding: const EdgeInsets.all(7),
                                      margin: const EdgeInsets.only(bottom: 35),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.shade400),
                                        shape: BoxShape.circle,
                                      ),
                                      child: IconButton(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        icon: Icon(
                                          Icons.stop_sharp,
                                        ),
                                        disabledColor: Colors.grey[500],
                                        color: Colors.red,
                                        iconSize: 35,
                                        onPressed:
                                            !_trip.isStart ? () {} : null,
                                      )),
                                  SizedBox(
                                    height: 68,
                                    width: 68,
                                    child: CircularProgressIndicator(
                                      value: _endTripAnimation.value,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  RideMap(
                    latitude: snapshot.data.latitude,
                    longitude: snapshot.data.longitude,
                    startLatitude: _trip.coordinatesList.isNotEmpty
                        ? _trip.coordinatesList[0].latitude ??
                            snapshot.data.latitude
                        : snapshot.data.latitude,
                    startLongitude: _trip.coordinatesList.isNotEmpty
                        ? _trip.coordinatesList[0].longitude ??
                            snapshot.data.longitude
                        : snapshot.data.longitude,
                    offsetAnimation: _offsetAnimation,
                    offsetAnimationController: _offsetAnimationController,
                    polylines: _trip.polylines,
                  )
                ],
              )
            : Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
                ),
              ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _endAnimationController.dispose();
    _offsetAnimationController.dispose();
    _locationStreamSubscription.cancel();
    if(_timer != null) _timer.cancel();
    super.dispose();
  }
}
