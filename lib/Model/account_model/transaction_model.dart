class TransactionModel {
  double? amount;
  String? transferType;
  String? from;
  String? to;
  String? note;
  String? category;
  String? debtType;
  DateTime? date;

  TransactionModel({
    this.amount,
    this.transferType,
    this.from,
    this.to,
    this.note,
    this.category,
    this.debtType,
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
      "date": date?.toIso8601String(),
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
    date = map["date"] != null ? DateTime.parse(map["date"]) : null;
  }
}
