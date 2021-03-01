import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../helpers/snack_helper.dart';
import '../models/trip.dart';
import '../helpers/location_helper.dart';

class RideScreen extends StatefulWidget {
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

  final Trip _trip = Trip(
      startTime: DateTime.now(),
      isStart: false,
      altitude: 0.0,
      averageSpeed: 0.0,
      calories: 0,
      distance: 0.0,
      maxSpeed: 0.0,
      coordinatesList: [],
      duration: 0);

  Timer _timer;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));

    _endAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _offsetAnimationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 800));

    //------------------circular progress tap to end--------------------
    _endTripAnimation =
        Tween<double>(begin: 0, end: 1).animate(_endAnimationController)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              SnackHelper.showContentSnack("FINISHED", context);

              /// Tu będzie koniec tripu
              _trip.endTime = DateTime.now();
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
    _locationStream.listen((Position position) {
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
                                    Text((_trip.distance / 1000).toStringAsFixed(2),
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
                                  onPressed: () => _offsetAnimationController.forward()),
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
                                        border:
                                            Border.all(color: Colors.grey.shade400),
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
                                        onPressed: !_trip.isStart ? () {} : null,
                                      )),
                                  SizedBox(
                                    height: 68,
                                    width: 68,
                                    child: CircularProgressIndicator(
                                      value: _endTripAnimation.value,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
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
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SlideTransition(
                    position: _offsetAnimation,
                    child: Container(
                      width: double.infinity,
                      height: 350,
                      child: Stack(
                        children: [
                          GoogleMap(
                            markers: null,
                            myLocationEnabled: true,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(6.843369, 79.874814),
                              zoom: 12.99,
                            ),
                            polygons: _trip.polylines,),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              margin: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: theme.primaryColor
                              ),
                              child: IconButton(icon: Icon(Icons.arrow_downward_rounded,color: Colors.white,), onPressed: (){
                                _offsetAnimationController.reverse();
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
  List<LatLng> getPoints() {
    return [
      LatLng(6.862472, 79.859482),
      LatLng(6.862258, 79.862325),
      LatLng(6.863121, 79.863644),
      LatLng(6.864538, 79.865039),
      LatLng(6.865124, 79.864546),
      LatLng(6.866451, 79.864667),
      LatLng(6.867303, 79.86544),
      LatLng(6.867899, 79.865826),
      LatLng(6.867867, 79.866727),
      LatLng(6.864884, 79.870333),
      LatLng(6.861859, 79.873112),
      LatLng(6.861593, 79.87499),
      LatLng(6.860837, 79.876427),

    ];
  }
  @override
  void dispose() {
    _animationController.dispose();
    _endAnimationController.dispose();
    super.dispose();
  }
}
