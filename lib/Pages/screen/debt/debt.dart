import 'package:cash_crafter/Pages/screen/debt/add_debt.dart';
import 'package:cash_crafter/Pages/widget/button/floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:cash_crafter/Pages/screen/debt/on_dept_tap.dart';
import 'package:cash_crafter/Pages/widget/custom_appbar.dart';
import 'package:cash_crafter/Pages/widget/custom_widget/custom_card.dart';
import 'package:cash_crafter/constant/app_colors.dart';
import 'package:cash_crafter/constant/app_font.dart';
import 'package:cash_crafter/provider/dept_provider.dart';
import 'package:provider/provider.dart';


class DebtPage extends StatelessWidget {
  final bool showBackBtn;

  const DebtPage({Key? key, this.showBackBtn = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showBackBtn: showBackBtn, title: "Debt Page"),
      body: Consumer<DebtProvider>(builder: (context, data, _) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: data.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextAmount(text: "I Lend", amount: data.balanceModel.lend ?? 0),
                          TextAmount(text: "I Owe", amount: data.balanceModel.owe ?? 0),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  /*  const MainLoanCard(),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                        onPressed: () {
                          print(data.debtList);
                        },
                        child: Text("data")),*/
                    Expanded(
                      child: ListView.builder(
                          itemCount: data.debtList.length,
                          itemBuilder: (context, index) {
                            final item = data.debtList[index];

                            return CustomCard(
                                margin: const EdgeInsets.symmetric(vertical: 3),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) => OnDeptTap(
                                                debtData: item,
                                              )));
                                },
                                circularRadius: 10,
                                color: AppColors.primaryColor,
                                child: Row(
                                  children: [
                                    /* CustomCard(
                                        child: Text(
                                      data.getInitials(item.name.toString()),
                                      style: AppFont.white20,
                                    )),*/
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.name?.toString() ?? "",
                                          style: AppFont.textFieldLabel,
                                        ),
                                        Text(
                                          item.phoneNumber?.toString() ?? '',
                                          style: AppFont.cardSubTitle,
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                      children: [
                                        Text(
                                          item.totalAmount?.toString() ?? "0",
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w700,
                                              color: (item.totalAmount ?? 0) < 0
                                                  ? AppColors.negativeColor
                                                  : (item.totalAmount ?? 0) == 0
                                                      ? AppColors.textColor
                                                      : AppColors
                                                          .positiveColor),
                                        )
                                      ],
                                    )
                                  ],
                                ));
                          }),
                    )
                  ],
                ),
        );
      }),
      floatingActionButton: CustomFloatingActionButton(onTap: () {
    Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddDebt(),
          ),
        ).then((val){
          if(val == true){
            Provider.of<DebtProvider>(context, listen: false).getDebtData();
          }
    });

      }),
    );
  }
}
