import 'package:cash_crafter/Model/account_model/account_model.dart';
import 'package:cash_crafter/Pages/widget/custom_appbar.dart';
import 'package:cash_crafter/provider/dept_provider.dart';
import 'package:cash_crafter/util/snack_bar.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../constant/app_colors.dart';
import '../../../constant/app_font.dart';
import '../../../provider/balance_provider.dart';
import '../../widget/button/button.dart';
import '../../widget/text_field/amount_text_field.dart';
import '../../widget/text_field/contact_textfield.dart';
import '../../widget/text_field/custom_drop_down_field.dart';
import '../../widget/text_field/custom_text_field.dart';
import '../../widget/text_field/date_field.dart';
import '../transaction/add_transation.dart';

class AddDebt extends StatelessWidget {
  const AddDebt({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Add Debt"),
      body: Consumer<DebtProvider>(builder: (context, provider, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: provider.formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  Align(
                    alignment: Alignment.center,
                    child: AmountTextField(
                      value: provider.transactionModel.amount,
                      onChange: (val) {
                        provider.transactionModel.amount =
                            double.tryParse(val) ?? 0;
                      },
                      validator: (val) {
                        if (val == null || val.isEmpty || val == 0.0)
                          return 'Amount required';
                        if (double.tryParse(val) == null)
                          return 'Enter a valid amount';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  TransactionSwitch(
                    icon: FluentIcons.money_hand_24_filled,
                    label: 'Debt',
                    index: 3,
                    isSelected: true,
                    onTap: () {},
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _DebtSwitch(
                        isSelected: provider.transactionModel.debtType == 0,
                        onTap: () {
                          provider.transactionModel.debtType = 0;
                          provider.onRefresh();
                        },
                        label: "I Lend",
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      _DebtSwitch(
                        isSelected: provider.transactionModel.debtType == 1,
                        onTap: () {
                          provider.transactionModel.debtType = 1;
                          provider.onRefresh();
                        },
                        label: "I Own",
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ContactField(
                    hintText: provider.transactionModel.debtType == 0
                        ? "To Whom"
                        : "From Whom",
                    contact: provider.contact.toList(),
                    onChanged: (val) {
                      provider.debtModel.name = val;
                    },
                    onSelected: (Contact selection) {
                      // provider.contactData = selection;
                      print(selection.id);
                      provider.debtModel.name =
                          selection.displayName.toString();
                      String number = provider
                          .formatPhoneNumber(selection.phones.first.number);
                      provider.debtModel.phoneNumber = number;
                      provider.debtModel.contactId = selection.id;
                      provider.onRefresh();
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    value: provider.debtModel.phoneNumber ?? "",
                    labelText: "Phone Number",
                    onChanged: (val) {
                      provider.debtModel.phoneNumber = val;
                    },
                    validator: (val) {
                      if (val == null || val.isEmpty)
                        return 'Phone number required';
                      if (val.length != 10)
                        return 'Enter a valid 10-digit number';
                      return null;
                    },
                  ),
                  Consumer<BalanceProvider>(
                      builder: (context, balanceProvider, _) {
                    return CustomDropdownField<String>(
                      items: balanceProvider.accountList.map((e) {
                        return e.accountName.toString();
                      }).toList(),
                      onChanged: (val) {
                        provider.transactionModel.debtType == 0
                            ? provider.transactionModel.debit = val
                            : provider.transactionModel.credit = val;
                      },
                      value: provider.transactionModel.debtType == 0
                          ? provider.transactionModel.debit
                          : provider.transactionModel.credit,
                      labelText: "Account",
                      validator: (val) {
                        AccountModel acc = balanceProvider.accountList.firstWhere(
                          (element) => element.accountName == val,
                          orElse: () => AccountModel(),
                        );
                        if (val == null || val.isEmpty)
                          return 'Account required';
                        if(acc.balance! <  (provider.transactionModel.amount ?? 0)) {
                          return 'Insufficient balance in $val';
                        }
                        return null;
                      },
                      // prefixIcon: FluentIcons.building_bank_16_filled,
                    );
                  }),
                  CustomDateField(
                    labelText: "Date",
                    // prefixIcon: FluentIcons.calendar_3_day_16_filled,
                    onDateSelected: (val) {
                      provider.transactionModel.date =
                          DateFormat('dd-MM-yyyy').format(val);
                    },
                  ),
                  CustomTextField(
                      value: provider.transactionModel.note,
                      labelText: "Comment",
                      // prefixIcon: FluentIcons.comment_note_20_filled,
                      onChanged: (val) {
                        provider.transactionModel.note = val;
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      buttonText: "Transfer",
                      loading: provider.isBtnLoading,
                      onPressed: () {
                        if (provider.formKey.currentState?.validate() ??
                            false) {
                          provider.saveToDB().then((value) {
                            if (value == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  CustomSnackBar.successesSnackBar(
                                      "Successfully added your debt"));
                              Navigator.pop(context, true);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Something went wrong"),
                                ),
                              );
                            }
                          });
                        }
                      }),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
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
