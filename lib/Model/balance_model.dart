class BalanceModel {
  double? totalBalance;
  String? uid;
  List<AccountModel>? accountModel; // Changed to List<CardModel>

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

class AccountModel {
  double? balance;
  String? accountName;
  String? bankName;
  String? accountNumber;
  String? accountType;
  bool? debitCard;
  double? debitCardNumber;
  String? debitValidUpTo;
  double? debitCVV;
  bool? creditCard;
  double? creditCardNumber;
  String? creditValidUpTo;
  double? creditCVV;
  double? creditLimit;
  DateTime? creditDueDate;

  AccountModel({
    this.balance,
    this.accountName,
    this.bankName,
    this.accountNumber,
    this.accountType,
    this.debitCard,
    this.debitCardNumber,
    this.debitValidUpTo,
    this.debitCVV,
    this.creditCard,
    this.creditCardNumber,
    this.creditValidUpTo,
    this.creditCVV,
    this.creditLimit,
    this.creditDueDate,
  });

  // Convert the AccountModel to a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      "balance": balance,
      "accountName": accountName,
      "bankName": bankName,
      "accountNumber": accountNumber,
      "accountType": accountType,
      "debitCard": debitCard,
      "debitCardNumber": debitCardNumber,
      "debitValidUpTo": debitValidUpTo,
      "debitCVV": debitCVV,
      "creditCard": creditCard,
      "creditCardNumber": creditCardNumber,
      "creditValidUpTo": creditValidUpTo,
      "creditCVV": creditCVV,
      "creditLimit": creditLimit,
      "creditDueDate": creditDueDate?.toIso8601String(), // Convert DateTime to String
    };
  }

  // Create an AccountModel from a Map<String, dynamic>
  AccountModel.fromMap(Map<String, dynamic> map) {
    balance = map["balance"];
    accountName = map["accountName"];
    bankName = map["bankName"];
    accountNumber = map["accountNumber"];
    accountType = map["accountType"];
    debitCard = map["debitCard"];
    debitCardNumber = map["debitCardNumber"];
    debitValidUpTo = map["debitValidUpTo"];
    debitCVV = map["debitCVV"];
    creditCard = map["creditCard"];
    creditCardNumber = map["creditCardNumber"];
    creditValidUpTo = map["creditValidUpTo"];
    creditCVV = map["creditCVV"];
    creditLimit = map["creditLimit"];
    creditDueDate = map["creditDueDate"] != null ? DateTime.parse(map["creditDueDate"]) : null; // Parse String to DateTime
  }
}
