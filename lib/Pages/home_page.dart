import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manage_app2/Pages/add_transaction_page.dart';
import 'package:money_manage_app2/Widgets/incomeandexpance_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:money_manage_app2/Model/db_model.dart';
import 'package:money_manage_app2/Widgets/snackbar_info.dart';
import 'package:money_manage_app2/Widgets/transaction_model.dart';

import '../Widgets/show_confirm_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  late Box box;
  DbHelper dbHelper = DbHelper();
  Map? data;
  int totalBalance = 0;
  int totalIncome = 0;
  int totalExpense = 0;
  List<FlSpot> dataSet = [];
  DateTime today = DateTime.now();


  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  @override
  void initState() {
    super.initState();
    box = Hive.box('cash');
  }

  Future<List<TransactionModel>> fetch() async {
    if (box.values.isEmpty) {
      return Future.value([]);
    } else {
      List<TransactionModel> items = [];
      box.toMap().values.forEach((element) {
        items.add(
          TransactionModel(
            element['amount']
            ,
            element['note'],
            element['date'] ,
            element['type'],
          ),
        );
      });
      return items;
    }
  }

  List<FlSpot> getPlotPoints(List<TransactionModel> entireData) {
    dataSet = [];
    List tempdataSet = [];

    for (TransactionModel item in entireData) {
      if (item.date.month == today.month && item.type == "Expense") {
        tempdataSet.add(item);
      }
    }
    tempdataSet.sort((a, b) => a.date.day.compareTo(b.date.day));
    for (var i = 0; i < tempdataSet.length; i++) {
      dataSet.add(
        FlSpot(
          tempdataSet[i].date.day.toDouble(),
          tempdataSet[i].amount.toDouble(),
        ),
      );
    }
    return dataSet;
  }

  getTotalBalance(List<TransactionModel> entireData) {
    totalBalance = 0;
    totalIncome = 0;
    totalExpense = 0;
    for (TransactionModel data in entireData) {
      if (data.date.month == today.month) {
        if (data.type == "Income") {
          totalBalance += data.amount;
          totalIncome += data.amount;
        } else {
          totalBalance -= data.amount;
          totalExpense += data.amount;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF05376C),
        toolbarHeight: 0.0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(CupertinoPageRoute(
            builder: (context) => const TransactionPage(),
          ),
          )
            .then((value) {
                setState(() {});
                 });
              },

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            16.0,
          ),
        ),
        backgroundColor: const Color(0xFF05376C),
        child: const Icon(
          Icons.add_outlined,
          size: 32.0,
        ),
      ),
      body: FutureBuilder<List<TransactionModel>>(
        future: fetch(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Oopssss !!! There is some error !",
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
            );
          }
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  "You haven't added Any Data !",
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
              );
            }
            getTotalBalance(snapshot.data!);
            getPlotPoints(snapshot.data!);

            return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(
                      12.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: 200.0,
                          child: Text(
                            "Welcome ! ",
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF05376C),
                            ),
                            maxLines: 1,
                          ),
                        )
                      ],
                    ),
                  ),


                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.9,
                    margin: const EdgeInsets.all(
                      12.0,
                    ),
                    child: Ink(
                      decoration: const BoxDecoration(
                        color: Color(0xFF05376C),
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            24.0,
                          ),
                        ),
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              24.0,
                            ),
                          ),
                        ),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                          vertical: 18.0,
                          horizontal: 8.0,
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Total Balance',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            Text(
                              'Rs $totalBalance',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 36.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  IncomeExpanceCard(value:  totalIncome.toString(),
                                    text: "Income",
                                    iconData: Icons.arrow_downward,
                                    iconcColor: Colors.green,),
                                  IncomeExpanceCard(value: totalExpense.toString(),
                                    text: "Expance",
                                    iconData: Icons.arrow_upward,
                                    iconcColor: Colors.red,),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  dataSet.isEmpty || dataSet.length < 2
                      ? Container(
                           padding: const EdgeInsets.symmetric(
                           vertical: 40.0,
                            horizontal: 20.0,
                           ),
                          margin: const EdgeInsets.all(
                          12.0,
                         ),
                           decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                            8.0,
                         ),
                            color: Colors.white,
                            boxShadow: [
                               BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                   spreadRadius: 5,
                                  blurRadius: 7,
                                  offset:
                                   const Offset(0, 3), // changes position of shadow
                               ),
                            ],
                           ),
                          child: const Text(
                               "Not Enough Data to render Chart",
                                 style: TextStyle(
                                 fontSize: 20.0,
                                 ),
                          ),
                       )


                      : Container(
                          height: 400.0,
                          padding: const EdgeInsets.symmetric(
                             vertical: 40.0,
                             horizontal: 12.0,
                          ),
                           margin: const EdgeInsets.all(
                                12.0,
                          ),
                            decoration: BoxDecoration(
                               color: Colors.white,
                               borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                   topRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                               ),
                                 boxShadow: [
                                     BoxShadow(
                                       color: Colors.grey.withOpacity(0.5),
                                       spreadRadius: 5,
                                       blurRadius: 7,
                                       offset:
                                       const Offset(0, 3), // changes position of shadow
                                     ),
                                  ],
                               ),
                            child: LineChart(
                                LineChartData(
                                    borderData: FlBorderData(
                                        show: false,
                                     ),
                                    lineBarsData: [
                                         LineChartBarData(
                                             spots: getPlotPoints(snapshot.data!),
                                             isCurved: false,
                                              barWidth: 2.5,
                                              color: const Color(0xFF05376C),
                                              showingIndicators: [200, 200, 90, 10],
                                              dotData: FlDotData(
                                                     show: true,
                                                 ),
                                          ),
                                        ],
                                   ),
                           ),
                      ),

                   const Padding(
                      padding: EdgeInsets.all(12.0),
                     child: Text(
                      "Recent Transactions",
                      style: TextStyle(
                        fontSize: 32.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length + 1,
                    itemBuilder: (context, index) {
                      TransactionModel dataAtIndex;
                      try {
                        dataAtIndex = snapshot.data![index];
                      } catch (e) {
                        return Container();
                      }

                      if (dataAtIndex.date.month == today.month) {
                        if (dataAtIndex.type == "Income") {
                          return incomeTile(
                            dataAtIndex.amount,
                            dataAtIndex.note,
                            dataAtIndex.date,
                            index,
                          );
                        } else {
                          return expenseTile(
                            dataAtIndex.amount,
                            dataAtIndex.note,
                            dataAtIndex.date,
                            index,
                          );
                        }
                      } else {
                        return Container();
                      }
                    },
                  ),

                ]
            );
          } else {
            return const Text(
              "Loading...",
            );
          }
        },
      ),
    );
  }


  Widget expenseTile(int value, String note, DateTime date, int index) {
    return InkWell(
      splashColor: Colors.teal,
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          deleteInfoSnackBar,
        );
      },
      onLongPress: () async {
        bool? answer = await showConfirmDialog(
          context,
          "WARNING",
          "This will delete this record. This action is irreversible. Do you want to continue ?",
        );
        if (answer != null && answer) {
          await dbHelper.deleteData(index);
          setState(() {});
        }
      },
      child: Container(
        padding: const EdgeInsets.all(18.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: const Color(0xffced4eb),
          borderRadius: BorderRadius.circular(
            8.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_circle_up_outlined,
                          size: 28.0,
                          color: Colors.red[700],
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        const Text(
                          "Expense",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),

                    //
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        "${date.day} ${months[date.month - 1]} ",
                        style: TextStyle(
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "- $value",
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    //
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        note,
                        style: TextStyle(
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget incomeTile(int value, String note, DateTime date, int index) {
    return InkWell(
      splashColor: Colors.teal,
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          deleteInfoSnackBar,
        );
      },
      onLongPress: () async {
        bool? answer = await showConfirmDialog(
          context,
          "WARNING",
          "This will delete this record. This action is irreversible. Do you want to continue ?",
        );

        if (answer != null && answer) {
          await dbHelper.deleteData(index);
          setState(() {});
        }
      },
      child: Container(
        padding: const EdgeInsets.all(18.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: const Color(0xffced4eb),
          borderRadius: BorderRadius.circular(
            8.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.arrow_circle_down_outlined,
                      size: 28.0,
                      color: Colors.green[700],
                    ),
                    const SizedBox(
                      width: 4.0,
                    ),
                    const Text(
                      "Credit",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
                //
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    "${date.day} ${months[date.month - 1]} ",
                    style: TextStyle(
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                //
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "+ $value",
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                //
                //
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    note,
                    style: TextStyle(
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}