import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:money_manage_app2/Model/account_model/balance_model.dart';
import 'package:money_manage_app2/Model/account_model/transaction_model.dart';
import 'package:money_manage_app2/util/collection_reference.dart';

class HomeProvider extends ChangeNotifier {
  BalanceModel balanceData = BalanceModel();
  List<TransactionModel> transferList = [];

  HomeProvider() {
    getData();
  }

  getData() async {
    print("<<<<<<<<<<<object>>>>>>>>>>>");
    try {
      QuerySnapshot data = await CollectionReferenceData.accountDetails.get();
      Map<String, dynamic> accountMap =
          data.docs.first.data() as Map<String, dynamic>;
      balanceData = BalanceModel.fromMap(accountMap);
      print(balanceData.totalBalance);

      QuerySnapshot transfer = await CollectionReferenceData.transaction.get();
      transferList = transfer.docs.map((e) {
        return TransactionModel.fromMap(e.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print(e);
    }
  }

  Map<String, List<dynamic>> getGraphData(List<TransactionModel> dataList) {
    Map<String, double> dailyIncomeSums = {};
    Map<String, double> dailyExpenseSums = {};

    for (var e in dataList) {
      String dateKey = e.date.toString().split(' ')[0]; // Extract date as key
      double amount = e.amount?.toDouble() ?? 0;

      if (e.transactionType == "income") {
        dailyIncomeSums[dateKey] = (dailyIncomeSums[dateKey] ?? 0) + amount;
      } else if (e.transactionType == "expense") {
        dailyExpenseSums[dateKey] = (dailyExpenseSums[dateKey] ?? 0) + amount;
      }
    }

    List<double> incomeList = dailyIncomeSums.values.toList();
    List<double> expenseList = dailyExpenseSums.values.toList();
    List<String> yData = [];

    Set<String> allDates = {...dailyIncomeSums.keys, ...dailyExpenseSums.keys};
    for (String date in allDates) {
      double income = dailyIncomeSums[date] ?? 0;
      double expense = dailyExpenseSums[date] ?? 0;

      DateTime parsedDate = parseDate(date);
      // print(parsedDate);
      String formattedDate =
          "${parsedDate.day.toString().padLeft(2, '0')}/${parsedDate.month.toString().padLeft(2, '0')}";

      if (income >= expense) {
        yData.add(formattedDate);
      } else {
        yData.add(formattedDate);
      }
    }

    print(dailyIncomeSums);
    print(dailyExpenseSums);
    print(yData);

    return {"income": incomeList, "expense": expenseList, "yData": yData};
  }

  DateTime parseDate(String date) {
    try {
      final parts = date.split('-');
      if (parts.length == 3) {
        int day = int.parse(parts[0]);
        int month = int.parse(parts[1]);
        int year = int.parse(parts[2]);
        return DateTime(year, month, day);
      } else {
        throw FormatException("Invalid date format");
      }
    } catch (e) {
      throw FormatException("Invalid date format: $date");
    }
  }
}
