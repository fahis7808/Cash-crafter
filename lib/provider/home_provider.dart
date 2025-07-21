import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../../../Model/account_model/balance_model.dart';
import '../../../Model/account_model/transaction_model.dart';
import '../../../util/collection_reference.dart';

class HomeProvider extends ChangeNotifier {
  BalanceModel balanceData = BalanceModel();
  List<TransactionModel> transferList = [];
  double income = 0;
  double expense = 0;

  bool isLoading = false;

  HomeProvider() {
    getData();
  }
  getData() async {
    isLoading = true;
    onRefresh();
    try {
      QuerySnapshot data = await CollectionReferenceData.accountDetails.get();
      Map<String, dynamic> accountMap =
          data.docs.first.data() as Map<String, dynamic>;
      balanceData = BalanceModel.fromMap(accountMap);
      QuerySnapshot transfer = await CollectionReferenceData.transaction.get();
      transferList = transfer.docs.map((e) {
        return TransactionModel.fromMap(e.data() as Map<String, dynamic>);
      }).toList();

      if (transferList.isNotEmpty) {
        getIncomeExpenseSum(transferList);
      }
      isLoading = false;
      onRefresh();
    } catch (e) {
      isLoading = false;
      onRefresh();
      print(e);
    }
  }

  getIncomeExpenseSum(List<TransactionModel> transferList) {
    DateTime currentDate = DateTime.now();
    int currentMonth = currentDate.month;
    int currentYear = currentDate.year;
    double incomeAmt = 0;
    double expenseAmt = 0;
    print(transferList.map((e) => e.transactionType));
    for (var i in transferList) {
      DateTime transferDate = parseDate(i.date.toString());
      if (transferDate.month == currentMonth &&
          transferDate.year == currentYear) {
        if (i.transactionType == "income") {
          incomeAmt += i.amount ?? 0;
          income = incomeAmt;
        }
        if (i.transactionType == "expense") {
          expenseAmt += i.amount ?? 0;
          expense = expenseAmt;
        }
      }
    }
    print(income);
    print(expense);
  }

  Map<String, dynamic> getGraphData(List<TransactionModel> dataList) {
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

    List<Map<String, dynamic>> resultData = [];

    Set<String> allDates = {...dailyIncomeSums.keys, ...dailyExpenseSums.keys};

    for (String date in allDates) {
      double income = dailyIncomeSums[date] ?? 0.0;
      double expense = dailyExpenseSums[date] ?? 0.0;

      DateTime parsedDate = parseDate(date);
      String formattedDate =
          "${parsedDate.day.toString().padLeft(2, '0')}/${parsedDate.month.toString().padLeft(2, '0')}";

      resultData.add({
        "date": formattedDate,
        "income": income,
        "expense": expense,
        "parsedDate": parsedDate
      });
    }

    resultData.sort((a, b) => a["parsedDate"].compareTo(b["parsedDate"]));

    resultData = resultData.map((entry) {
      return {
        "date": entry["date"],
        "income": entry["income"],
        "expense": entry["expense"],
      };
    }).toList();
    return {
      "data": resultData,
    };
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

  onRefresh() {
    notifyListeners();
  }
}
