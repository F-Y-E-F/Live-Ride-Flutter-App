import 'package:flutter/material.dart';

class RideScreen extends StatefulWidget {
  @override
  _RideScreenState createState() => _RideScreenState();
}

class _RideScreenState extends State<RideScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    super.initState();
  }

  var isStart = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                child: Text(
                  "Your Trip",
                  style: theme.textTheme.headline4
                      .copyWith(color: Colors.grey.shade900, fontSize: 28),
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
                const SizedBox(
                  height: 60,
                ),
                Text(
                  "GPS",
                  style: theme.textTheme.headline6,
                ),
                const SizedBox(
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
              "12.45",
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
                        Text("5.64",
                            style:
                                theme.textTheme.headline4.copyWith(height: 1)),
                        Text("kilometers",
                            style:
                                theme.textTheme.headline5.copyWith(height: 1)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text("0:23",
                            style:
                                theme.textTheme.headline4.copyWith(height: 1)),
                        Text("Duration",
                            style:
                                theme.textTheme.headline5.copyWith(height: 1)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text("14.7",
                            style:
                                theme.textTheme.headline4.copyWith(height: 1)),
                        Text("avg. speed",
                            style:
                                theme.textTheme.headline5.copyWith(height: 1)),
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
                            style:
                                theme.textTheme.headline4.copyWith(height: 1)),
                        Text("calories",
                            style:
                                theme.textTheme.headline5.copyWith(height: 1)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text("231",
                            style:
                                theme.textTheme.headline4.copyWith(height: 1)),
                        Text("altitude",
                            style:
                                theme.textTheme.headline5.copyWith(height: 1)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text("42.3",
                            style:
                                theme.textTheme.headline4.copyWith(height: 1)),
                        Text("max speed",
                            style:
                                theme.textTheme.headline5.copyWith(height: 1)),
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
                    padding: EdgeInsets.all(7),
                    margin: EdgeInsets.only(bottom: 40),
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
                    padding: EdgeInsets.all(7),
                    margin: EdgeInsets.only(bottom: 55),
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
                      onPressed: () {
                        isStart = !isStart;
                        ScaffoldMessengerState().showSnackBar(SnackBar(
                            content: Text(
                                isStart ? 'Trip Started' : 'Trip Stopped')));
                        isStart
                            ? _animationController.forward()
                            : _animationController.reverse();
                      },
                    )),
                Container(
                    padding: EdgeInsets.all(7),
                    margin: EdgeInsets.only(bottom: 40),
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
      ),
    );
  }
}
