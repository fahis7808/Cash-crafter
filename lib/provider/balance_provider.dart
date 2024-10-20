import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:money_manage_app2/Model/account_model/account_model.dart';
import 'package:money_manage_app2/Model/account_model/balance_model.dart';
import 'package:money_manage_app2/Model/account_model/transaction_model.dart';
import 'package:money_manage_app2/util/collection_reference.dart';

import '../service/secure_storage.dart';

class BalanceProvider extends ChangeNotifier {
  bool wallet = false;
  bool isLoading = false;

  BalanceModel balanceModel = BalanceModel();
  AccountModel accModel = AccountModel();
  TransactionModel transactionModel = TransactionModel();

  List<AccountModel> accountList = [];

  BalanceProvider() {
    getData();
    onRefresh();
  }

  addAccount() {
    try {} catch (e) {
      print(e);
    }
  }

  Future<String> getLoginID() async {
    String uid = await LocalDB.readFromDB("LoginID");
    return uid.toString();
  }

  getData() async {
    isLoading = true;
    notifyListeners();
    try {
      /// accounts data ///
      QuerySnapshot accounts = await CollectionReferenceData.accounts.get();
      accountList = accounts.docs.map((e) {
        return AccountModel.fromMap(e.data() as Map<String, dynamic>);
      }).toList();

      /// main wallet data call ///
      QuerySnapshot walletData =
          await CollectionReferenceData.accountDetails.get();
      if (walletData.docs.isNotEmpty) {
        Map<String, dynamic> accountMap =
            walletData.docs.first.data() as Map<String, dynamic>;
        balanceModel = BalanceModel.fromMap(accountMap);
        wallet = false;
      } else {
        wallet = true;
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      wallet = false;
      print(e);
      notifyListeners();
    }
  }

  Future<bool> addBalance() async {
    try {
      await CollectionReferenceData.accountDetails
          .doc("balance001")
          .set(BalanceModel(
            totalBalance: accModel.balance,
          ).toMap());
      await CollectionReferenceData.accounts.doc("acc001").set(AccountModel(
            accId: "acc001",
            balance: accModel.balance,
            accountName: "Wallet",
          ).toMap());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<String> getAccId() async {
    QuerySnapshot accountDocs = await CollectionReferenceData.accounts.get();

    String newDocId = 'acc${(accountDocs.size + 1).toString().padLeft(3, '0')}';

    return newDocId.toString();
  }

  Future<bool> editWallet() async {
    isLoading = true;
    onRefresh();
    double balance = (balanceModel.totalBalance ?? 0) + (accModel.balance ?? 0);
    String newID = await getAccId();
    accModel.accId = newID;
    try {
      await CollectionReferenceData.accountDetails
          .doc("balance001")
          .update(BalanceModel(totalBalance: balance).toMap());

      await CollectionReferenceData.accounts.doc(newID).set(accModel.toMap());
      isLoading = false;
      return true;
    } catch (e) {
      print(e);
      isLoading = false;
      onRefresh();
      return false;
    }
  }

  /// Edit MainBalance
  Future<void> updateMainBalance(String id, double balance) async {
    try {
      await CollectionReferenceData.accountDetails
          .doc("balance001")
          .update(BalanceModel(totalBalance: balance).toMap());
    } catch (e) {
      throw Exception("Failed to update");
    }
  }

  /// get account Balance
  getACBalance(String accName, double? amount, bool add) {
    AccountModel? account = accountList.firstWhere(
      (e) => e.accountName == accName,
      orElse: () => AccountModel(),
    );

    double balance =
        (account.balance ?? 0) + (add ? (amount ?? 0) : -(amount ?? 0));

    String id = account.accId.toString();
    return {'balance': balance, 'id': id};
  }

  /// Edit account balance
  Future<void> updateAccountBalance(String accId, double balance) async {
    try {
      await CollectionReferenceData.accounts
          .doc(accId)
          .update(AccountModel(balance: balance).toMap());
    } catch (e) {
      print("Error updating account balance: $e");
      throw Exception("Failed to update account: $accId");
    }
  }

  addTransfer() async {
    var fromAcc = getACBalance(
        transactionModel.from.toString(), transactionModel.amount, false);
    var toAcc = getACBalance(
        transactionModel.to.toString(), transactionModel.amount, true);
    transactionModel.date ?? DateFormat('dd-MM-yyyy').format(DateTime.now());
    transactionModel.transferType ?? "transfer";
    try {
      if (transactionModel.transferType == "transfer") {
        await updateAccountBalance(fromAcc["id"], fromAcc["balance"]);
        await updateAccountBalance(toAcc["id"], toAcc["balance"]);
      } else {
        if (transactionModel.from != null) {
          await updateAccountBalance(fromAcc["id"], fromAcc["balance"]);
        } else if (transactionModel.to != null) {
          await updateAccountBalance(toAcc["id"], toAcc["balance"]);
        }
      }

      await CollectionReferenceData.transaction
          .doc()
          .set(transactionModel.toMap());
    } catch (e) {
      return e;
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
