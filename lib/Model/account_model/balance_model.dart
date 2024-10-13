import 'account_model.dart';

class BalanceModel {
  double? totalBalance;
  String? uid;
  List<AccountModel>? accountModel;

  BalanceModel({this.totalBalance, this.uid, this.accountModel});

  Map<String, dynamic> toMap() {
    return {
      "TotalBalance": totalBalance,
      "uid": uid,
      "CardModels": accountModel?.map((card) => card.toMap()).toList(),
      // Map list of CardModel to Maps
    };
  }

  BalanceModel.fromMap(Map<String, dynamic> map) {
    totalBalance = map["TotalBalance"];
    uid = map["uid"];
    if (map["CardModels"] != null) {
      accountModel = List<AccountModel>.from(
        map["CardModels"].map((cardMap) =>
            AccountModel.fromMap(Map<String, dynamic>.from(cardMap))),
      );
    }
  }
}

