import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/widget/text_field/custom_drop_down_field.dart';
import 'package:money_manage_app2/Pages/widget/text_field/custom_text_field.dart';
import 'package:money_manage_app2/Pages/widget/text_field/date_field.dart';

class IncomeExpenseTab extends StatelessWidget {
  const IncomeExpenseTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomDropdownField<String>(
          prefixIcon: FluentIcons.app_folder_20_filled,
          items: [],
          onChanged: (val) {},
          value: "",
          labelText: "Category",
        ),
        CustomDateField(
          labelText: "Date",
          prefixIcon: Icon(FluentIcons.calendar_3_day_16_filled,color: Colors.white,),
        ),
        CustomTextField(
          value: "",
          labelText: "Comment",
          prefixIcon: Icon(FluentIcons.comment_note_20_filled,color: Colors.white,),
        )
      ],
    );
  }
}
