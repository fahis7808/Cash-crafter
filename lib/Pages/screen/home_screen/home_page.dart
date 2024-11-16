import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/screen/account_page/account_page.dart';
import 'package:money_manage_app2/Pages/screen/profile_page/profile_page.dart';
import 'package:money_manage_app2/Pages/widget/custom_widget/balance_showing_widget.dart';
import 'package:money_manage_app2/constant/app_colors.dart';
import 'package:money_manage_app2/constant/app_font.dart';
import 'package:money_manage_app2/provider/home_provider.dart';
import 'package:provider/provider.dart';
import '../../widget/custom_widget/custom_card.dart';
import '../../widget/graph/graph_chart_2.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => HomeProvider(),
      child: Consumer<HomeProvider>(
        builder: (context,data,_) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfilePage())),
                              child: const CircleAvatar(
                                radius: 25,
                                backgroundColor: AppColors.secondaryColor,
                                child: Icon(Icons.account_circle_outlined,
                                    color: Colors.white, size: 40),
                              ),
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
                            GestureDetector(
                              child: const Icon(
                                Icons.notifications_none_outlined,
                                color: Colors.white,
                                size: 26,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                          onTap: () {
                            data.getData();
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => AccountPage()));
                          },
                          child:  MainBalance(
                            amount: data.balanceData.totalBalance?.toDouble() ?? 0,
                            text: "Total",
                          )),
                      const SizedBox(
                        height: 30,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: IncomeExpenseCard(income: true, amount: 23423),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: IncomeExpenseCard(income: false, amount: 23423),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 350,
                        child:/* LineChartSample2(
                            transList: [])*/LineChartSample1(listData: data.getGraphData(data.transferList)),
                      ),
                      // PieChartCard(
                      //     onTap: () {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => BudgetPage()));
                      //     },
                      //     title: "Monthly Budget",
                      //     spentAmount: 1232,
                      //     totalAmount: 23424),
                      const SizedBox(
                        height: 10,
                      ),
                      // const GoalPart(),
                    ]),
              ),
            ),

          );
        }
      ),
    );
  }

}
