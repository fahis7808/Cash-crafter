import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/screen/account_page/add_card_page.dart';
import 'package:money_manage_app2/Pages/screen/account_page/balance_initial_open.dart';
import 'package:money_manage_app2/Pages/screen/account_page/single_acc_page.dart';
import 'package:money_manage_app2/Pages/widget/custom_appbar.dart';
import 'package:money_manage_app2/Pages/widget/custom_widget/balance_showing_widget.dart';
import 'package:money_manage_app2/Pages/widget/custom_widget/custom_card.dart';
import 'package:money_manage_app2/constant/app_colors.dart';
import 'package:money_manage_app2/constant/app_font.dart';
import 'package:money_manage_app2/provider/balance_provider.dart';
import 'package:provider/provider.dart';

import '../../widget/custom_widget/transaction_card.dart';
import '../../widget/graph/graph_chart.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BalanceProvider(),
      child: Consumer<BalanceProvider>(builder: (context, data, _) {
        return Scaffold(
          appBar: const CustomAppBar(title: "Balance"),
          body: data.isLoading
              ? const Column()
              : data.wallet
                  ? const WalletInitialOpen()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MainBalance(
                            amount:
                                data.balanceModel.totalBalance?.toDouble() ?? 0,
                            text: "Main",
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: GestureDetector(
                                        onTap: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const AddAccountPage()))
                                            .then((value) {
                                          data.getData();
                                        }),
                                        // onTap: (){
                                        //   data.getData();
                                        // },
                                        child: Container(
                                          height: 35,
                                          width: 70,
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 0, 5, 15),
                                          decoration: BoxDecoration(
                                              color: AppColors.secondaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Center(
                                              child: Text(
                                            "+Add",
                                            style: AppFont.white20,
                                          )),
                                        ),
                                      ),
                                    ),
                                    Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      // Vertical space between rows of cards
                                      children: data.accountList
                                          .map((data) => InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              SingleAccountPage(
                                                                  title: data
                                                                      .accountName
                                                                      .toString())));
                                                },
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          2 -
                                                      15,
                                                  // Each card takes half of the width minus spacing
                                                  child: AccountCard(
                                                    accName: data.accountName
                                                        .toString(),
                                                    amount: data.balance
                                                            ?.toDouble() ??
                                                        0,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
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
        );
      }),
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
    return CustomCard(
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
    ));
  }
}
