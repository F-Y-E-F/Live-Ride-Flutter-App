import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TripChart extends StatefulWidget {
  @override
  _TripChartState createState() => _TripChartState();
}

class _TripChartState extends State<TripChart> {
  List<bool> isSelected = [true, false, false, false];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        ToggleButtons(
          borderColor: Colors.black,
          fillColor: theme.primaryColor,
          borderWidth: 0.5,
          selectedBorderColor: Colors.black,
          selectedColor: Colors.white,
          borderRadius: BorderRadius.circular(10),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
              child: Text(
                '1km',
                style: const TextStyle(fontSize: 16,fontFamily: 'Nunito'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
              child: Text(
                '2km',
                style: const TextStyle(fontSize: 16,fontFamily: 'Nunito'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
              child: Text(
                '5km',
                style: const TextStyle(fontSize: 16,fontFamily: 'Nunito'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
              child: Text(
                '10km',
                style: const TextStyle(fontSize: 16,fontFamily: 'Nunito'),
              ),
            ),
          ],
          onPressed: (int index) {
            setState(() {
              for (int i = 0; i < isSelected.length; i++) {
                isSelected[i] = i == index;
              }
            });
          },
          isSelected: isSelected,
        ),
        Container(
          margin: const EdgeInsets.only(top: 32),
          // child: BarChart(
          //     BarChartData(
          //       barTouchData: BarTouchData(
          //         touchTooltipData: BarTouchTooltipData(
          //             tooltipBgColor: Colors.blueGrey,
          //             getTooltipItem: (group, groupIndex, rod, rodIndex) {
          //               String weekDay;
          //               switch (group.x.toInt()) {
          //                 case 0:
          //                   weekDay = 'Monday';
          //                   break;
          //                 case 1:
          //                   weekDay = 'Tuesday';
          //                   break;
          //                 case 2:
          //                   weekDay = 'Wednesday';
          //                   break;
          //                 case 3:
          //                   weekDay = 'Thursday';
          //                   break;
          //                 case 4:
          //                   weekDay = 'Friday';
          //                   break;
          //                 case 5:
          //                   weekDay = 'Saturday';
          //                   break;
          //                 case 6:
          //                   weekDay = 'Sunday';
          //                   break;
          //               }
          //               return BarTooltipItem(
          //                   weekDay + '\n' + (rod.y - 1).toString(),
          //                   TextStyle(color: Colors.yellow));
          //             }),
          //       ),
          //       titlesData: FlTitlesData(
          //         show: true,
          //         leftTitles: SideTitles(
          //             showTitles: true,
          //             getTextStyles: (value) => const TextStyle(
          //                 color: Colors.black,
          //                 fontWeight: FontWeight.bold,
          //                 fontSize: 14),
          //             getTitles: (double value) {
          //               return "1";
          //             }),
          //         bottomTitles: SideTitles(
          //           showTitles: true,
          //           getTextStyles: (value) => const TextStyle(
          //               color: Colors.black,
          //               fontWeight: FontWeight.bold,
          //               fontSize: 14),
          //           margin: 16,
          //           getTitles: (double value) {
          //             switch (value.toInt()) {
          //               case 0:
          //                 return 'M';
          //               case 1:
          //                 return 'T';
          //               case 2:
          //                 return 'W';
          //               case 3:
          //                 return 'T';
          //               case 4:
          //                 return 'F';
          //               case 5:
          //                 return 'S';
          //               case 6:
          //                 return 'S';
          //               default:
          //                 return '';
          //             }
          //           },
          //         ),
          //       ),
          //       borderData: FlBorderData(
          //         show: false,
          //       ),
          //       barGroups: showingGroups(),
          //     ),
          //     swapAnimationDuration: Duration(seconds: 1)),
        ),
      ],
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(15, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, 5);
          case 1:
            return makeGroupData(1, 6.5);
          case 2:
            return makeGroupData(2, 5);
          case 3:
            return makeGroupData(3, 7.5);
          case 4:
            return makeGroupData(4, 9);
          case 5:
            return makeGroupData(5, 11.5);
          case 6:
            return makeGroupData(6, 6.5);
          default:
            return makeGroupData(i + 1, 6.5);
        }
      });

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 10,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: y,
          colors: isTouched ? [Colors.red] : [barColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 20,
            colors: [Colors.blue],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }
}
