import 'package:flutter/material.dart';
import 'package:cash_crafter/Pages/widget/text_field/custom_text_field.dart';

class AddLoanTab extends StatelessWidget {
  const AddLoanTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CustomTextField(value: "",labelText: "Loan Name",),
        CustomTextField(value: "",labelText: "Loan Amount",keyboardType: TextInputType.number,),
        CustomTextField(value: "",labelText: "Emi Date",),
        CustomTextField(value: "",labelText: "Loan Tenor",),
        CustomTextField(value: "",labelText: "Start Month",),
      ],
    );
  }
}
