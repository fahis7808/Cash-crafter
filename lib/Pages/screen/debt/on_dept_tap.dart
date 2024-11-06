import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/widget/button/back_button.dart';
import 'package:money_manage_app2/Pages/widget/custom_widget/custom_card.dart';
import 'package:money_manage_app2/util/formated_text.dart';

import '../../../constant/app_colors.dart';
import '../../../constant/app_font.dart';

class OnDeptTap extends StatelessWidget {
  const OnDeptTap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomBackButton(),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Aboobacker Fahis",
                      style: AppFont.textFieldLabel,
                    ),
                    Text(
                      "88932 88945",
                      style: AppFont.cardSubTitle,
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25,top: 10),
              child: TextAmount(text: "I Lend", amount: 2342,textStyle: AppFont.cardSubTitle,),
            ),

            CustomCard(
                margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextAmount(
                    text: "Total Lent",
                    textStyle: AppFont.cardSubTitle,
                    amount: 4500),
                const SizedBox(
                    height: 50,
                    child: VerticalDivider(
                      color: AppColors.colour2,
                      thickness: 1,
                    )),
                TextAmount(
                    text: "Total Borrowed",
                    textStyle: AppFont.cardSubTitle,
                    amount: 6500),
              ],
            )),

            CustomCard(
              circularRadius: 12,
              margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              padding: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                color: AppColors.containerColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("You gave",style: AppFont.white20,),
                    RichText(
                        text: TextSpan(
                            text: "Paid Date : ",
                            style: AppFont.text16,
                            children: [
                              TextSpan(
                                  text:
                                  " 05 Nov 24",
                                  style: AppFont.cardSubTitle)
                            ])),

                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(FormattedText.formattedAmount(2342),style: AppFont.white20,),
                    RichText(
                        text: TextSpan(
                            text: "Due Date : ",
                            style: AppFont.text16,
                            children: [
                              TextSpan(
                                  text:
                                  " 05 Dec 24",
                                  style: AppFont.cardSubTitle)
                            ])),

                  ],
                ),
              ],
            ))

          ],
        ),
      ),
    );
  }
}
