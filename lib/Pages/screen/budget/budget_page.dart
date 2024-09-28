import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/widget/custom_appbar.dart';
import 'package:money_manage_app2/Pages/widget/custom_widget/custom_card.dart';
import 'package:money_manage_app2/constant/app_colors.dart';
import 'package:money_manage_app2/constant/app_font.dart';
import 'package:money_manage_app2/util/formated_text.dart';

import '../../widget/graph/pie_chart.dart';

class BudgetPage extends StatelessWidget {
  const BudgetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Budget"),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomCard(
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(height: 150, child: PieChartSample2()),
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Left",
                        textAlign: TextAlign.left,
                        style: AppFont.cardSubTitle,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      RichText(
                          text: TextSpan(
                              text: FormattedText.formattedAmount(1233),
                              style: AppFont.subCardMainText,
                              children: [
                            TextSpan(
                                text:
                                    " / ${FormattedText.formattedAmount(3242)}",
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: AppColors.tertiaryColor))
                          ])),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Color(0x490A9432),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "On Track",
                          style: TextStyle(fontWeight: FontWeight.w600,
                              fontSize: 15, color: AppColors.positiveColor),
                        ),
                      )
                    ],
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
