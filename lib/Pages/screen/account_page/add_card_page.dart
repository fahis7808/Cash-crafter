import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/widget/button/button.dart';
import 'package:money_manage_app2/Pages/widget/custom_appbar.dart';
import 'package:money_manage_app2/Pages/widget/text_field/custom_drop_down_field.dart';
import 'package:money_manage_app2/Pages/widget/text_field/custom_text_field.dart';
import 'package:money_manage_app2/Pages/widget/text_field/date_field.dart';
import 'package:money_manage_app2/constant/app_colors.dart';
import 'package:money_manage_app2/constant/app_font.dart';

class AddAccountPage extends StatelessWidget {
  const AddAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Add Card"),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
              const CheckBoxRow(
                text: "Have Debit Card",
                initialCheckValue: true,
                children: [
                  CustomTextField(
                    value: "",
                    labelText: "Card Number",
                  ),
                  Row(
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
              const CheckBoxRow(
                text: "Have Credit Card",
                initialCheckValue: false,
                children: [
                  CustomTextField(
                    value: "",
                    labelText: "Card Number",
                  ),
                  Row(
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
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          value: "",
                          labelText: "Monthly Limit",
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: CustomDateField(
                        labelText: "Payment Date",
                      )),
                    ],
                  )
                ],
              ),
              SizedBox(height: 10,),
              CustomButton(buttonText: "Save", onPressed: (){})
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
  final List<Widget> children;

  const CheckBoxRow(
      {Key? key,
      this.initialCheckValue = false,
      required this.text,
      required this.children})
      : super(key: key);

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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                widget.text,
                style: AppFont.textFieldLabelText,
              ),
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
        ),
        if (checkValue)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.children,
          )
      ],
    );
  }
}
