import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/screen/account_page/transactionTab/debt_tab.dart';
import 'package:money_manage_app2/Pages/screen/account_page/transactionTab/income_expense_tab.dart';
import 'package:money_manage_app2/Pages/screen/account_page/transactionTab/transfer_tab.dart';
import 'package:money_manage_app2/Pages/widget/custom_appbar.dart';
import 'package:money_manage_app2/Pages/widget/text_field/amount_text_field.dart';
import 'package:money_manage_app2/constant/app_colors.dart';

import '../../widget/button/button.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key}) : super(key: key);

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Add Transaction"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
        child: Column(
          children: [
            const SizedBox(height: 25),
            const AmountTextField(value: '324'),
            const SizedBox(height: 30),
            SizedBox(
              width: 310,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TransactionSwitch(
                    icon:
                        Icons.swap_horiz,
                    label: 'Transfer',
                    index: 0,
                    isSelected: selectedIndex == 0,
                    // Check if this button is selected
                    onTap: () {
                      setState(() {
                        selectedIndex = 0; // Update selected index
                      });
                    },
                  ),
                  TransactionSwitch(
                    icon: FluentIcons.arrow_square_up_right_24_filled,
                    label: 'Income',
                    index: 1,
                    isSelected: selectedIndex == 1,
                    // Check if this button is selected
                    onTap: () {
                      setState(() {
                        selectedIndex = 1; // Update selected index
                      });
                    },
                  ),
                  TransactionSwitch(
                    icon: FluentIcons.arrow_square_up_right_24_filled,
                    label: 'Expense',
                    index: 2,
                    isSelected: selectedIndex == 2,
                    // Check if this button is selected
                    onTap: () {
                      setState(() {
                        selectedIndex = 2; // Update selected index
                      });
                    },
                  ),
                  TransactionSwitch(
                    icon: FluentIcons.money_hand_24_filled,
                    label: 'Debt',
                    index: 3,
                    isSelected: selectedIndex == 3,
                    // Check if this button is selected
                    onTap: () {
                      setState(() {
                        selectedIndex = 3; // Update selected index
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
             Expanded(child: SingleChildScrollView(child: tabPage(selectedIndex))),
            CustomButton(buttonText: "Transfer", onPressed: () {})
          ],
        ),
      ),
    );
  }
}

class TransactionSwitch extends StatelessWidget {
  final void Function() onTap;
  final IconData icon;
  final String label;
  final int index;
  final bool isSelected; // Pass whether the button is selected

  const TransactionSwitch({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.label,
    required this.index,
    required this.isSelected, // Use this to track selection
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: isSelected ? AppColors.tertiaryColor : AppColors.white,
              // Change color based on selection
              borderRadius: BorderRadius.circular(13),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Transform.rotate(
              angle: index == 1 ? 1.6 : 0,
              child: Icon(
                icon,
                size: 30,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

Widget tabPage(int index) {
  switch (index) {
    case 0:
      return const MoneyTransfer();
    case 1:
      return const IncomeExpenseTab();
    case 2:
      return const IncomeExpenseTab();
    case 3:
      return const DebtTab();default:
      return const MoneyTransfer();
  }
}
