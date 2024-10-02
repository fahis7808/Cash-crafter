import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/widget/text_field/custom_drop_down_field.dart';
import 'package:money_manage_app2/Pages/widget/text_field/custom_text_field.dart';

class MoneyTransfer extends StatelessWidget {
  const MoneyTransfer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomDropdownField<String>(
          items: [],
          onChanged: (val) {},
          value: "",
          labelText: "From",
        ),
        CustomDropdownField<String>(
          items: [],
          onChanged: (val) {},
          value: "",
          labelText: "To",
        ),
        const CustomTextField(
          value: "",
          labelText: "Note",
        ),
      ],
    );
  }
}
