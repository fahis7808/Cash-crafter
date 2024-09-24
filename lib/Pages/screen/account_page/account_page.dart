import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/widget/custom_widget/balance_showing_widget.dart';
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
             const MainBalance(
               amount: 23523,
               text: "Main",
             ),
              const SizedBox(
                height: 25,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        const SizedBox(
                          height: 10,
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
                        const SizedBox(
                          height: 210,
                          child: LineChartSample2(),
                        ),
                        Text(
                          "Transaction History",
                          style: AppFont.buttonText,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemBuilder: ((context, index) =>
                                  const TransactionCard())),
                        ),
                      ],
                    ),
                  ),
                ),
              )
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

  const AccountCard({Key? key, required this.accName, required this.amount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomCard(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            accName,
            style: AppFont.cardSubTitle,
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "\u{20B9} $amount",
              style: AppFont.buttonText,
            ),
          )
        ],
      )),
    );
  }
}

class TransactionCard extends StatelessWidget {
  const TransactionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: CustomCard(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Monthly Salary",
                style: AppFont.textFieldLabel,
              ),
              Text(
                "Wallet",
                style: AppFont.cardSubTitle,
              )
            ],
          ),
          Column(
            children: [
              const Text(
                "\u{20B9} 25,000",
                style: TextStyle(
                    fontSize: 20,
                    color: AppColors.positiveColor,
                    fontWeight: FontWeight.w800),
              ),
              Text(
                "24 Sep 24",
                style: AppFont.cardSubTitle,
              )
            ],
          )
        ],
      )),
    );
  }
}
