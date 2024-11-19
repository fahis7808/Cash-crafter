import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../Model/account_model/debt&loan_model.dart';
import '../../../util/collection_reference.dart';
import 'package:url_launcher/url_launcher.dart';

class DebtProvider extends ChangeNotifier {
  DebtModel debtModel = DebtModel();

  List<DebtModel> debtList = [];

  double totalLendAmt = 0;
  double totalOweAmt = 0;

  bool isLoading = false;

  DebtProvider(){
    getDebtData();
  }

  getDebtData() async {
    isLoading = true;
    onRefresh();
    try {
      QuerySnapshot debtData = await CollectionReferenceData.debt.get();
      debtList = debtData.docs
          .map((e) => DebtModel.fromMap(e.data() as Map<String, dynamic>))
          .toList();
      getTotalAmt(debtList);
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

  onRefresh(){
    notifyListeners();
  }
}
