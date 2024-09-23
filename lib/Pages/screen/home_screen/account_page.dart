import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/widget/custom_widget/custom_card.dart';
import 'package:money_manage_app2/constant/app_colors.dart';
import 'package:money_manage_app2/constant/app_font.dart';

import '../../widget/graph/graph_chart.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 20, bottom: 10),
                child: Text(
                  "Total Balance",
                  style: AppFont.cardSubTitle,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "\u{20B9} 79,564",
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Row(
                children: [
                  AccountCard(
                    accName: "Wallet",
                    amount: 2342,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  AccountCard(
                    accName: "Federal",
                    amount: 23433,
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              const Row(
                children: [
                  AccountCard(
                    accName: "Wallet",
                    amount: 2342,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  AccountCard(
                    accName: "Federal",
                    amount: 23433,
                  ),
                ],
              ),
              SizedBox(height: 250,child: LineChartSample2(),)
            ],
          ),
        ),
      ),
    );
  }
}

class AccountCard extends StatelessWidget {
  final String accName;
  final double amount;
  const AccountCard({Key? key, required this.accName, required this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomCard(
          color1: AppColors.containerColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                accName,
                style: AppFont.cardSubTitle,
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("\u{20B9} $amount",style: AppFont.buttonText,),
              )
            ],
          )),
    );
  }
}
