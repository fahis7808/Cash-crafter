import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/screen/budget/budge_add_page.dart';
import 'package:money_manage_app2/Pages/widget/button/floating_action_button.dart';
import 'package:money_manage_app2/Pages/widget/custom_appbar.dart';
import 'package:money_manage_app2/Pages/widget/custom_widget/custom_card.dart';
import 'package:money_manage_app2/Pages/widget/graph/percentage_bar.dart';
import 'package:money_manage_app2/constant/app_font.dart';
import 'package:money_manage_app2/util/formated_text.dart';

import '../../../constant/app_colors.dart';


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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Monthly Budget",style: AppFont.cardColored,),
              CustomCard(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Monthly Budget",
                            style: AppFont.white20,
                          ),
                          Text(
                            FormattedText.formattedAmount(2659),
                            style: AppFont.white20,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "15 Nov - 15 Dec",
                            style: AppFont.cardSubTitle,
                          ),
                         /* Text(
                            "Left Amount ${FormattedText.formattedAmount(9874)}",
                            style: AppFont.cardSubTitle,
                          ),*/
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
                        height: 15,
                      ),
                      const PercentageBar(
                        percentage1: 30,
                        percentage2: 50,
                      )
                    ],
                  )),
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
