import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:money_manage_app2/constant/app_colors.dart';

class PieChartSample2 extends StatefulWidget {
  final double? radius;

  const PieChartSample2({super.key, this.radius});

  @override
  State<PieChartSample2> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartSample2> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        startDegreeOffset: -90,
        centerSpaceRadius: widget.radius ?? 40,
        sections: [
          PieChartSectionData(
            color: AppColors.tertiaryColor,
            value: 70,
            title: '40%',
            showTitle: false,
            radius: 13,
            badgeWidget: null, // Ensure no badge overlap with rounding
            badgePositionPercentageOffset: .98,
            // borderSide: BorderSide(width: 2,color: AppColors.containerColor,strokeAlign: 5)
          ),
          PieChartSectionData(
              color: AppColors.primaryColor,
              value: 30,
              title: '40%',
              showTitle: false,
              radius: 13,
              badgeWidget: null,
              badgePositionPercentageOffset: .10,
              borderSide: BorderSide(width: 2, color: AppColors.containerColor))
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final radius = isTouched ? 20.0 : 15.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Color(0xFF1E8EEE),
            value: 50,
            title: '40%',
            showTitle: false,
            radius: radius,
          );
        case 1:
          return PieChartSectionData(
            color: AppColors.primaryColor,
            value: 50,
            showTitle: false,
            radius: radius,
          );
        default:
          throw Error();
      }
    });
  }
}
