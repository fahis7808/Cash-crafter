import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:money_manage_app2/constant/app_colors.dart';
import 'package:money_manage_app2/constant/app_font.dart';

class LineChartSample2 extends StatefulWidget {
  const LineChartSample2({super.key});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
   // Color(0xFF05169F),
   //  AppColors.primaryColor,
   Color(0xFF05169F),
   Color(0xBD4857C0),
    // AppColors.primaryColor,
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: LineChart(
          mainData(),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    TextStyle style = AppFont.cardSubTitle;
    Widget text;
    switch (value.toInt()) {
      case 1:
        text =  Text('JAN', style: style);
        break;
      case 3:
        text =  Text('MAR', style: style);
        break;
      case 5:
        text =  Text('MAY', style: style);
        break;
      case 7:
        text =  Text('JULY', style: style);
        break;
      case 9:
        text =  Text('SEP', style: style);
        break;
      case 11:
        text =  Text('NOV', style: style);
        break;
      default:
        text =  Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: const FlGridData(
        show: false,
        drawVerticalLine: false,
        horizontalInterval: 1,
        verticalInterval: 1,
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: 12,
      minY: 0,
      maxY: 10,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 5),
            FlSpot(2.6, 2),
            FlSpot(4.9, 8),
            FlSpot(6.8, 2),
            FlSpot(8, 4.2),
            FlSpot(9.5, 3),
            FlSpot(11, 2),
            FlSpot(12, 6),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                AppColors.barBackground,
                AppColors.primaryColor,
              ]
            ),
          ),
        ),
      ],
    );
  }

}