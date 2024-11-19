import 'package:flutter/material.dart';
import '../../../constant/app_colors.dart';
import '../../../util/formated_text.dart';

import '../../../constant/app_font.dart';
import '../graph/pie_chart.dart';
import 'custom_card.dart';

class PieChartCard extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final double spentAmount;
  final double totalAmount;

  const PieChartCard(
      {Key? key,
      this.onTap,
      required this.title,
      required this.spentAmount,
      required this.totalAmount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppFont.buttonText,
              ),
              Row(
                children: [
                  const Expanded(
                    child: SizedBox(
                      height: 200,
                      child: PieChartSample2(),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "October 2024",
                          style: AppFont.white20,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        barIdentifier("Spent", 2343, AppColors.secondaryColor),
                        barIdentifier("Balance", 2343, AppColors.barBackground)
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget barIdentifier(String text, double amount, Color circleColor) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          color: circleColor,
          size: 20,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          "${FormattedText.formattedAmount(amount)} $text",
          style: const TextStyle(
              fontSize: 18,
              color: AppColors.textColor,
              fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
