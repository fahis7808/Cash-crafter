import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/screen/budget/on_budget_page.dart';
import 'package:money_manage_app2/Pages/widget/custom_appbar.dart';
import 'package:money_manage_app2/Pages/widget/custom_widget/custom_card.dart';
import 'package:money_manage_app2/Pages/widget/graph/percentage_bar.dart';
import 'package:money_manage_app2/constant/app_font.dart';
import 'package:money_manage_app2/util/formated_text.dart';

import '../../../constant/app_colors.dart';

class BudgetPage extends StatelessWidget {
  final bool showBackBtn;
  const BudgetPage({Key? key, this.showBackBtn = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(showBackBtn: showBackBtn,title: "Budget"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        // child: Center(child: Text("Available on Next Update",style: AppFont.appBarHead,),)
        
       child:  SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Monthly Budget",
                style: AppFont.text16,
              ),
              CustomCard(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => const OnBudgetPage()));
                  },
                  padding: const EdgeInsets.all(15),
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
                      const SizedBox(
                        height: 7,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "15 Days left",
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
    );
  }
}
