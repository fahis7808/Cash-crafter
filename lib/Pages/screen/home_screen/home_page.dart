import 'package:flutter/material.dart';
import 'package:cash_crafter/Pages/screen/profile_page/profile_page.dart';
import 'package:cash_crafter/Pages/widget/custom_widget/balance_showing_widget.dart';
import 'package:cash_crafter/constant/app_colors.dart';
import 'package:cash_crafter/constant/app_font.dart';
import 'package:cash_crafter/provider/home_provider.dart';
import 'package:provider/provider.dart';
import '../../widget/custom_widget/custom_card.dart';
import '../../widget/graph/graph_chart_2.dart';
import '../account_page/account_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => HomeProvider(),
      child: Consumer<HomeProvider>(builder: (context, data, _) {
        final Map<String, dynamic> graph = data.getGraphData(data.transferList);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
            child:data.isLoading ? const Center(child: CircularProgressIndicator()) : SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AccountPage()));
                        },
                        child: MainBalance(
                          amount:
                              data.balanceData.totalBalance?.toDouble() ?? 0,
                          text: "Total",
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: IncomeExpenseCard(
                                income: true, amount: data.income),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: IncomeExpenseCard(
                                income: false, amount: data.expense),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                      SizedBox(
                        height: 350,
                        child: (graph["data"] as List).length > 5
                            ? LineChartSample1(listData: graph)
                            : null,
                      ),
                    // const GoalPart(),
                  ]),
            ),
          ),
        );
      }),
    );
  }
}
