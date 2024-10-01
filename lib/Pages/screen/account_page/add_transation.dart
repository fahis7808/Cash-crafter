import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/widget/custom_appbar.dart';
import 'package:money_manage_app2/Pages/widget/text_field/amount_text_field.dart';
import 'package:money_manage_app2/constant/app_colors.dart';

class AddTransaction extends StatelessWidget {
  const AddTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Add Transaction"),
      body: Column(
        children: [
          const AmountTextField(value: '324'),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            width: 310,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TransactionSwitch(
                  icon: Icons.swap_horiz,
                  label: 'Transfer',
                  onTap: () => print('Transfer'),
                ),
                TransactionSwitch(
                  icon: Icons.attach_money,
                  label: 'Income',
                  onTap: () => print('Income'),
                ),
                TransactionSwitch(
                  icon: Icons.money_off,
                  label: 'Expense',
                  onTap: () => print('Expense'),
                ),
                TransactionSwitch(
                  icon: Icons.warning,
                  label: 'Debt',
                  onTap: () => print('Debt'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TransactionSwitch extends StatefulWidget {
  final void Function() onTap;
  final IconData icon;
  final String label;

  const TransactionSwitch(
      {Key? key, required this.onTap, required this.icon, required this.label})
      : super(key: key);
  @override
  State<TransactionSwitch> createState() => _TransactionSwitchState();
}

int selectedIndex = 1;

class _TransactionSwitchState extends State<TransactionSwitch> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.cardColor,
              borderRadius: BorderRadius.circular(13),
            ),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Icon(
              widget.icon,
              size: 40,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            widget.label,
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
