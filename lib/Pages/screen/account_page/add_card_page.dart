import 'package:flutter/material.dart';
import 'package:cash_crafter/Pages/widget/button/button.dart';
import 'package:cash_crafter/Pages/widget/custom_appbar.dart';
import 'package:cash_crafter/Pages/widget/text_field/custom_drop_down_field.dart';
import 'package:cash_crafter/Pages/widget/text_field/custom_text_field.dart';
import 'package:cash_crafter/Pages/widget/text_field/date_field.dart';
import 'package:cash_crafter/constant/app_colors.dart';
import 'package:cash_crafter/constant/app_font.dart';
import 'package:cash_crafter/provider/balance_provider.dart';
import 'package:provider/provider.dart';

import '../../../util/snack_bar.dart';

class AddAccountPage extends StatelessWidget {
  const AddAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BalanceProvider(),
      child: Consumer<BalanceProvider>(builder: (context, data, _) {
        return Scaffold(
          appBar: const CustomAppBar(title: "Add Card"),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    value: data.accModel.accountName,
                    labelText: "Account Name",
                    keyboardType: TextInputType.name,
                    onChanged: (val) {
                      data.accModel.accountName = val;
                    },
                  ),
                  CustomTextField(
                    value: data.accModel.bankName,
                    labelText: "Bank Name",
                    onChanged: (val) {
                      data.accModel.bankName = val;
                    },
                  ),
                  CustomTextField(
                    value: data.accModel.accountNumber,
                    labelText: "Account Number",
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      data.accModel.accountNumber = val;
                    },
                  ),
                  CustomTextField(
                    value: data.accModel.balance?.toString() ?? "",
                    labelText: "Current Balance",
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      data.accModel.balance = double.tryParse(val) ?? 0;
                    },
                  ),
                  CustomDropdownField(
                      items: const ["Salary", "Savings", "Current"],
                      labelText: "Account Type",
                      onChanged: (val) {
                        data.accModel.accountType = val;
                      },
                      value: data.accModel.accountType),
                  CheckBoxRow(
                    text: "Have Debit Card",
                    initialCheckValue: data.accModel.debitCard ?? false,
                    children: [
                      CustomTextField(
                        value: data.accModel.debitCardNumber?.toString() ?? "",
                        labelText: "Card Number",
                        keyboardType: TextInputType.number,
                        onChanged: (val) {
                          data.accModel.debitCardNumber =
                              double.tryParse(val) ?? 0;
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: CustomTextField(
                            value: data.accModel.debitValidUpTo,
                            labelText: "Valid upto",
                            onChanged: (val) {
                              data.accModel.debitValidUpTo = val;
                            },
                          )),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: CustomTextField(
                            value: data.accModel.debitCVV?.toString() ?? '',
                            labelText: "CVV",
                            onChanged: (val) {
                              data.accModel.debitCVV =
                                  double.tryParse(val) ?? 0;
                            },
                          )),
                        ],
                      )
                    ],
                  ),
                  CheckBoxRow(
                    text: "Have Credit Card",
                    initialCheckValue: data.accModel.creditCard ?? false,
                    children: [
                      CustomTextField(
                        value: data.accModel.creditCardNumber?.toString() ?? "",
                        labelText: "Card Number",
                        keyboardType: TextInputType.number,
                        onChanged: (val) {
                          data.accModel.creditCardNumber =
                              double.tryParse(val) ?? 0;
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: CustomTextField(
                            value: data.accModel.creditValidUpTo,
                            labelText: "Valid upto",
                            onChanged: (val) {
                              data.accModel.creditValidUpTo = val;
                            },
                          )),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: CustomTextField(
                            value: data.accModel.creditCVV.toString(),
                            labelText: "CVV",
                            onChanged: (val) {
                              data.accModel.creditCVV =
                                  double.tryParse(val) ?? 0;
                            },
                          )),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              value: data.accModel.creditLimit?.toString() ?? "",
                              labelText: "Monthly Limit",
                              keyboardType: TextInputType.number,
                              onChanged: (val) {
                                data.accModel.creditLimit =
                                    double.tryParse(val) ?? 0.0;
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: CustomDateField(
                            labelText: "Due Date",
                            onDateSelected: (val) {
                              data.accModel.creditDueDate = val;
                            },
                          )),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                      loading: data.isLoading,
                      buttonText: "Save", onPressed: () {
                    data.editWallet().then((value) {
                      if(value == true){
                        final snackBar = CustomSnackBar.successesSnackBar(
                          "Successfully added your account",
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.pop(context);
                      }else{
                        final snackBar = CustomSnackBar.errorSnackBar(
                          "Something went wrong",
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    });
                  })
                ],
              ),
            ),
          ),
        );
      }),
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
