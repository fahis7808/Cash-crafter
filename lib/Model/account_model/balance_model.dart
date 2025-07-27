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

  factory BalanceModel.fromMap(Map<String, dynamic> map) {
    return BalanceModel(
      totalBalance: (map["totalBalance"] ?? 0.0).toDouble(),
      uid: map["uid"] ?? '',
    );
  }
}
