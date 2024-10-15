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

  Future<String> getAccountId(String userId) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('account_details')
        .orderBy('accountId', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      String lastAccountId = snapshot.docs.first['accountId'];
      int lastIdNumber = int.parse(lastAccountId.substring(7)); // Extract '001'
      int newIdNumber = lastIdNumber + 1;
      return 'account${newIdNumber.toString().padLeft(3, '0')}';
    } else {
      return 'account001';
    }
  }
    Future<bool> addBalance() async {
      String uid = await getLoginID();
      List<AccountModel> accList = [
        AccountModel(accountName: "Wallet", balance: balanceModel.totalBalance),
      ];
      try {
        CollectionReference mainBalance =
            FirebaseFirestore.instance.collection("users").doc(uid).collection("account_details");

        await mainBalance.doc("balance 001").set(BalanceModel(
                uid: mainBalance.id,
                totalBalance: balanceModel.totalBalance,
                accountModel: accList)
            .toMap());
        return true;
      } catch (e) {
        print(e);
        return false;
      }
    }

    onNextButton(){
    wallet = false;
    notifyListeners();
    }

onRefresh(){
    notifyListeners();
}

}
