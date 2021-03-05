import 'package:flutter/material.dart';

class TripDetailsScreen extends StatelessWidget {
  final int index;

  TripDetailsScreen(this.index);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: 'map$index',
              child: InteractiveViewer(
                child: Image.network(
                  'https://i.imgur.com/BDxieQD.png',
                  width: double.infinity,
                  height: 280,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Nice trip",
              style: theme.textTheme.headline4.copyWith(fontSize: 22),
            ),
            Container(
              width: 200,
              height: 3,
              color: Colors.red,
              margin: EdgeInsets.only(top: 5, bottom: 30),
            ),
            Row(
              children: [
                _getTripSquareInfo(theme,0.5,1,1,0.5,"DURATION","03:12:21"),
                _getTripSquareInfo(theme,0.5,0.5,1,1,"AVG. SPEED (KM/H)","21.32")
              ],
            ),
            Row(
              children: [
                _getTripSquareInfo(theme,0.5,1,0.5,0.5,"MAX SPEED (KM/H)","52.21"),
                _getTripSquareInfo(theme,0.5,0.5,0.5,1,"DISTANCE (KM)","42.32")
              ],
            ),
            Row(
              children: [
                _getTripSquareInfo(theme,0.5,1,0.5,0.5,"ALTITUDE (M)","298"),
                _getTripSquareInfo(theme,0.5,0.5,0.5,1,"CALORIES (KCAL)","431")
              ],
            ),
            Row(
              children: [
                _getTripSquareInfo(theme,1,1,0.5,0.5,"START TIME","12:31"),
                _getTripSquareInfo(theme,1,0.5,0.5,1,"END TIME","14:32")
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget _getTripSquareInfo(ThemeData theme,double bt,double lt, double tp, double rg, String title,String text) =>
      Expanded(
          child: Container(
            padding: const EdgeInsets.fromLTRB(12,16,12,12),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.grey[300], width: bt),
                    left: BorderSide(color: Colors.grey[300], width: lt),
                    top: BorderSide(color: Colors.grey[300], width: tp),
                    right: BorderSide(color: Colors.grey[300], width: rg))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  child: Text(
                    title,
                    style: theme.textTheme.headline3.copyWith(fontSize: 15),
                  ),
                ),
                FittedBox(
                    child: Text(
                      text,
                      style: theme.textTheme.headline4,
                    )),
              ],
            ),
            height: 100,
          ));

}
