import 'package:flutter/material.dart';
import 'package:cash_crafter/Pages/widget/custom_appbar.dart';
import 'package:cash_crafter/Pages/widget/custom_widget/custom_card.dart';
import 'package:cash_crafter/Pages/widget/graph/bar_graph.dart';
import 'package:cash_crafter/constant/app_font.dart';
import 'package:cash_crafter/util/formated_text.dart';

import '../../../constant/app_colors.dart';
import '../../widget/graph/percentage_bar.dart';

class OnBudgetPage extends StatelessWidget {
  const OnBudgetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Monthly Budget"),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            CustomCard(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          FormattedText.formattedAmount(15000),
                          style: AppFont.white20,
                        ),
                        Text(
                          "70%",
                          style: AppFont.appBarHead,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const PercentageBar(
                      percentage1: 30,
                      percentage2: 50,
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RichText(
                            text: TextSpan(
                                text: FormattedText.formattedAmount(45232),
                                // style: AppFont.subCardMainText,
                                style: AppFont.cardTitle,
                                children: [
                              TextSpan(
                                  text:
                                      " / ${FormattedText.formattedAmount(56245)}",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: AppColors.secondaryColor))
                            ])),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(FormattedText.formattedAmount(2342),style: AppFont.textFieldLabel,),
                            Text("Daily Average",style: AppFont.cardTitle,)
                          ],
                        ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(FormattedText.formattedAmount(2342),style: AppFont.textFieldLabel,),
                              Text("Daily recommended",style: AppFont.cardTitle,)
                            ],
                          )

                        ],
                      ),
                    ),

                    Text(
                      "You have left 10000 for remaining 15 days",
                      style: AppFont.text16,
                    )
                  ],
                )),

            SizedBox(height: 10),
            SizedBox(height: 200,child: BarChartSample3(),)
          ],
        ),
      ),
    );
  }
}
