import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/widget/text_field/custom_text_field.dart';
import 'package:money_manage_app2/Pages/widget/text_field/date_field.dart';
import 'package:money_manage_app2/constant/app_colors.dart';
import 'package:money_manage_app2/constant/app_font.dart';

class DebtTab extends StatefulWidget {
  const DebtTab({Key? key}) : super(key: key);

  @override
  State<DebtTab> createState() => _DebtTabState();
}

class _DebtTabState extends State<DebtTab> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _DebtSwitch(
              isSelected: selectedIndex == 0,
              onTap: () {
                setState(() {
                  selectedIndex = 0;
                });
              },
              label: "I Lend",
            ),
            SizedBox(
              width: 15,
            ),
            _DebtSwitch(
              isSelected: selectedIndex == 1,
              onTap: () {
                setState(() {
                  selectedIndex = 1;
                });
              },
              label: "I Own",
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        CustomTextField(
          value: "",
          labelText: selectedIndex == 0 ? "To Whom" : "From Whom",
          prefixIcon: FluentIcons.person_12_filled,
        ),
        CustomDateField(
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
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
        decoration: BoxDecoration(
            color: isSelected ? AppColors.tertiaryColor : AppColors.cardColor,
            borderRadius: BorderRadius.circular(30)),
        child: Text(label, style: AppFont.text25),
      ),
    );
  }
}
