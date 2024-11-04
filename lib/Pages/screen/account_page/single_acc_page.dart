import 'package:flutter/material.dart';
import 'package:money_manage_app2/Model/account_model/account_model.dart';
import 'package:money_manage_app2/Pages/widget/custom_appbar.dart';
import 'package:money_manage_app2/Pages/widget/custom_widget/balance_showing_widget.dart';
import 'package:money_manage_app2/Pages/widget/graph/graph_chart.dart';
import 'package:money_manage_app2/constant/app_font.dart';
import '../../../Model/account_model/transaction_model.dart';
import '../../widget/custom_widget/transaction_card.dart';

class SingleAccountPage extends StatelessWidget {
final AccountModel account;
final List<TransactionModel> list;
  const SingleAccountPage({Key? key, required this.account, required this.list, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(title: account.accountName.toString(),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             MainBalance(amount: account.balance?.toDouble() ?? 0),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: SizedBox(
                  height: 960,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const SizedBox(
                      //   height: 120,
                      //   child: Row(
                      //     children: [
                      //       Expanded(child: IncomeExpenseCard(amount: 1239)),
                      //       SizedBox(
                      //         width: 10,
                      //       ),
                      //       Expanded(
                      //           child: IncomeExpenseCard(
                      //               income: false, amount: 1239))
                      //     ],
                      //   ),
                      // ),
                      const LineChartSample2(),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Transaction History",
                        style: AppFont.buttonText,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                       Expanded(
                        child:  TransactionCard(data: list,accountName: account.accountName,)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
