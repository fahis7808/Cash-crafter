class AccountModel {
  String? accId;
  double? balance;
  String? accountName;
  String? bankName;
  String? accountNumber;
  String? accountType;
  bool? debitCard;
  String? debitCardNumber;
  String? debitValidUpTo;
  String? debitCVV;
  String? debitCardHolderName;
  bool? creditCard;
  String? creditCardNumber;
  String? creditValidUpTo;
  String? creditCVV;
  double? creditLimit;
  DateTime? creditDueDate;

  AccountModel({
    this.accId,
    this.balance,
    this.accountName,
    this.bankName,
    this.accountNumber,
    this.accountType,
    this.debitCard = false,
    this.debitCardNumber,
    this.debitValidUpTo,
    this.debitCVV,
    this.debitCardHolderName,
    this.creditCard = false,
    this.creditCardNumber,
    this.creditValidUpTo,
    this.creditCVV,
    this.creditLimit,
    this.creditDueDate,
  });

  Map<String, dynamic> toMap() {
    return {
      "id":accId,
      "balance": balance,
      "accountName": accountName,
      "bankName": bankName,
      "accountNumber": accountNumber,
      "accountType": accountType,
      "debitCard": debitCard,
      "debitCardNumber": debitCardNumber,
      "debitValidUpTo": debitValidUpTo,
      "debitCVV": debitCVV,
      "debitCardHolderName": debitCardHolderName,
      "creditCard": creditCard,
      "creditCardNumber": creditCardNumber,
      "creditValidUpTo": creditValidUpTo,
      "creditCVV": creditCVV,
      "creditLimit": creditLimit,
      "creditDueDate": creditDueDate?.toIso8601String(), // Convert DateTime to String
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
      debitCard: map["debitCard"] ?? false,
      debitCardNumber: map["debitCardNumber"]?.toString(),
      debitValidUpTo: map["debitValidUpTo"]?.toString(),
      debitCVV: map["debitCVV"]?.toString(),
      debitCardHolderName: map["debitCardHolderName"]?.toString(),
      creditCard: map["creditCard"] ?? false,
      creditCardNumber: map["creditCardNumber"]?.toString(),
      creditValidUpTo: map["creditValidUpTo"]?.toString(),
      creditCVV: map["creditCVV"]?.toString(),
      creditLimit: map["creditLimit"] != null ? (map["creditLimit"] as num).toDouble() : null,
      creditDueDate: map["creditDueDate"] != null ? DateTime.parse(map["creditDueDate"]) : null,
    );
  }

}
