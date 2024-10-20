class TransactionModel {
  double? amount;
  String? transferType;
  String? from;
  double? phoneNumber;
  String? to;
  String? note;
  String? category;
  int? debtType;
  String? date;

  TransactionModel({
    this.amount,
    this.transferType,
    this.from,
    this.phoneNumber,
    this.to,
    this.note,
    this.category,
    this.debtType = 0,
    this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      "amount": amount,
      "transferType": transferType,
      "from": from,
      "to": to,
      "note": note,
      "category": category,
      "debtType": debtType,
      "date": date,
    };
  }

  TransactionModel.fromMap(Map<String, dynamic> map) {
    amount = map["amount"];
    transferType = map["transferType"];
    from = map["from"];
    to = map["to"];
    note = map["note"];
    category = map["category"];
    debtType = map["debtType"];
    date = map["date"];
  }
}
