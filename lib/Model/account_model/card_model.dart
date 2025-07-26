class CardModel {
  String? cardNumber;
  String? expiryDate;
  String? cardHolderName;
  String? cvvCode;

  CardModel({
    this.cardNumber,
    this.expiryDate,
    this.cardHolderName,
    this.cvvCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
      'cardHolderName': cardHolderName,
      'cvvCode': cvvCode,
    };
  }

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      cardNumber: json['cardNumber'] ?? '',
      expiryDate: json['expiryDate'] ?? '',
      cardHolderName: json['cardHolderName'] ?? '',
      cvvCode: json['cvvCode'] ?? '',
    );
  }
}