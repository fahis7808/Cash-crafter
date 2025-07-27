import 'package:cash_crafter/service/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:intl/intl.dart';
import 'package:cash_crafter/Model/account_model/account_model.dart';
import 'package:cash_crafter/Model/account_model/balance_model.dart';
import 'package:cash_crafter/Model/account_model/debt&loan_model.dart';
import 'package:cash_crafter/Model/account_model/transaction_model.dart';
import 'package:cash_crafter/util/collection_reference.dart';

import '../service/secure_storage.dart';

class BalanceProvider extends ChangeNotifier {
  bool wallet = false;
  bool isLoading = false;
  bool isBtnLoading = false;

  BalanceModel balanceModel = BalanceModel();
  AccountModel accModel = AccountModel();
  TransactionModel transactionModel = TransactionModel();
  DebtModel debtLoanModel = DebtModel();

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
        print(accountMap);
        balanceModel = BalanceModel.fromMap(accountMap);

        /// accounts data ///
        QuerySnapshot accounts = await CollectionReferenceData.accounts.get();
        print(accounts);
        print("<<<<<<<<<<<accounts>>>>>>>>>>>");
        accountList = accounts.docs.map((e) {
          return AccountModel.fromMap(e.data() as Map<String, dynamic>);
        }).toList();
        print(accountList);
        print("<<<<<<<<<<<object>>>>>>>>>>>");

        /// transaction data ///
        QuerySnapshot transfer =
            await CollectionReferenceData.transaction.get();
        transferList = transfer.docs.map((e) {
          return TransactionModel.fromMap(e.data() as Map<String, dynamic>);
        }).toList();

        /// contact details ///
        if (selectedIndex == 3) {
          bool permissionStatus =
              await FlutterContacts.requestPermission(readonly: true);
          if (permissionStatus) {
            List<Contact> contacts =
                await FlutterContacts.getContacts(withProperties: true);
            contact = contacts.where((e) => e.phones.isNotEmpty).toList();
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
    transList = transList.reversed.toList();

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

  Future<bool> addTransfer(int value) async {
    isBtnLoading = true;
    onRefresh();
    String newTransID = await dataGetFunctions.getTransactionID(
        "trans", CollectionReferenceData.transaction);
    print("Transfer Type: ${transactionModel.transactionType}");
    transactionModel.date = transactionModel.date ??
        DateFormat('dd-MM-yyyy').format(DateTime.now());
    transactionModel.transactionType ??=
        transactionModel.transactionType == null && value == 3
            ? "debt"
            : "transfer";
    print("Transfer Type: ${transactionModel.transactionType}");
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
      } else if (transactionModel.transactionType == "debt") {
        if (transactionModel.credit != null) {
          await updateAccountBalance(
              transactionModel.credit, transactionModel.amount, true);
          await updateMainBalance(
              transactionModel.amount?.toDouble() ?? 0, true);
        } else {
          await updateAccountBalance(
              transactionModel.debit, transactionModel.amount, false);
          await updateMainBalance(
              transactionModel.amount?.toDouble() ?? 0, false);
        }
        DebtModel debt = await getDebtList(contactData.id);
        print(debt);
        if (debt.id != null) {
          debt.lendAmount = transactionModel.debtType == 0
              ? (debt.lendAmount ?? 0) + (transactionModel.amount ?? 0)
              : debt.lendAmount ?? 0;
          debt.borrowedAmount = transactionModel.debtType == 1
              ? (debt.borrowedAmount ?? 0) + (transactionModel.amount ?? 0)
              : debt.borrowedAmount ?? 0;

          List<TransactionModel> updatedTransactionList = List.from(
              (debt.transactionList ?? [])
                  .map((e) => TransactionModel.fromMap(e.toMap())));
          updatedTransactionList.add(transactionModel);
          debt.transactionList = updatedTransactionList;
          debt.totalAmount =
              (debt.lendAmount ?? 0) - (debt.borrowedAmount ?? 0);
          print(debt.id);
          await CollectionReferenceData.debt.doc(debt.id).update(debt.toMap());
        } else {
          String newDebtId = await dataGetFunctions.getTransactionID(
              "debtAcc", CollectionReferenceData.debt);

          await CollectionReferenceData.debt.doc(newDebtId).set(DebtModel(
              id: newDebtId,
              contactId: contactData.id,
              name: debtLoanModel.name,
              phoneNumber: debtLoanModel.phoneNumber,
              borrowedAmount:
                  transactionModel.debtType == 1 ? transactionModel.amount : 0,
              lendAmount:
                  transactionModel.debtType == 0 ? transactionModel.amount : 0,
              totalAmount: transactionModel.amount,
              transactionList: [transactionModel]).toMap());
        }
      }

      await CollectionReferenceData.transaction
          .doc(newTransID)
          .set(transactionModel.toMap());
      transferList = [];
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

  Future getDebtList(String? id) async {
    if (id == null) {
      return null;
    } else {
      try {
        QuerySnapshot debt = await CollectionReferenceData.debt.get();
        List<DebtModel> debtList = debt.docs
            .map((e) => DebtModel.fromMap(e.data() as Map<String, dynamic>))
            .toList();
        DebtModel debtData = debtList.firstWhere(
          (e) => e.contactId == id,
          orElse: () => DebtModel(),
        );
        return debtData;
      } catch (e) {
        return null;
      }
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
