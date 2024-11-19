import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../Pages/widget/custom_widget/custom_card.dart';
import '../../../util/formated_text.dart';

import '../../../constant/app_colors.dart';

class LineChartSample1 extends StatefulWidget {
  final Map<String, dynamic> listData;

  const LineChartSample1({
    super.key,
    required this.listData,
  });

  @override
  State<LineChartSample1> createState() => _LineChartSample1State();
}

class _LineChartSample1State extends State<LineChartSample1> {
  late double touchedValue;

  @override
  void initState() {
    touchedValue = -1;
    setFlSpot();
    super.initState();
  }

  List<FlSpot> incomeFlSpot = [];
  List<FlSpot> expenseFlSpot = [];
  List<String> yValue = [];
  double maxY = 0;

  void setFlSpot() {
    List<Map<String, dynamic>> data = widget.listData["data"] ?? [];

    incomeFlSpot = data.asMap().entries.map((e) {
      double x = e.key.toDouble(); // Index for x-axis
      double y = e.value["income"]?.toDouble() ?? 0.0; // Income value for y-axis
      return FlSpot(x, y);
    }).toList();

    expenseFlSpot = data.asMap().entries.map((e) {
      double x = e.key.toDouble(); // Index for x-axis
      double y = e.value["expense"]?.toDouble() ?? 0.0; // Expense value for y-axis
      return FlSpot(x, y);
    }).toList();

    yValue = data.map((e) => e["date"] as String).toList(); // Extract dates for x-axis labels

    double maxIncome = incomeFlSpot.isEmpty ? 0 : incomeFlSpot.map((spot) => spot.y).reduce((a, b) => a > b ? a : b);
    double maxExpense = expenseFlSpot.isEmpty ? 0 : expenseFlSpot.map((spot) => spot.y).reduce((a, b) => a > b ? a : b);
    maxY = (maxIncome > maxExpense ? maxIncome : maxExpense).ceilToDouble();

    if (maxY < 25) maxY = 25; // Ensure maxY has a minimum value for visibility

    print("Income FlSpot: $incomeFlSpot");
    print("Expense FlSpot: $expenseFlSpot");
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: const EdgeInsets.fromLTRB(0, 15, 20, 1),
      child: AspectRatio(
        aspectRatio: 2,
        child: LineChart(
          LineChartData(
            gridData: gridData,
            titlesData: titlesData1,
            lineTouchData: const LineTouchData(enabled: false),
            borderData: FlBorderData(
              show: false,
            ),
            lineBarsData: [
              lineChartBarData1_1,
              lineChartBarData1_2,
            ],
            minX: 0, // Start from index 0
            maxX: incomeFlSpot.length - 1, // Max index
            maxY: maxY,
            minY:-30,
          ),
          curve: Curves.bounceIn,
          duration: const Duration(milliseconds: 250),
        ),
      ),
    );
  }

  FlTitlesData get titlesData1 =>
      FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 18,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        rightTitles:
        const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            getTitlesWidget: leftTitleWidgets,
            showTitles: true,
            interval: (maxY / 4).ceilToDouble(),
            reservedSize: 60,
          ),
        ),
      );

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      color: AppColors.textColor,
      fontSize: 14,
    );


    String text;
    if (value % (maxY / 4).ceilToDouble() == 0) {
      text = FormattedText.formattedAmount(value.toInt().toDouble());
    } else {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Text(text, style: style, textAlign: TextAlign.center),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      color: AppColors.textColor,
      fontSize: 14,
    );
    int interval = (yValue.length > 6) ? (yValue.length / 6).ceil() : 1;

    String text;
    if (value.toInt() % interval == 0 && value.toInt() < yValue.length) {
      text = yValue[value.toInt()];
    } else {
      text = ''; // Empty string for other values
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 3,
      child: Text(text, style: style),
    );
  }

  FlGridData get gridData =>
      const FlGridData(
        show: false,
        drawVerticalLine: false,
        horizontalInterval: 1,
      );

  LineChartBarData get lineChartBarData1_1 =>
      LineChartBarData(
          isCurved: true,
          color: AppColors.tertiaryColor,
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(show: false),
          spots: incomeFlSpot);

  LineChartBarData get lineChartBarData1_2 =>
      LineChartBarData(
          isCurved: true,
          color: AppColors.textColor,
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(show: false),
          spots: expenseFlSpot);
}
