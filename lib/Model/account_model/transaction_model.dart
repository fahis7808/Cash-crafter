class TransactionModel {
  double? amount;
  String? transactionType;
  String? debit;
  double? phoneNumber;
  String? credit;
  String? note;
  String? category;
  int? debtType;
  String? date;

  TransactionModel({
    this.amount,
    this.transactionType,
    this.debit,
    this.phoneNumber,
    this.credit,
    this.note,
    this.category,
    this.debtType = 0,
    this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      "amount": amount,
      "transactionType": transactionType,
      "debitAccount": debit,
      "phoneNumber" : phoneNumber,
      "creditAccount": credit,
      "note": note,
      "category": category,
      "debtType": debtType,
      "date": date,
    };
  }

  TransactionModel.fromMap(Map<String, dynamic> map) {
    amount = map["amount"];
    transactionType = map["transactionType"];
    debit = map["debitAccount"];
    phoneNumber = map["phoneNumber"];
    credit = map["creditAccount"];
    note = map["note"];
    category = map["category"];
    debtType = map["debtType"];
    date = map["date"];
  }
}
