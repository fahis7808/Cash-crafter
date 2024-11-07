import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manage_app2/Pages/widget/text_field/custom_text_field.dart';
import 'package:money_manage_app2/Pages/widget/text_field/date_field.dart';
import 'package:money_manage_app2/provider/balance_provider.dart';
import 'package:provider/provider.dart';

import '../../../widget/text_field/custom_drop_down_field.dart';
import 'category_page.dart';

class IncomeExpenseTab extends StatefulWidget {
  final bool isIncome;

  const IncomeExpenseTab({Key? key, this.isIncome = false}) : super(key: key);

  @override
  State<IncomeExpenseTab> createState() => _IncomeExpenseTabState();
}

class _IncomeExpenseTabState extends State<IncomeExpenseTab> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BalanceProvider>(context, listen: false);
    return Column(
      children: [
        CustomDropdownField<String>(
          items: provider.accountList.map((e) {
            return e.accountName.toString();
          }).toList(),
          onChanged: (val) {setState(() {
            if(widget.isIncome){
              provider.transactionModel.credit = val;
              provider.transactionModel.debit = null;
            }else{
              provider.transactionModel.debit = val;
              provider.transactionModel.credit = null;
            }
          });

            print(provider.transactionModel.debit);
            print(provider.transactionModel.credit);
          },
          value: widget.isIncome
              ? provider.transactionModel.credit
              : provider.transactionModel.debit,
          labelText:  "Account",
          prefixIcon: FluentIcons.building_bank_16_filled,
        ),
        CustomTextField(
          prefixIcon: FluentIcons.app_folder_20_filled,
          readOnly: true,
          value: provider.transactionModel.category,
          onTap: () async {
            await Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) =>  CategoryPage(isIncome: widget.isIncome,)))
                .then((value) {
              if (value != null) {
                setState(() {
                  provider.transactionModel.category = value;
                });
              }
            });
          },
          labelText: "Category",
        ),

        CustomDateField(
          labelText: "Date",
          prefixIcon: FluentIcons.calendar_3_day_16_filled,
          onDateSelected: (val) {
            provider.transactionModel.date = DateFormat('dd-MM-yyyy').format(val);
          },
        ),
        CustomTextField(
          value: provider.transactionModel.note,
          labelText: "Comment",
          prefixIcon: FluentIcons.comment_note_20_filled,
          onChanged: (val) {
            provider.transactionModel.note = val;
          },
        ),
        // CustomButton(
        //     buttonText: "demo",
        //     onPressed: () {
        //       print(provider.category);
        //     })
      ],
    );
  }
}
