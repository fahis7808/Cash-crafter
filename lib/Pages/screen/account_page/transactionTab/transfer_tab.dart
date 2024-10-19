import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manage_app2/Pages/widget/text_field/custom_drop_down_field.dart';
import 'package:money_manage_app2/Pages/widget/text_field/custom_text_field.dart';
import 'package:money_manage_app2/provider/balance_provider.dart';
import 'package:provider/provider.dart';

import '../../../widget/text_field/date_field.dart';

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
          onChanged: (val) {
            data.getACBalance(val.toString(), data.transactionModel.amount, false);
          },
          value: data.transactionModel.from,
          labelText: "From",
          prefixIcon: FluentIcons.building_bank_16_filled,
        ),
        CustomDropdownField<String>(
          items: data.accountList.map((e) {
            return e.accountName.toString();
          }).toList(),
          onChanged: (val) {
            data.transactionModel.to = val;
          },
          value: data.transactionModel.to,
          labelText: "To",
          prefixIcon: FluentIcons.building_bank_16_filled,
        ),
        CustomDateField(
          labelText: "Date",
          prefixIcon: FluentIcons.calendar_3_day_16_filled,
          onDateSelected: (val) {
            data.transactionModel.date = DateFormat('dd-MM-yyyy').format(val);
          },
        ),
        CustomTextField(
          value: data.transactionModel.note,
          labelText: "Comment",
          prefixIcon: FluentIcons.comment_note_20_filled,
          onChanged: (val) {
            data.transactionModel.note = val;
          },
        ),
      ],
    );
  }
}
