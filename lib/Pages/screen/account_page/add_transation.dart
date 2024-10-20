import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/screen/account_page/transactionTab/debt_tab.dart';
import 'package:money_manage_app2/Pages/screen/account_page/transactionTab/income_expense_tab.dart';
import 'package:money_manage_app2/Pages/screen/account_page/transactionTab/transfer_tab.dart';
import 'package:money_manage_app2/Pages/widget/custom_appbar.dart';
import 'package:money_manage_app2/Pages/widget/text_field/amount_text_field.dart';
import 'package:money_manage_app2/constant/app_colors.dart';
import 'package:money_manage_app2/provider/balance_provider.dart';
import 'package:provider/provider.dart';

import '../../widget/button/button.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key}) : super(key: key);

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Add Transaction"),
      body: ChangeNotifierProvider(
        create: (cxt) => BalanceProvider(),
        child: Consumer<BalanceProvider>(builder: (context, data, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
            child: /*data.wallet
                ? Column()
                :*/ Column(
              children: [
                const SizedBox(height: 25),
                AmountTextField(
                  value: data.transactionModel.amount ?? 0,
                  onChange: (val) {
                    data.transactionModel.amount =
                        double.tryParse(val) ?? 0;
                  },
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 310,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TransactionSwitch(
                        icon: Icons.swap_horiz,
                        label: 'Transfer',
                        index: 0,
                        isSelected: selectedIndex == 0,
                        onTap: () {
                          setState(() {
                            selectedIndex = 0;
                            data.transactionModel.transferType =
                            "transfer";
                          });
                        },
                      ),
                      TransactionSwitch(
                        icon: FluentIcons.arrow_square_up_right_24_filled,
                        label: 'Income',
                        index: 1,
                        isSelected: selectedIndex == 1,
                        onTap: () {
                          setState(() {
                            selectedIndex = 1;
                            data.transactionModel.transferType = "income";
                          });
                        },
                      ),
                      TransactionSwitch(
                        icon: FluentIcons.arrow_square_up_right_24_filled,
                        label: 'Expense',
                        index: 2,
                        isSelected: selectedIndex == 2,
                        onTap: () {
                          setState(() {
                            selectedIndex = 2;
                            data.transactionModel.transferType =
                            "expense";
                          });
                        },
                      ),
                      TransactionSwitch(
                        icon: FluentIcons.money_hand_24_filled,
                        label: 'Debt',
                        index: 3,
                        isSelected: selectedIndex == 3,
                        onTap: () {
                          setState(() {
                            selectedIndex = 3;
                            data.transactionModel.transferType = "debt";
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                    child: SingleChildScrollView(
                        child: tabPage(selectedIndex))),
                CustomButton(
                    buttonText: "Transfer",
                    loading: data.isLoading,
                    onPressed: () {
                      // data.getACBalance(data.transactionModel.from, 100, false);

                      data.addTransfer().then((value) {
                        if(value == true){
                         print(value);
                        }
                      });
                    })
              ],
            ),
          );
        }),
      ),
    );
  }
}

class TransactionSwitch extends StatelessWidget {
  final void Function() onTap;
  final IconData icon;
  final String label;
  final int index;
  final bool isSelected;

  const TransactionSwitch({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.label,
    required this.index,
    required this.isSelected,
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
      return const IncomeExpenseTab(isIncome: true,);
    case 2:
      return const IncomeExpenseTab();
    case 3:
      return const DebtTab();
    default:
      return const MoneyTransfer();
  }
}
