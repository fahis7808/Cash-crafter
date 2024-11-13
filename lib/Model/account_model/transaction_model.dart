class TransactionModel {
  double? amount;
  String? transactionType;
  String? debit;
  String? credit;
  String? note;
  String? category;
  int? debtType;
  String? date;
  String? name;

  TransactionModel({
    this.amount,
    this.transactionType,
    this.debit,
    this.credit,
    this.note,
    this.category,
    this.debtType = 0,
    this.date,
    this.name
  });

  Map<String, dynamic> toMap() {
    return {
      "amount": amount,
      "transactionType": transactionType,
      "debitAccount": debit,
      "creditAccount": credit,
      "note": note,
      "category": category,
      "debtType": debtType,
      "date": date,
      "name":name
    };
  }

  TransactionModel.fromMap(Map<String, dynamic> map) {
    amount = map["amount"];
    transactionType = map["transactionType"];
    debit = map["debitAccount"];
    credit = map["creditAccount"];
    note = map["note"];
    category = map["category"];
    debtType = map["debtType"];
    date = map["date"];
    name=map['name'];
  }
}
