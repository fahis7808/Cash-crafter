import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/widget/text_field/custom_drop_down_field.dart';
import 'package:money_manage_app2/Pages/widget/text_field/custom_text_field.dart';
import 'package:money_manage_app2/provider/balance_provider.dart';
import 'package:provider/provider.dart';

class MoneyTransfer extends StatelessWidget {
  const MoneyTransfer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<BalanceProvider>(context, listen: false);
    return Column(
      children: [
        CustomDropdownField<String>(
          items: data.accountList.map((e) {
            return e.accountName.toString();
          }).toList(),
          onChanged: (val) {},
          value: "",
          labelText: "From",
        ),
        CustomDropdownField<String>(
          items: data.accountList.map((e) {
            return e.accountName.toString();
          }).toList(),
          onChanged: (val) {},
          value: "",
          labelText: "To",
        ),
        CustomTextField(
          value: data.transactionModel.note,
          labelText: "Note",
          onChanged: (val) {
            data.transactionModel.note = val;
          },
        ),
      ],
    );
  }
}
