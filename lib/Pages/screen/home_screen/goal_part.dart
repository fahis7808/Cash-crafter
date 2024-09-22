import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/widget/custom_widget/custom_card.dart';
import 'package:money_manage_app2/constant/app_colors.dart';

import '../../../constant/app_font.dart';

class GoalPart extends StatelessWidget {
  const GoalPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color1: AppColors.containerColor,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Saving Goal",
            style: AppFont.buttonText,
          ),
          const SizedBox(
            height: 10,
          ),
          const GoalBar(
            title: "MacBook Pro",
            amount: 1200,
            percentage: 12,
          ), const GoalBar(
            title: "Car",
            amount: 50000,
            percentage: 20,
          ), const GoalBar(
            title: "Phone",
            amount: 1000,
            percentage: 50,
          ),
        ],
      ),
    );
  }
}

class GoalBar extends StatelessWidget {
  final String title;
  final double amount;
  final double percentage;

  const GoalBar(
      {Key? key,
      required this.title,
      required this.amount,
      required this.percentage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppFont.cardSubTitle,
            ),
            Text(
              "\u{20B9} $amount",
              style: AppFont.cardSubTitle,
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        LayoutBuilder(builder: (context, constraints) {
          double parentWidth = constraints.maxWidth;
          return Container(
            width: parentWidth,
            height: 28,
            decoration: BoxDecoration(
              color: AppColors.barBackground,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Container(
                  width: parentWidth * (percentage / 100),
                  height: 28,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: percentage > 12
                      ? Center(
                          child: Text("${percentage.toInt()}%",
                              style: AppFont.cardTitle))
                      : null,
                ),
                const SizedBox(
                  width: 10,
                ),
                percentage < 13
                    ? Text(
                        "${percentage.toInt()}%",
                        style: AppFont.cardTitle,
                      )
                    : const SizedBox()
              ],
            ),
          );
        }),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
