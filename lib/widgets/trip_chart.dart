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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                '1km',
                style: const TextStyle(fontSize: 16, fontFamily: 'Nunito'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                '2km',
                style: const TextStyle(fontSize: 16, fontFamily: 'Nunito'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                '5km',
                style: const TextStyle(fontSize: 16, fontFamily: 'Nunito'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                '10km',
                style: const TextStyle(fontSize: 16, fontFamily: 'Nunito'),
              ),
            ),
          ],
          onPressed: (int index) {
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
    const radius = BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20));
    return BarChartData(
      alignment: BarChartAlignment.spaceAround,
      maxY: 20,
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
                fontSize: 12
              ),
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
            switch (value.toInt()) {
              case 0:
                return '1km';
              case 1:
                return '2km';
              case 2:
                return '3km';
              case 3:
                return '4km';
              case 4:
                return '5km';
              case 5:
                return '6km';
              case 6:
                return '7km';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(showTitles: false),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(
              width: 2,
              color: color,
              style: BorderStyle.solid)),
      barGroups: [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
                y: 8, colors: [color],borderRadius: radius,)
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
                y: 10, colors: [color],borderRadius: radius)
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
                y: 14, colors: [color],borderRadius: radius)
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
                y: 15, colors: [color],borderRadius: radius)
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
                y: 13, colors: [color],borderRadius: radius)
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
                y: 10, colors: [color],borderRadius: radius)
          ],
          showingTooltipIndicators: [0],
        ),
      ],
    );
  }
}
