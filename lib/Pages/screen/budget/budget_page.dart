import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/screen/budget/budge_add_page.dart';
import 'package:money_manage_app2/Pages/widget/button/floating_action_button.dart';
import 'package:money_manage_app2/Pages/widget/custom_appbar.dart';
import 'package:money_manage_app2/Pages/widget/custom_widget/custom_card.dart';
import 'package:money_manage_app2/Pages/widget/custom_widget/pie_chart_card.dart';
import 'package:money_manage_app2/constant/app_colors.dart';
import 'package:money_manage_app2/constant/app_font.dart';
import 'package:money_manage_app2/util/formated_text.dart';

import '../../widget/graph/pie_chart.dart';

class BudgetPage extends StatelessWidget {
  final List<Map<String, dynamic>> accountData = [
    {"title": "Food & Drinks", "amount": 2342.5, "spent": 3423.0},
    {"title": "Petrol", "amount": 2563.0, "spent": 534.0},
    {"title": "Savings", "amount": 1578.0, "spent": 2364.0},
    {"title": "Dress", "amount": 9587.0, "spent": 9873.0},
  ];

  BudgetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Budget"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomCard(
                child: Row(
                  children: [
                    const Expanded(
                      child: SizedBox(
                          height: 230,
                          child: PieChartSample2(
                            radius: 75,
                          )),
                    ),
                    const SizedBox(
                      width: 10,
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
                        const SizedBox(
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
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                              color: const Color(0x49049F35),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.check_circle_outline,
                                color: AppColors.positiveColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "On Track",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: AppColors.positiveColor),
                              ),
                            ],
                          ),
                        )
                      ],
                    ))
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Wrap(
                runSpacing: 5,
                spacing: 5,
                children: accountData
                    .map((e) => SizedBox(
                          width: MediaQuery.of(context).size.width / 2 - 15,
                          child: PieChartCard(
                              title: e["title"],
                              spentAmount: e["spent"],
                              totalAmount: e["amount"]),
                        ))
                    .toList(),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddBudgetPage())),
      ),
    );
  }
}
