import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:live_ride/helpers/snack_helper.dart';

class TripChart extends StatefulWidget {
  final List<double> intervalSpeeds;

  TripChart(this.intervalSpeeds);

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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                '1min',
                style: const TextStyle(fontSize: 16, fontFamily: 'Nunito'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                '2min',
                style: const TextStyle(fontSize: 16, fontFamily: 'Nunito'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                '5min',
                style: const TextStyle(fontSize: 16, fontFamily: 'Nunito'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                '10min',
                style: const TextStyle(fontSize: 16, fontFamily: 'Nunito'),
              ),
            ),
          ],
          onPressed: (int index) {
            switch (index) {
              case 1:
                if (widget.intervalSpeeds.length < 2) {
                  return SnackHelper.showContentSnack(
                      'Too short distance to show 2 min interval speeds',
                      context);
                }
                break;
              case 2:
                if (widget.intervalSpeeds.length < 5) {
                  return SnackHelper.showContentSnack(
                      'Too short distance to show 5 min interval speeds',
                      context);
                }
                break;
              case 3:
                if (widget.intervalSpeeds.length < 10) {
                  return SnackHelper.showContentSnack(
                      'Too short distance to show 10 min interval speeds',
                      context);
                }
                break;
            }
            setState(() {
              for (int i = 0; i < isSelected.length; i++)
                isSelected[i] = i == index;
            });
          },
          isSelected: isSelected,
        ),
        Container(
          margin: const EdgeInsets.only(top: 32),
          child: BarChart(mainData()),
        ),
      ],
    );
  }

  BarChartData mainData() {
    final color = Theme.of(context).primaryColor;
    const radius = BorderRadius.only(
        topLeft: Radius.circular(20), topRight: Radius.circular(20));
    return BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: widget.intervalSpeeds.reduce(max).ceil().toDouble(),
        minY: 0,
        barTouchData: BarTouchData(
          enabled: false,
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.transparent,
            tooltipPadding: const EdgeInsets.all(0),
            tooltipBottomMargin: 3,
            getTooltipItem: (
              BarChartGroupData group,
              int groupIndex,
              BarChartRodData rod,
              int rodIndex,
            ) {
              return BarTooltipItem(
                rod.y.toStringAsFixed(2),
                TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Nunito',
                    fontSize: 12),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
            showTitles: true,
            getTextStyles: (value) => const TextStyle(
                color: const Color(0xff3061D7),
                fontWeight: FontWeight.bold,
                fontSize: 14),
            margin: 20,
            getTitles: (double value) {
              return (value.toInt()+1).toString() + "min";
            },
          ),
          leftTitles: SideTitles(showTitles: false),
        ),
        borderData: FlBorderData(
            show: true,
            border:
                Border.all(width: 2, color: color, style: BorderStyle.solid)),
        barGroups: widget.intervalSpeeds
            .map((e) => BarChartGroupData(
                    x: widget.intervalSpeeds.indexOf(e),
                    barRods: [
                      BarChartRodData(
                          y: double.parse(e.toStringAsFixed(1)),
                          colors: [color],
                          borderRadius: radius)
                    ],
                    showingTooltipIndicators: [
                      0
                    ]))
            .toList());
  }
}
