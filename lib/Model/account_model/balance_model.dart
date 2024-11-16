class BalanceModel {
  double? totalBalance;
  String? uid;

  BalanceModel({this.totalBalance, this.uid});

  Map<String, dynamic> toMap() {
    return {
      "totalBalance": totalBalance,
      "uid": uid,
    };
  }

  BalanceModel.fromMap(Map<String, dynamic> map) {
    totalBalance = map["totalBalance"];
    uid = map["uid"];
  }
}
