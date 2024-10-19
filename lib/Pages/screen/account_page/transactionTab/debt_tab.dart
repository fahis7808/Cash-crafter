import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/widget/text_field/custom_text_field.dart';
import 'package:money_manage_app2/Pages/widget/text_field/date_field.dart';
import 'package:money_manage_app2/constant/app_colors.dart';
import 'package:money_manage_app2/constant/app_font.dart';
import 'package:money_manage_app2/provider/balance_provider.dart';
import 'package:provider/provider.dart';

import '../../../widget/text_field/custom_drop_down_field.dart';

class DebtTab extends StatefulWidget {
  const DebtTab({Key? key}) : super(key: key);

  @override
  State<DebtTab> createState() => _DebtTabState();
}

class _DebtTabState extends State<DebtTab> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BalanceProvider>(context, listen: false);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _DebtSwitch(
              isSelected: provider.transactionModel.debtType == 0,
              onTap: () {
                setState(() {
                  provider.transactionModel.debtType = 0;
                });
              },
              label: "I Lend",
            ),
            const SizedBox(
              width: 15,
            ),
            _DebtSwitch(
              isSelected: provider.transactionModel.debtType == 1,
              onTap: () {
                setState(() {
                  provider.transactionModel.debtType = 1;
                });
              },
              label: "I Own",
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        CustomTextField(
          value: "",
          labelText:
              provider.transactionModel.debtType == 0 ? "To Whom" : "From Whom",
          prefixIcon: FluentIcons.person_12_filled,
        ),
        CustomDropdownField<String>(
          items: provider.accountList.map((e) {
            return e.accountName.toString();
          }).toList(),
          onChanged: (val) {},
          value: "",
          labelText: "Account",
          prefixIcon: FluentIcons.building_bank_16_filled,
        ),
        const CustomDateField(
          labelText: "Till Date",
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

class _DebtSwitch extends StatelessWidget {
  final String label;
  final void Function() onTap;
  final bool isSelected;

  const _DebtSwitch(
      {Key? key,
      required this.label,
      required this.onTap,
      required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        decoration: BoxDecoration(
            color: isSelected ? AppColors.tertiaryColor : AppColors.cardColor,
            borderRadius: BorderRadius.circular(30)),
        child: Text(label, style: AppFont.text25),
      ),
    );
  }
}
