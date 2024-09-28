import 'package:flutter/material.dart';
import 'package:money_manage_app2/util/formated_text.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppFont.buttonText,
              ),
              const SizedBox(
                height: 200,
                child: PieChartSample2(),
              ),
              RichText(
                  text: TextSpan(
                      text: FormattedText.formattedAmount(1233),
                      style: AppFont.subCardMainText,
                      children: [
                        TextSpan(
                            text:
                            " / ${FormattedText.formattedAmount(3242)}",
                            style: AppFont.cardSubTitle)
                      ])),
            ],
          ),
        ));
  }
}
