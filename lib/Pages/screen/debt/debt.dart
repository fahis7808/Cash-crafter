import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/screen/debt/total_loan_card.dart';
import 'package:money_manage_app2/Pages/widget/custom_appbar.dart';
import 'package:money_manage_app2/Pages/widget/custom_widget/custom_card.dart';


class DebtPage extends StatelessWidget {
  const DebtPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Debt Page"),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextAmount(text: "I Lend", amount: 4532),
                  TextAmount(text: "I Owe", amount: 6535),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            MainLoanCard()
          ],
        ),
      ),
    );
  }
}
