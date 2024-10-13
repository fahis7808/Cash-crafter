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
    this.debitCard = false,
    this.debitCardNumber,
    this.debitValidUpTo,
    this.debitCVV,
    this.creditCard = false,
    this.creditCardNumber,
    this.creditValidUpTo,
    this.creditCVV,
    this.creditLimit,
    this.creditDueDate,
  });

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
