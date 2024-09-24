import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/widget/custom_widget/balance_showing_widget.dart';
import 'package:money_manage_app2/Pages/widget/custom_widget/custom_card.dart';
import 'package:money_manage_app2/Pages/widget/graph/graph_chart.dart';
import 'package:money_manage_app2/constant/app_colors.dart';
import 'package:money_manage_app2/constant/app_font.dart';

class SingleAccountPage extends StatelessWidget {
  const SingleAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              CupertinoIcons.back,
              color: AppColors.white,
            )),
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "Wallet",
          style: AppFont.subCardMainText,
        ),
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MainBalance(amount: 1243),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              height: 120,
              child: Row(
                children: [
                  Expanded(child: IncomeExpenseCard(amount: 1239)),
                  SizedBox(width: 10,),
                  Expanded(child: IncomeExpenseCard(income:false,amount: 1239))
                ],
              ),
            ),
          ),
          LineChartSample2(),

        ],
      ),
    );
  }
}

class CustomATMCard extends StatelessWidget {
  const CustomATMCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        child: Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Wallet",
              style: AppFont.cardSubTitle,
            ),
            const SizedBox(
              height: 70,
            ),
            const Text(
              "**** **** **** 3265",
              style: TextStyle(
                  fontSize: 20,
                  color: AppColors.white,
                  fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 15,),
            Text("09/24",style: AppFont.cardSubTitle,)
          ],
        ),
      ],
    ));
  }
}
