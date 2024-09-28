import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:money_manage_app2/constant/app_colors.dart';
import 'package:money_manage_app2/constant/app_font.dart';

class PieChartSample2 extends StatefulWidget {
  const PieChartSample2({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        PieChart(
          PieChartData(
            pieTouchData: PieTouchData(
              touchCallback: (FlTouchEvent event, pieTouchResponse) {
                setState(() {
                  if (!event.isInterestedForInteractions ||
                      pieTouchResponse == null ||
                      pieTouchResponse.touchedSection == null) {
                    touchedIndex = -1;
                    return;
                  }
                  touchedIndex =
                      pieTouchResponse.touchedSection!.touchedSectionIndex;
                });
              },
            ),
            borderData: FlBorderData(
              show: false,
            ),
            sectionsSpace: 0,
            startDegreeOffset: -90,
            centerSpaceRadius: 60,
            sections: [
              PieChartSectionData(
                color: AppColors.secondaryColor,
                value: 50,
                title: '40%',
                showTitle: false,
                radius: 15,
              ),
              PieChartSectionData(
                color: AppColors.barBackground,
                value: 50,
                title: '40%',
                showTitle: false,
                radius: 15,
              )
            ],
          ),
        ),
        Text("54%",style: AppFont.appBarHead,)
      ],
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
