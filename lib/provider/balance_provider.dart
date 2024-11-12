import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:intl/intl.dart';
import 'package:money_manage_app2/Model/account_model/account_model.dart';
import 'package:money_manage_app2/Model/account_model/balance_model.dart';
import 'package:money_manage_app2/Model/account_model/debt&load_model.dart';
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
  DebtAndLoanModel debtLoanModel = DebtAndLoanModel();

  List<AccountModel> accountList = [];
  List<TransactionModel> transferList = [];
  int selectedTabIndex = 0;

  BalanceProvider({int selectedIndex = 0}) {
    getData(selectedIndex);
    // isLoading = false;
    onRefresh();
  }

  addAccount() {
    try {} catch (e) {
      print(e);
    }
  }
  List<Contact> contact = [];
  bool permissionDenied = false;
  Contact contactData = Contact();

  Future<String> getLoginID() async {
    String uid = await LocalDB.readFromDB("LoginID");
    return uid.toString();
  }

  getData(int selectedIndex) async {
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

        /// transaction data ///
        QuerySnapshot transfer =
            await CollectionReferenceData.transaction.get();
        transferList = transfer.docs.map((e) {
          return TransactionModel.fromMap(e.data() as Map<String, dynamic>);
        }).toList();

        /// contact details ///
        if(selectedIndex == 3){
          bool permissionStatus = await FlutterContacts.requestPermission(readonly: true);
          if (permissionStatus) {
            contact = await FlutterContacts.getContacts(withProperties: true);
            print("<<<<<object>>>>>");
            print(contact.length);
            print("<<<<<object>>>>>");

          }
        }
      } else {
        wallet = true;
      }

    } catch (e) {
      wallet = false;
      print(e);
      notifyListeners();
    }
    isLoading = false;
    notifyListeners();
  }

  String accountName = "";

  List<TransactionModel> getTransferList(String accountName) {
    List<TransactionModel> transList = [];
    if (accountName != "") {
      transList = transferList.where((e) {
        return e.credit == accountName || e.debit == accountName;
      }).toList();
    } else {
      transList = transferList;
    }
    return transList;
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
    if (accName == null) {
      return null;
    } else {
      AccountModel? account = accountList.firstWhere(
        (e) => e.accountName == accName,
        orElse: () => AccountModel(),
      );
      double balance =
          (account.balance ?? 0) + (add ? (amount ?? 0) : -(amount ?? 0));
      String id = account.accId.toString();
      return {'balance': balance, 'id': id};
    }
  }

  /// Edit account balance
  Future<void> updateAccountBalance(
      String? accName, double? amount, bool add) async {
    var value = getACBalance(accName, amount, add);
    try {
      await CollectionReferenceData.accounts
          .doc(value["id"])
          .update({'balance': value["balance"]});
    } catch (e) {
      print("Error updating account balance: $e");
      throw Exception("Failed to update account: ${value["id"]}");
    }
  }

  Future<String> getTransactionID() async {
    const String initialId = "trans001";
    String newId = initialId;

    DocumentSnapshot docs =
        await CollectionReferenceData.transaction.doc(initialId).get();
    try {
      if (docs.exists) {
        QuerySnapshot querySnapshot = await CollectionReferenceData.transaction
            .orderBy(FieldPath.documentId)
            .startAt([initialId]).get();
        if (querySnapshot.docs.isNotEmpty) {
          String lastId = querySnapshot.docs.last.id;

          int idNumber = int.parse(lastId.replaceAll('trans', '')) + 1;
          newId = 'trans${idNumber.toString().padLeft(3, '0')}';
        }
      }
    } catch (e) {
      print(e);
    }

    return newId.toString();
  }

  Future<bool> addTransfer() async {
    isBtnLoading = true;
    onRefresh();
    String newId = await getTransactionID();
    transactionModel.date = transactionModel.date ??
        DateFormat('dd-MM-yyyy').format(DateTime.now());
    transactionModel.transactionType =
        transactionModel.transactionType ?? "transfer";
    try {
      if (transactionModel.transactionType == "transfer") {
        await updateAccountBalance(
            transactionModel.debit, transactionModel.amount, false);
        await updateAccountBalance(
            transactionModel.credit, transactionModel.amount, true);
      } else if (transactionModel.transactionType == "income") {
        await updateAccountBalance(
            transactionModel.credit, transactionModel.amount, true);
        await updateMainBalance(transactionModel.amount?.toDouble() ?? 0, true);
      } else if (transactionModel.transactionType == "expense") {
        await updateAccountBalance(
            transactionModel.debit, transactionModel.amount, false);
        await updateMainBalance(
            transactionModel.amount?.toDouble() ?? 0, false);
      } else {
        print("debt");
      }

      await CollectionReferenceData.transaction
          .doc(newId)
          .set(transactionModel.toMap());
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

  onNextButton() {
    wallet = false;
    notifyListeners();
  }

  String formatDateString(String dateString) {
    if (dateString != "") {
      DateFormat inputFormat = DateFormat('dd-MM-yyyy');
      DateTime date = inputFormat.parse(dateString);
      DateFormat outputFormat = DateFormat('dd MMM yy');
      return outputFormat.format(date);
    } else {
      return "";
    }
  }

  onRefresh() {
    notifyListeners();
  }
}
