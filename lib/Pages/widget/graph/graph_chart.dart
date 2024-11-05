import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/widget/button/button.dart';
import 'package:money_manage_app2/constant/app_colors.dart';
import 'package:money_manage_app2/constant/app_font.dart';

import '../../../Model/account_model/transaction_model.dart';

class LineChartSample2 extends StatefulWidget {
  final List<TransactionModel> transList;
  const LineChartSample2({super.key, required this.transList});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    AppColors.secondaryColor,
    Color(0xBD4857C0),
  ];

  List<FlSpot> flSpot = [];
  double xLength = 0;

  void setFlSpot(){
    flSpot = widget.transList.asMap().entries.map((e) {
      int index = e.key;
      TransactionModel data = e.value;
      double x = index.toDouble();
      double y = data.amount?.toDouble() ?? 0;
      print(flSpot);
      xLength = widget.transList.length.toDouble();
      return FlSpot(x, y);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 50,
          width: 200,
          child: CustomButton(buttonText: "demo", onPressed: (){
            print("<<<<<<<<<object>>>>>>>>>");
            print("<<<<<<<<<object>>>>>>>>>");
          setFlSpot();
          }),
        ),
        AspectRatio(
          aspectRatio: 2  ,
          child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: LineChart(
              mainData(),
            ),
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
        text = Text('FEB', style: style);
        break;
      case 3:
        text = Text('APR', style: style);
        break;
      case 5:
        text = Text('JUN', style: style);
        break;
      case 7:
        text = Text('AUG', style: style);
        break;
      case 9:
        text = Text('OCT', style: style);
        break;
      case 11:
        text = Text('DEC', style: style);
        break;
      default:
        text = Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  LineChartData mainData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) {
            return AppColors.secondaryColor;
          },
          getTooltipItems: (List<LineBarSpot> touchedSpots) {
            return touchedSpots.map((spot) {
              return LineTooltipItem(
                '\u{20B9} ${spot.y} K', // Customize the displayed text
                const TextStyle(
                  color: Color(0xFF8C95A6), // Text color
                  fontWeight: FontWeight.bold, // Text weight
                  fontSize: 16, // Font size
                ),
              );
            }).toList();
          },
        ),
      ),
      gridData: const FlGridData(
        show: true,
        drawVerticalLine: false,
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
            showTitles: false,
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
      maxX: xLength,
      minY: 0,
      maxY: 600,
      lineBarsData: [
        LineChartBarData(
          spots: flSpot,
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
            gradient: const LinearGradient(
              colors: [
                AppColors.barBackground,
                AppColors.primaryColor,
              ],
              tileMode: TileMode.clamp,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }
}
