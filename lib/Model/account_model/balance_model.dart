import 'account_model.dart';
import 'transaction_model.dart';

class BalanceModel {
  double? totalBalance;
  String? uid;
  List<AccountModel>? accountModel;
  List<TransactionModel>? transactionModel;

  BalanceModel(
      {this.totalBalance, this.uid, this.accountModel, this.transactionModel});

  Map<String, dynamic> toMap() {
    return {
      "totalBalance": totalBalance,
      "uid": uid,
      "cardDetails": accountModel?.map((card) => card.toMap()).toList(),
      "transactionDetails": transactionModel?.map((card) => card.toMap()).toList(),
    };
  }

  BalanceModel.fromMap(Map<String, dynamic> map) {
    totalBalance = map["totalBalance"];
    uid = map["uid"];
    if (map["cardDetails"] != null) {
      accountModel = List<AccountModel>.from(
        map["cardDetails"].map((cardMap) =>
            AccountModel.fromMap(Map<String, dynamic>.from(cardMap))),
      );
    }
    if (map["transactionDetails"] != null) {
      transactionModel = List<TransactionModel>.from(
        map["transactionDetails"].map((cardMap) =>
            TransactionModel.fromMap(Map<String, dynamic>.from(cardMap))),
      );
    }
  }
}
