
import 'transaction_model.dart';

class DebtModel {
  String? id;
  String? contactId;
  String? name;
  String? phoneNumber;
  double? lendAmount;
  double? borrowedAmount;
  double? totalAmount;
  List<TransactionModel>? transactionList;

  DebtModel({
    this.id,
    this.contactId,
    this.name,
    this.phoneNumber,
    this.lendAmount,
    this.borrowedAmount,
    this.totalAmount,
    this.transactionList,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'contactId' :contactId,
      'name': name,
      'phoneNumber': phoneNumber,
      'lendPaidAmount': lendAmount,
      'borrowedRustAmount': borrowedAmount,
      'totalAmount': totalAmount,
      'transactionList': transactionList?.map((txn) => txn.toMap()).toList(),
    };
  }

  factory DebtModel.fromMap(Map<String, dynamic> map) {
    return DebtModel(
      id: map['id'] as String?,
      contactId: map['contactId'] as String?,
      name: map['name'] as String?,
      phoneNumber: map['phoneNumber'] as String?,
      lendAmount: (map['lendPaidAmount'] as num?)?.toDouble(),
      borrowedAmount: (map['borrowedRustAmount'] as num?)?.toDouble(),
      totalAmount: (map['totalAmount'] as num?)?.toDouble(),
      transactionList: (map['transactionList'] as List<dynamic>?)
          ?.map((txnMap) => TransactionModel.fromMap(txnMap))
          .toList(),
    );
  }
}
