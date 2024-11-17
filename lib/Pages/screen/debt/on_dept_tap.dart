import 'package:flutter/material.dart';
import 'package:money_manage_app2/Model/account_model/debt&loan_model.dart';
import 'package:money_manage_app2/Pages/widget/button/back_button.dart';
import 'package:money_manage_app2/Pages/widget/custom_widget/custom_card.dart';
import 'package:money_manage_app2/util/formated_text.dart';

import '../../../constant/app_colors.dart';
import '../../../constant/app_font.dart';

class OnDeptTap extends StatelessWidget {
  final DebtModel debtData;
  const OnDeptTap({Key? key, required this.debtData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
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
                      debtData.name?.toString() ?? "",
                      style: AppFont.textFieldLabel,
                    ),
                    Text(
                      debtData.phoneNumber?.toString() ?? "",
                      style: AppFont.cardSubTitle,
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, top: 10),
              child: TextAmount(
                text: debtData.totalAmount! > 0
                    ? "I Lend"
                    : debtData.totalAmount == 0
                        ? ""
                        : "I Borrowed",
                amount: debtData.totalAmount?.toDouble() ?? 0,
                textStyle: AppFont.cardSubTitle,
              ),
            ),
            CustomCard(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextAmount(
                        text: "Total Lent",
                        textStyle: AppFont.cardSubTitle,
                        amount: debtData.lendAmount?.toDouble() ?? 0),
                    const SizedBox(
                        height: 50,
                        child: VerticalDivider(
                          color: AppColors.colour2,
                          thickness: 1,
                        )),
                    TextAmount(
                        text: "Total Borrowed",
                        textStyle: AppFont.cardSubTitle,
                        amount: debtData.borrowedAmount?.toDouble() ?? 0),
                  ],
                )),
            Expanded(
              child: ListView.builder(
                itemCount: debtData.transactionList?.length,
                itemBuilder: (context,ind) {

                  final item = debtData.transactionList?[ind];

                  return CustomCard(
                      circularRadius: 12,
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      padding:const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      color: AppColors.containerColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item?.debtType == 0 ? "You gave" :"You borrowed",
                                style: AppFont.white20,
                              ),
                              RichText(
                                  text: TextSpan(
                                      text: "Paid Date : ",
                                      style: AppFont.text16,
                                      children: [
                                    TextSpan(
                                        text: FormattedText.formatDate(item?.date?.toString() ?? ""),
                                        style: AppFont.cardSubTitle)
                                  ])),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                FormattedText.formattedAmount(item?.amount?.toDouble() ?? 0),
                                style: AppFont.white20,
                              ),
                            /*  RichText(
                                  text: TextSpan(
                                      text: "Due Date : ",
                                      style: AppFont.text16,
                                      children: [
                                    TextSpan(
                                        text: " 05 Dec 24",
                                        style: AppFont.cardSubTitle)
                                  ])),*/
                            ],
                          ),
                        ],
                      ));
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}
