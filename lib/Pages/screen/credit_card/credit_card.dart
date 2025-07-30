import 'package:cash_crafter/Pages/screen/credit_card/card_section.dart';
import 'package:cash_crafter/Pages/widget/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class CreditCard extends StatelessWidget {
  const CreditCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Credit Card", showBackBtn: true),
      body: Column(
        children: [
          CardSection(),
          SizedBox(
            height: 10,
          ),
          CreditCardWidget(
              cardNumber: "424 2424 2424 2424",
              expiryDate: "29/12",
              cardHolderName: "",
              cvvCode: "232",
              bankName: "",
              labelCardHolder: "",
              isHolderNameVisible: true,
              width: 170,

              showBackView: false,
              onCreditCardWidgetChange: (val) {})
        ],
      ),
    );
  }
}
