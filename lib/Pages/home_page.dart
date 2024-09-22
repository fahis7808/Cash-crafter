import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/add_transaction_page.dart';
import 'package:money_manage_app2/Pages/widget/pie_chart.dart';
import 'package:money_manage_app2/constant/app_colors.dart';
import 'package:money_manage_app2/constant/app_font.dart';

import 'widget/custom_widget/custom_card.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const TransactionPage(),
              ),
            );
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              10.0,
            ),
          ),
          backgroundColor: const Color(0xFF05376C),
          child: const Icon(
            Icons.add_outlined,
            size: 32.0,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundColor: AppColors.secondaryColor,
                        child: Icon(Icons.account_circle_outlined,
                            color: Colors.white, size: 40),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Fahis ",
                        style: AppFont.buttonText,
                        maxLines: 1,
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.notifications_none_outlined,
                        color: Colors.white,
                        size: 26,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 15, bottom: 10),
                  child: Text(
                    "Total Balance",
                    style: AppFont.cardSubTitle,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "\u{20B9} 79,564",
                    style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                 IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: CustomCard(
                            color1: AppColors.containerColor,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Budget",style: AppFont.buttonText,),

                                  const SizedBox(
                                    height: 200,
                                    child: PieChartSample2(),
                                  ),
                                  Text("\u{20B9} 1200 spent of 15000",style: AppFont.cardSubTitle,)
                                ],
                              ),
                            )),
                      ),
                      const SizedBox(width: 10,),
                      const Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Expanded(
                              child: CustomCard(
                                  color1: AppColors.containerColor,
                                  child: IncomeExpenseCard(
                                      head: "Income", amount: 23423)),
                            ),
                            SizedBox(height: 10),
                            Expanded(
                              child: CustomCard(
                                color1: AppColors.containerColor,
                                child: IncomeExpenseCard(
                                    angle: 3.5, head: "Expense", amount: 23423),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ]),
        ));
  }
}
/* Expanded(
                    flex: 3,
                    child: CustomCard(
                      color1: AppColors.containerColor,
                      color2: const Color(0x800A015D),
                      padding: const EdgeInsets.fromLTRB(15, 15, 10, 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Balance', style: AppFont.cardTitle),
                          const Spacer(),
                          Text('\u{20B9} 79564', style: AppFont.cardMainText),
                          const SizedBox(
                            height: 10,
                          ),
                          const Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text("\u{20B9} 945.00",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF007505))),
                            ],
                          )
                        ],
                      ),
                    ))*/
/* const Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      CustomCard(
                          color1: AppColors.containerColor,
                          child: IncomeExpenseCard(
                              head: "Income", amount: 23423)),
                      SizedBox(height: 10),
                      CustomCard(
                        color1: AppColors.containerColor,
                        child: IncomeExpenseCard(
                            angle: 3.5, head: "Expense", amount: 23423),
                      ),
                    ],
                  ),
                )*/
