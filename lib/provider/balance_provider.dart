import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:money_manage_app2/Model/account_model/account_model.dart';
import 'package:money_manage_app2/Model/account_model/balance_model.dart';

import '../service/secure_storage.dart';

class BalanceProvider extends ChangeNotifier {
  bool wallet = true;

  BalanceModel balanceModel = BalanceModel();

  AccountModel accModel = AccountModel();

  addAccount() {
    try {} catch (e) {
      print(e);
    }
  }

  Future<String> getLoginID() async {
    String uid = await LocalDB.readFromDB("LoginID");
    return uid.toString();
  }



  Future<bool> addBalance() async {
    String uid = await getLoginID();
    try {
      CollectionReference mainBalance = FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("account_details");

      CollectionReference account = FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("account_details")
          .doc("balance001")
          .collection("accounts");

      await mainBalance.doc("balance001").set(BalanceModel(
            uid: mainBalance.id,
            totalBalance: accModel.balance,
          ).toMap());
      await account.doc().set(AccountModel(
        balance: accModel.balance,
        accountName: "Wallet"
      ).toMap());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  onNextButton() {
    wallet = false;
    notifyListeners();
  }

  onRefresh() {
    notifyListeners();
  }
}
