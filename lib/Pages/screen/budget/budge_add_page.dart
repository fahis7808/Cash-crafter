import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/widget/button/button.dart';
import 'package:money_manage_app2/Pages/widget/custom_appbar.dart';
import 'package:money_manage_app2/Pages/widget/text_field/custom_drop_down_field.dart';
import 'package:money_manage_app2/Pages/widget/text_field/custom_text_field.dart';
import 'package:money_manage_app2/Pages/widget/text_field/date_field.dart';

class AddBudgetPage extends StatelessWidget {
  const AddBudgetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Add Budget"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 20,),
            const CustomTextField(
              value: "",
              labelText: "Name",
            ),
            const CustomTextField(
              value: "",
              labelText: "Amount",
            ),
            const CustomTextField(
              value: "",
              labelText: "Category",
            ),
            CustomDropdownField(
              items: const ["Weekly", "Monthly", "Yearly", "Custom"],
              onChanged: (val) {},
              value: "",
              labelText: "Period",
            ),
            DateTimePicker(
              labelText: "Start Date",
              onChange: (val) {},
            ),
            SizedBox(height: 20,),
            CustomButton(buttonText: "Add Budget", onPressed: (){})
          ],
        ),
      ),
    );
  }
}
