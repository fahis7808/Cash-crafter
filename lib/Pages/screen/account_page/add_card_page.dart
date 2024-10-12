import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/widget/custom_appbar.dart';
import 'package:money_manage_app2/Pages/widget/text_field/custom_drop_down_field.dart';
import 'package:money_manage_app2/Pages/widget/text_field/custom_text_field.dart';
import 'package:money_manage_app2/constant/app_colors.dart';
import 'package:money_manage_app2/constant/app_font.dart';

class AddAccountPage extends StatelessWidget {
  const AddAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool haveATM = false;
    return Scaffold(
      appBar: const CustomAppBar(title: "Add Card"),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomTextField(
                value: "",
                labelText: "Account Name",
              ),
              const CustomTextField(
                value: "",
                labelText: "Account Number",
              ),
              const CustomTextField(
                value: "",
                labelText: "Current Balance",
                keyboardType: TextInputType.number,
              ),
              CustomDropdownField(
                  items: ["Salary", "Savings", "Current"],
                  labelText: "Account Type",
                  onChanged: (val) {},
                  value: ""),
             CheckBoxRow(
               text: "Have ATM Card",
               initialCheckValue: haveATM,
             ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "ATM Card",
                  style: AppFont.buttonText,
                ),
              ),
              const CustomTextField(
                value: "",
                labelText: "Card Number",
              ),
              const Row(
                children: [
                  Expanded(
                      child: CustomTextField(
                    value: "",
                    labelText: "Valid upto",
                  )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: CustomTextField(
                    value: "",
                    labelText: "CVV",
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CheckBoxRow extends StatefulWidget {
  final bool initialCheckValue; // Rename to clarify its purpose
  final String text;

  const CheckBoxRow({Key? key, this.initialCheckValue = false, required this.text}) : super(key: key);

  @override
  State<CheckBoxRow> createState() => _CheckBoxRowState();
}

class _CheckBoxRowState extends State<CheckBoxRow> {
  late bool checkValue; // Declare a mutable checkValue

  @override
  void initState() {
    super.initState();
    checkValue = widget.initialCheckValue; // Initialize checkValue from widget
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.text,
          style: AppFont.textFieldLabelText,
        ),
        Transform.scale(
          scale: 1.5,
          child: Checkbox(
            activeColor: AppColors.secondaryColor,
            value: checkValue,
            onChanged: (val) {
              setState(() {
                checkValue = val ?? false; // Update the local state
              });
            },
          ),
        ),
      ],
    );
  }
}
