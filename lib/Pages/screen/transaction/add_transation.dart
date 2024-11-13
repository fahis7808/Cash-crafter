import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/screen/transaction/transactionTab/add_loan_tab.dart';
import 'package:money_manage_app2/Pages/widget/custom_appbar.dart';
import 'package:money_manage_app2/Pages/widget/text_field/amount_text_field.dart';
import 'package:money_manage_app2/constant/app_colors.dart';
import 'package:money_manage_app2/provider/balance_provider.dart';
import 'package:provider/provider.dart';

import '../../../util/snack_bar.dart';
import '../../widget/button/button.dart';
import 'transactionTab/debt_tab.dart';
import 'transactionTab/income_expense_tab.dart';
import 'transactionTab/transfer_tab.dart';

class AddTransaction extends StatefulWidget {
  final bool isDebt;
  const AddTransaction({Key? key,  this.isDebt = false}) : super(key: key);

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  int selectedIndex = 0;

  @override
  void initState() {
    selectedIndex = widget.isDebt ? 3 :0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Add Transaction"),
      body: ChangeNotifierProvider(
        create: (cxt) => BalanceProvider(selectedIndex: selectedIndex),
        child: Consumer<BalanceProvider>(builder: (context, data, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
            child: data.isLoading
                ? Center(child: CircularProgressIndicator())
                : Column(
              children: [
                const SizedBox(height: 15),
                AmountTextField(
                  value: data.transactionModel.amount,
                  onChange: (val) {
                    data.transactionModel.amount =
                        double.tryParse(val) ?? 0;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 310,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if(!widget.isDebt)
                      TransactionSwitch(
                        icon: Icons.swap_horiz,
                        label: 'Transfer',
                        index: 0,
                        isSelected: selectedIndex == 0,
                        onTap: () {
                          setState(() {
                            selectedIndex = 0;
                            data.transactionModel.transactionType =
                            "transfer";
                          });
                        },
                      ),
                      if(!widget.isDebt)
                      TransactionSwitch(
                        icon: FluentIcons.arrow_square_up_right_24_filled,
                        label: 'Income',
                        index: 1,
                        isSelected: selectedIndex == 1,
                        onTap: () {
                          setState(() {
                            selectedIndex = 1;
                            data.transactionModel.transactionType = "income";
                            data.transactionModel.debit = null;
                          });
                        },
                      ),
                      if(!widget.isDebt)
                      TransactionSwitch(
                        icon: FluentIcons.arrow_square_up_right_24_filled,
                        label: 'Expense',
                        index: 2,
                        isSelected: selectedIndex == 2,
                        onTap: () {
                          setState(() {
                            selectedIndex = 2;
                            data.transactionModel.transactionType =
                            "expense";
                            data.transactionModel.credit = null;
                          });
                        },
                      ),
                      if(widget.isDebt)
                      TransactionSwitch(
                        icon: FluentIcons.money_hand_24_filled,
                        label: 'Debt',
                        index: 3,
                        isSelected: selectedIndex == 3,
                        onTap: () {
                          setState(() {
                            selectedIndex = 3;
                            data.transactionModel.transactionType = "debt";
                          });
                        },
                      ),
                      if(widget.isDebt)
                      TransactionSwitch(
                        icon: FluentIcons.building_retail_money_20_regular,
                        label: 'Loan',
                        index: 3,
                        isSelected: selectedIndex == 4,
                        onTap: () {
                          setState(() {
                            selectedIndex = 4;
                            data.transactionModel.transactionType = "debt";
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
                    loading: data.isBtnLoading,
                    onPressed: () {
                      data.addTransfer(selectedIndex).then((value) {
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
    case 4:
      return const AddLoanTab();
    default:
      return const MoneyTransfer();
  }
}