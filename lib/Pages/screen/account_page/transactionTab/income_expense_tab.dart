import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/screen/account_page/transactionTab/category_page.dart';
import 'package:money_manage_app2/Pages/widget/text_field/custom_drop_down_field.dart';
import 'package:money_manage_app2/Pages/widget/text_field/custom_text_field.dart';
import 'package:money_manage_app2/Pages/widget/text_field/date_field.dart';
import 'package:money_manage_app2/provider/balance_provider.dart';
import 'package:provider/provider.dart';

class IncomeExpenseTab extends StatelessWidget {
  const IncomeExpenseTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BalanceProvider>(context, listen: false);
    return Column(
      children: [
        GestureDetector(
          onTap: () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (ctx) => CategoryPage())),
          child: CustomDropdownField<String>(
            prefixIcon: FluentIcons.app_folder_20_filled,
            items: [],
            onChanged: (val) {},
            value: "",
            labelText: "Category",
          ),
        ),
        const CustomDateField(
          labelText: "Date",
          prefixIcon: FluentIcons.calendar_3_day_16_filled,
        ),
        const CustomTextField(
          value: "",
          labelText: "Comment",
          prefixIcon: FluentIcons.comment_note_20_filled,
        )
      ],
    );
  }
}
