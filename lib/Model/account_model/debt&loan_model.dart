import 'package:money_manage_app2/Model/account_model/transaction_model.dart';

class DebtModel {
  String? id;
  String? contactId;
  String? name;
  String? phoneNumber;
  // int? debtType;
  double? lendAmount;
  double? borrowedAmount;
  double? totalAmount;
  // double? emiAmount;
  // String? dueDates;
  // int? loanTenor;
  // String? startMonth;
  List<TransactionModel>? transactionList;

  DebtModel({
    this.id,
    this.contactId,
    this.name,
    this.phoneNumber,
    // this.debtType,
    this.lendAmount,
    this.borrowedAmount,
    this.totalAmount,
    // this.emiAmount,
    // this.dueDates,
    // this.loanTenor,
    // this.startMonth,
    this.transactionList,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'contactId' :contactId,
      'name': name,
      'phoneNumber': phoneNumber,
      // 'debtType': debtType,
      'lendPaidAmount': lendAmount,
      'borrowedRustAmount': borrowedAmount,
      'totalAmount': totalAmount,
      // 'emiAmount': emiAmount,
      // 'dueDates': dueDates,
      // 'loanTenor': loanTenor,
      // 'startMonth': startMonth,
      'transactionList': transactionList?.map((txn) => txn.toMap()).toList(),
    };
  }

  factory DebtModel.fromMap(Map<String, dynamic> map) {
    return DebtModel(
      id: map['id'] as String?,
      contactId: map['contactId'] as String?,
      name: map['name'] as String?,
      phoneNumber: map['phoneNumber'] as String?,
      // debtType: map['debtType'] as int?,
      lendAmount: (map['lendPaidAmount'] as num?)?.toDouble(),
      borrowedAmount: (map['borrowedRustAmount'] as num?)?.toDouble(),
      totalAmount: (map['totalAmount'] as num?)?.toDouble(),
      // emiAmount: (map['emiAmount'] as num?)?.toDouble(),
      // dueDates: map['dueDates'] as String?,
      // loanTenor: map['loanTenor'] as int?,
      // startMonth: map['startMonth'] as String?,
      transactionList: (map['transactionList'] as List<dynamic>?)
          ?.map((txnMap) => TransactionModel.fromMap(txnMap))
          .toList(),
    );
  }
}
