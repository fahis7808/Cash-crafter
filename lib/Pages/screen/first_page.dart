import 'package:cash_crafter/Pages/screen/credit_card/credit_card.dart';
import 'package:cash_crafter/provider/balance_provider.dart';
import 'package:cash_crafter/provider/dept_provider.dart';
import 'package:cash_crafter/provider/home_provider.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:cash_crafter/Pages/screen/account_page/account_page.dart';
import 'package:cash_crafter/Pages/screen/budget/budge_add_page.dart';
import 'package:cash_crafter/Pages/screen/budget/budget_page.dart';
import 'package:cash_crafter/Pages/screen/debt/debt.dart';
import 'package:cash_crafter/Pages/screen/home_screen/home_page.dart';
import 'package:cash_crafter/Pages/screen/transaction/add_transation.dart';
import 'package:provider/provider.dart';

import '../../constant/app_colors.dart';
import '../widget/button/floating_action_button.dart';
import '../widget/custom_widget/custom_card.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  int pageIndex = 4;
  final page = [
    const HomePage(),
    const AccountPage(showBackBtn: false),
    const BudgetPage(showBackBtn: false),
    const DebtPage(showBackBtn: false),
    const CreditCard(),
  ];
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final balanceProvider =
        Provider.of<BalanceProvider>(context, listen: false);
    return Scaffold(
      floatingActionButton: pageIndex == 3 || pageIndex == 2
          ? null
          : CustomFloatingActionButton(
              onTap: () async {
                bool? needRefresh = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  if (pageIndex == 2) {
                    return AddBudgetPage();
                  } else if (pageIndex == 3) {
                    return AddTransaction(
                      isDebt: true,
                    );
                  } else {
                    return AddTransaction();
                  }
                }));
                if (needRefresh == true) {
                  if (pageIndex == 0) {
                    Provider.of<HomeProvider>(context, listen: false).getData();
                  } else if (pageIndex == 1) {
                    balanceProvider.getData(0);
                  }
                }
              },
            ),
      body: page[pageIndex],
      bottomNavigationBar: CustomCard(
          height: 75,
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              bottomItem(
                  icon: FluentIcons.home_28_regular,
                  text: "Home",
                  onTap: () {
                    setState(() {
                      pageIndex = 0;
                      Provider.of<HomeProvider>(context, listen: false)
                          .getData();
                    });
                  },
                  isSelected: pageIndex == 0),
              bottomItem(
                  icon: FluentIcons.person_24_regular,
                  text: "Account",
                  onTap: () {
                    setState(() {
                      pageIndex = 1;
                      balanceProvider.getData(1);
                    });
                  },
                  isSelected: pageIndex == 1),
              bottomItem(
                  icon: FluentIcons.card_ui_20_regular,
                  text: "Card",
                  onTap: () {
                    setState(() {
                      pageIndex = 4;
                      balanceProvider.getData(1);
                    });
                  },
                  isSelected: pageIndex == 4),

              bottomItem(
                  icon: FluentIcons.toolbox_24_regular,
                  text: "Budget",
                  onTap: () {
                    setState(() {
                      pageIndex = 2;
                      balanceProvider.getData(2);
                    });
                  },
                  isSelected: pageIndex == 2),
              bottomItem(
                  icon: FluentIcons.money_hand_24_regular,
                  text: "Debt",
                  onTap: () {
                    setState(() {
                      pageIndex = 3;
                      Provider.of<DebtProvider>(context, listen: false)
                          .getDebtData();
                    });
                  },
                  isSelected: pageIndex == 3),
            ],
          )),
    );
  }

  Widget bottomItem(
      {required IconData icon,
      required String text,
      required VoidCallback onTap,
      required bool isSelected}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            color: isSelected ? AppColors.white : AppColors.cardColor,
            size: 35,
          ),
          Text(
            text,
            style: TextStyle(
                fontSize: 15,
                color: isSelected ? AppColors.white : AppColors.colour2,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
