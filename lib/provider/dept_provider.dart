import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:money_manage_app2/Model/account_model/debt&loan_model.dart';
import 'package:money_manage_app2/util/collection_reference.dart';
import 'package:url_launcher/url_launcher.dart';

class DebtProvider extends ChangeNotifier {
  DebtModel debtModel = DebtModel();

  List<DebtModel> debtList = [];

  double totalLendAmt = 0;
  double totalOweAmt = 0;

  getDebtData() async {
    try {
      QuerySnapshot debtData = await CollectionReferenceData.debt.get();
      debtList = debtData.docs
          .map((e) => DebtModel.fromMap(e.data() as Map<String, dynamic>))
          .toList();
      print(debtList);
    } catch (e) {
      print(e);
    }
  }

  getTotalAmt() {
    double lentAmount = 0;
    double oweAmount = 0;
    for (var e in debtList) {
      if (e.totalAmount! > 0) {
        lentAmount += e.totalAmount?.toDouble() ?? 0;
      } else if (e.totalAmount! < 0) {
        oweAmount += e.totalAmount?.toDouble() ?? 0;
      }
    }
    return lentAmount + oweAmount;
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


  Future<void> sendMessageToWhatsApp1(String phoneNumber, String message) async {
    final url = "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


}
