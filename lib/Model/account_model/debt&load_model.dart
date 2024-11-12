import 'package:money_manage_app2/Model/account_model/transaction_model.dart';

class DebtAndLoanModel {
  String? id;
  String? name;
  String? phoneNumber;
  int? debtType;
  double? lendPaidAmount;
  double? borrowedRustAmount;
  double? totalAmount;
  double? emiAmount;
  String? dueDates;
  int? loanTenor;
  String? startMonth;
  List<TransactionModel>? transactionList;

  DebtAndLoanModel({
    this.id,
    this.name,
    this.phoneNumber,
    this.debtType,
    this.lendPaidAmount,
    this.borrowedRustAmount,
    this.totalAmount,
    this.emiAmount,
    this.dueDates,
    this.loanTenor,
    this.startMonth,
    this.transactionList,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'debtType': debtType,
      'lendPaidAmount': lendPaidAmount,
      'borrowedRustAmount': borrowedRustAmount,
      'totalAmount': totalAmount,
      'emiAmount': emiAmount,
      'dueDates': dueDates,
      'loanTenor': loanTenor,
      'startMonth': startMonth,
      'transactionList': transactionList?.map((txn) => txn.toMap()).toList(),
    };
  }

  factory DebtAndLoanModel.fromMap(Map<String, dynamic> map) {
    return DebtAndLoanModel(
      id: map['id'] as String?,
      name: map['name'] as String?,
      phoneNumber: map['phoneNumber'] as String?,
      debtType: map['debtType'] as int?,
      lendPaidAmount: (map['lendPaidAmount'] as num?)?.toDouble(),
      borrowedRustAmount: (map['borrowedRustAmount'] as num?)?.toDouble(),
      totalAmount: (map['totalAmount'] as num?)?.toDouble(),
      emiAmount: (map['emiAmount'] as num?)?.toDouble(),
      dueDates: map['dueDates'] as String?,
      loanTenor: map['loanTenor'] as int?,
      startMonth: map['startMonth'] as String?,
      transactionList: (map['transactionList'] as List<dynamic>?)
          ?.map((txnMap) => TransactionModel.fromMap(txnMap))
          .toList(),
    );
  }
}
