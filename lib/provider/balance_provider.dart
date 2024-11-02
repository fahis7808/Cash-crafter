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
  bool isBtnLoading = false;

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
      /// main wallet data call ///

      QuerySnapshot walletData =
          await CollectionReferenceData.accountDetails.get();
      print(walletData);
      if (walletData.docs.isNotEmpty) {
        wallet = false;
        Map<String, dynamic> accountMap =
            walletData.docs.first.data() as Map<String, dynamic>;
        balanceModel = BalanceModel.fromMap(accountMap);

        /// accounts data ///
        QuerySnapshot accounts = await CollectionReferenceData.accounts.get();
        print(accounts);
        accountList = accounts.docs.map((e) {
          return AccountModel.fromMap(e.data() as Map<String, dynamic>);
        }).toList();
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
  Future<void> updateMainBalance(double amount, bool add) async {
    double balance =
        (balanceModel.totalBalance ?? 0) + (add ? (amount) : -(amount));
    try {
      await CollectionReferenceData.accountDetails
          .doc("balance001")
          .update({"totalBalance": balance});
    } catch (e) {
      throw Exception("Failed to update");
    }
  }

  /// get account Balance
  getACBalance(String? accName, double? amount, bool add) {
    print("account name $accName");
    if (accName == null) {
      print("<<<<<<object>>>>>>");
      print(accName);
      print("<<<<<<object>>>>>>");

      return null;
    } else {
      AccountModel? account = accountList.firstWhere(
        (e) => e.accountName == accName,
        orElse: () => AccountModel(),
      );

      double balance =
          (account.balance ?? 0) + (add ? (amount ?? 0) : -(amount ?? 0));

      String id = account.accId.toString();
      print(id);
      return {'balance': balance, 'id': id};
    }
  }

  /// Edit account balance
  Future<void> updateAccountBalance(String accId, double balance) async {
    try {
      await CollectionReferenceData.accounts
          .doc(accId)
          .update({'balance': balance});
    } catch (e) {
      print("Error updating account balance: $e");
      throw Exception("Failed to update account: $accId");
    }
  }

  Future<bool> addTransfer() async {
    isBtnLoading = true;
    onRefresh();
    var fromAcc =
        getACBalance(transactionModel.from, transactionModel.amount, false);
    var toAcc =
        getACBalance(transactionModel.to, transactionModel.amount, true);
    transactionModel.date ?? DateFormat('dd-MM-yyyy').format(DateTime.now());
    transactionModel.transferType ?? "transfer";
    try {
      print("from : ${transactionModel.from}");
      print("to : ${transactionModel.to}");
      print(toAcc);
      if (fromAcc != null) {
        await updateAccountBalance(fromAcc["id"], fromAcc["balance"]);
      }
      if (toAcc != null) {
        await updateAccountBalance(toAcc["id"], toAcc["balance"]);
      }

      await CollectionReferenceData.transaction
          .doc()
          .set(transactionModel.toMap());
      isBtnLoading = false;
      onRefresh();
      return true;
    } catch (e) {
      isBtnLoading = false;
      onRefresh();
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
