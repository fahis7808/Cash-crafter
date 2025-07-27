class BalanceModel {
  double? totalBalance;
  String? uid;
  double? lend;
  double? owe;

  BalanceModel(
      {this.totalBalance, this.uid, this.lend, this.owe});

  Map<String, dynamic> toMap() {
    return {
      "totalBalance": totalBalance,
      "uid": uid,
      "lendAmount": lend,
      "borrowedAmount": owe,
    };
  }

  BalanceModel.fromMap(Map<String, dynamic> map) {
    totalBalance = map["totalBalance"];
    uid = map["uid"];
    lend = map["lendAmount"] ;
    owe = map["borrowedAmount"];
  }
}
