import 'package:cash_crafter/Model/account_model/transaction_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import '../../../Model/account_model/debt&loan_model.dart';
import '../../../util/collection_reference.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Model/account_model/balance_model.dart';
import '../service/functions.dart';

class DebtProvider extends ChangeNotifier {
  DebtModel debtModel = DebtModel();
  TransactionModel transactionModel = TransactionModel();

  List<DebtModel> debtList = [];
  List<Contact> contact = [];
  Contact contactData = Contact();
  BalanceModel balanceModel = BalanceModel();

  double totalLendAmt = 0;
  double totalOweAmt = 0;

  bool isLoading = false;
  bool isBtnLoading = false;
  final formKey = GlobalKey<FormState>();

  DebtProvider() {
    getDebtData();
  }

  getDebtData() async {
    isLoading = true;
    onRefresh();
    try {
      QuerySnapshot walletData =
          await CollectionReferenceData.accountDetails.get();
      print(walletData);
      if (walletData.docs.isNotEmpty) {
        Map<String, dynamic> accountMap =
            walletData.docs.first.data() as Map<String, dynamic>;
        print(accountMap);
        balanceModel = BalanceModel.fromMap(accountMap);
      }

      QuerySnapshot debtData = await CollectionReferenceData.debt.get();
      print("debtData");
      print(debtData);
      debtList = debtData.docs
          .map((e) => DebtModel.fromMap(e.data() as Map<String, dynamic>))
          .toList();
      print("debtData");

      print(debtList);
      isLoading = false;
      onRefresh();
    } catch (e) {
      print(e);
      isLoading = false;
      onRefresh();
    }
  }

  getTotalAmt(List<DebtModel> debtList) {
    double lentAmount = 0;
    double oweAmount = 0;
    for (var e in debtList) {
      if (e.totalAmount! > 0) {
        lentAmount += e.totalAmount?.toDouble() ?? 0;
        totalLendAmt = lentAmount;
      } else if (e.totalAmount! < 0) {
        oweAmount += e.totalAmount?.toDouble() ?? 0;
        totalOweAmt = oweAmount;
      }
    }
    print(totalLendAmt);
    print(totalOweAmt);
  }

  String getInitials(String name) {
    List<String> parts = name.trim().split(' ');

    if (parts.length == 1) {
      return parts[0][0].toUpperCase();
    } else {
      return parts[0][0].toUpperCase() + parts[1][0].toUpperCase();
    }
  }

  Future<void> sendMessageToWhatsApp() async {
    var whatsappUrl = Uri.parse(
        "whatsapp://send?phone=918893288945 &text=${Uri.encodeComponent("Your Message Here")}");

    try {
      launchUrl(whatsappUrl);
    } catch (e) {
      print(e);
    }
  }

  saveToDB() async {
    isBtnLoading = true;
    onRefresh();
    bool isUpdate = debtList.any((val) {
      print(val.phoneNumber);
      print(debtModel.phoneNumber);
      return val.phoneNumber == debtModel.phoneNumber;
    });
    print(isUpdate);
    try {
      if (isUpdate) {
        DebtModel existingDebt = debtList
            .firstWhere((val) => val.phoneNumber == debtModel.phoneNumber);
        existingDebt.transactionList?.add(transactionModel);
        existingDebt.borrowedAmount = transactionModel.debtType == 1
            ? (existingDebt.borrowedAmount ?? 0) +
                (transactionModel.amount ?? 0)
            : existingDebt.borrowedAmount;
        existingDebt.lendAmount = transactionModel.debtType == 0
            ? (existingDebt.lendAmount ?? 0) + (transactionModel.amount ?? 0)
            : existingDebt.lendAmount;
        existingDebt.totalAmount =
            (existingDebt.lendAmount ?? 0) - (existingDebt.borrowedAmount ?? 0);
        if (existingDebt.totalAmount == 0) {
          balanceModel.owe =
              (balanceModel.owe ?? 0) - (debtModel.borrowedAmount ?? 0);
          balanceModel.lend =
              (balanceModel.lend ?? 0) - (debtModel.lendAmount ?? 0);
        } else {
          balanceModel.owe =
              (balanceModel.owe ?? 0) + (debtModel.borrowedAmount ?? 0);
          balanceModel.lend =
              (balanceModel.lend ?? 0) + (debtModel.lendAmount ?? 0);
        }
        await CollectionReferenceData.debt
            .doc(existingDebt.id)
            .update(existingDebt.toMap());
      } else {
        String newId = await dataGetFunctions.getTransactionID(
            "debtAcc", CollectionReferenceData.debt);
        double? borrow =
            transactionModel.debtType == 1 ? transactionModel.amount : 0;
        double? lend =
            transactionModel.debtType == 0 ? transactionModel.amount : 0;
        debtModel.id = newId;
        debtModel.contactId = contactData.id;
        debtModel.transactionList = [transactionModel];
        debtModel.borrowedAmount = borrow;
        debtModel.lendAmount = lend;
        debtModel.totalAmount = transactionModel.amount ?? 0;
        balanceModel.owe = (balanceModel.owe ?? 0) + (borrow ?? 0);
        balanceModel.lend = (balanceModel.lend ?? 0) + (lend ?? 0);
        await CollectionReferenceData.debt
            .doc(debtModel.id)
            .set(debtModel.toMap());
      }
      print(balanceModel);
      await CollectionReferenceData.accountDetails
          .doc("balance001")
          .update(balanceModel.toMap());
      debtModel = DebtModel();
      transactionModel = TransactionModel();
      isBtnLoading = false;
      onRefresh();
      return true;
    } catch (e) {
      print(e);
      isBtnLoading = false;
      onRefresh();
      return false;
    }
  }

  onRefresh() {
    notifyListeners();
  }
}
