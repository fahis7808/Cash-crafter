import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/widget/custom_appbar.dart';
import 'package:money_manage_app2/Pages/widget/text_field/amount_text_field.dart';
import 'package:money_manage_app2/constant/app_colors.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key}) : super(key: key);

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  int selectedIndex = -1; // Initialize with no button selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Add Transaction"),
      body: Column(
        children: [
          const AmountTextField(value: '324'),
          const SizedBox(height: 40),
          SizedBox(
            width: 310,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TransactionSwitch(
                  icon: Icons.swap_horiz,
                  label: 'Transfer',
                  index: 0,
                  isSelected: selectedIndex == 0, // Check if this button is selected
                  onTap: () {
                    setState(() {
                      selectedIndex = 0; // Update selected index
                    });
                  },
                ),
                TransactionSwitch(
                  icon: Icons.attach_money,
                  label: 'Income',
                  index: 1,
                  isSelected: selectedIndex == 1, // Check if this button is selected
                  onTap: () {
                    setState(() {
                      selectedIndex = 1; // Update selected index
                    });
                  },
                ),
                TransactionSwitch(
                  icon: Icons.money_off,
                  label: 'Expense',
                  index: 2,
                  isSelected: selectedIndex == 2, // Check if this button is selected
                  onTap: () {
                    setState(() {
                      selectedIndex = 2; // Update selected index
                    });
                  },
                ),
                TransactionSwitch(
                  icon: Icons.warning,
                  label: 'Debt',
                  index: 3,
                  isSelected: selectedIndex == 3, // Check if this button is selected
                  onTap: () {
                    setState(() {
                      selectedIndex = 3; // Update selected index
                    });
                  },
                ),
              ],
            ),

          ),
        ],
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
              color: isSelected ? AppColors.tertiaryColor : AppColors.cardColor, // Change color based on selection
              borderRadius: BorderRadius.circular(13),
            ),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Icon(
              icon,
              size: 40,
              color: Colors.white,
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
