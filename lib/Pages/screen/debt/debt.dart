import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/widget/custom_appbar.dart';
import 'package:money_manage_app2/Pages/widget/custom_widget/custom_card.dart';
import 'package:money_manage_app2/constant/app_font.dart';
import 'package:money_manage_app2/util/formated_text.dart';

import '../../../constant/app_colors.dart';

class DebtPage extends StatelessWidget {
  const DebtPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Debt Page"),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomCard(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 25),
                    child: Column(
                      children: [
                        Text(
                          "You wil get",
                          style: AppFont.cardTitle,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          FormattedText.formattedAmount(54232),
                          style: AppFont.text25,
                        )
                      ],
                    )),
                CustomCard(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 25),
                    child: Column(
                      children: [
                        Text(
                          "You wil get",
                          style: AppFont.cardTitle,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          FormattedText.formattedAmount(2102),
                          style: AppFont.text25,
                        )
                      ],
                    )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            CustomCard(
              padding: const EdgeInsets.only(left: 20, top: 5, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(
                          text: "No.of EMI:",
                          style: AppFont.cardSubTitle,
                          // style: AppFont.cardTitle,
                          children: [
                        TextSpan(text: " 2", style: AppFont.textFieldLabel)
                      ])),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Monthly EMI",
                            style: AppFont.cardSubTitle,
                          ),
                          Text(
                            FormattedText.formattedAmount(23523),
                            style: AppFont.text25,
                          )
                        ],
                      ),
                      const SizedBox(
                          height: 50,
                          child: VerticalDivider(
                            color: AppColors.colour2,
                            thickness: 1,
                          )),
                      Column(
                        children: [
                          Text(
                            "Loan Amount",
                            style: AppFont.cardSubTitle,
                          ),
                          Text(
                            FormattedText.formattedAmount(23523),
                            style: AppFont.text25,
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
