import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manage_app2/Pages/add_transaction_page.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:money_manage_app2/Model/db_model.dart';
import 'package:money_manage_app2/Widgets/snackbar_info.dart';
import 'package:money_manage_app2/Widgets/transaction_model.dart';
import 'package:money_manage_app2/constant/app_colors.dart';
import 'package:money_manage_app2/constant/app_font.dart';

import '../Widgets/show_confirm_dialog.dart';
import 'widget/custom_widget/custom_card.dart';

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
            element['amount'],
            element['note'],
            element['date'],
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(
              MaterialPageRoute(
                builder: (context) => const TransactionPage(),
              ),
            )
                .then((value) {
              setState(() {});
            });
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
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(
                12.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Fahis ",
                    style: AppFont.buttonText,
                    maxLines: 1,
                  ),
                  const CircleAvatar(
                    backgroundColor: AppColors.secondaryColor,
                    child: Icon(Icons.account_circle_outlined,color: Colors.white,size: 30),
                  )
                ],
              ),
            ),
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                      flex: 3,
                      child: CustomCard(
                        color1: const Color(0x24EAEAEA),
                        color2: const Color(0x800A015D),
                        padding: const EdgeInsets.fromLTRB(15, 15, 10, 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Balance', style: AppFont.cardTitle),
                            const Spacer(),
                            Text('\u{20B9} 79564', style: AppFont.cardMainText),
                            const SizedBox(height: 10,),
                            const Row(
                              children: [
                                SizedBox(width: 10,),
                                Text("\u{20B9} 945.00",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF007505))),
                              ],
                            )
                          ],
                        ),
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        CustomCard(
                          color1: const Color(0x24EAEAEA),
                          // color2: Color(0x80004212),
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              // Center content vertically
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Income",
                                      style: AppFont.cardTitle,
                                    ),
                                    Container(
                                      width: 35,
                                      height: 35,
                                      decoration: const BoxDecoration(
                                          color: AppColors.primaryColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      child: const Icon(
                                        Icons.arrow_outward,
                                        // Use the appropriate icon
                                        color: Colors.white, // Icon color
                                        size: 20, // Icon size
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  '\u{20B9} 6253',
                                  textAlign: TextAlign.center,
                                  style: AppFont.subCardMainText,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        CustomCard(
                          color1: const Color(0x24EAEAEA),
                          // color2: Color(0x79490000),
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              // Center content vertically
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Expense",
                                      style: AppFont.cardTitle,
                                    ),
                                    Container(
                                      width: 35,
                                      height: 35,
                                      decoration: const BoxDecoration(
                                          color: AppColors.primaryColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      child: const Icon(
                                        Icons.arrow_outward,
                                        // Use the appropriate icon
                                        color: Colors.white, // Icon color
                                        size: 20, // Icon size
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  '\u{20B9} 6253',
                                  textAlign: TextAlign.center,
                                  style: AppFont.subCardMainText,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ]),
        ));
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
