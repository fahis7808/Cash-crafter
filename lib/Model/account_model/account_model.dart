import 'card_model.dart';

class AccountModel {
  String? accId;
  double? balance;
  String? accountName;
  String? bankName;
  String? accountNumber;
  String? accountType;
  CardModel? cardModel;

  AccountModel({
    this.accId,
    this.balance,
    this.accountName,
    this.bankName,
    this.accountNumber,
    this.accountType,
    this.cardModel
  });

  Map<String, dynamic> toMap() {
    return {
      "id":accId,
      "balance": balance,
      "accountName": accountName,
      "bankName": bankName,
      "accountNumber": accountNumber,
      "accountType": accountType,
      "cardModel": cardModel?.toJson(),
    };
  }

  factory AccountModel.fromMap(Map<String, dynamic> map) {
    return AccountModel(
      accId: map["id"]?.toString(),
      balance: map["balance"] != null ? (map["balance"] as num).toDouble() : null,
      accountName: map["accountName"],
      bankName: map["bankName"],
      accountNumber: map["accountNumber"]?.toString(),
      accountType: map["accountType"],
      cardModel: map["cardModel"] != null ? CardModel.fromJson(map["cardModel"]) : null,
    );
  }

}
