import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/widget/custom_appbar.dart';
import 'package:money_manage_app2/Pages/widget/custom_widget/custom_card.dart';
import 'package:money_manage_app2/constant/app_font.dart';
import 'package:money_manage_app2/util/formated_text.dart';

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
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "You have left 10000 for remaining 15 days",
                      style: AppFont.text16,
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
