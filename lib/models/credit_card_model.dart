class CreditCardModel {
  String userId;
  String cardHolderName;
  String creditCardNumber;
  String expiryDate;
  String cvv;
  CreditCardModel({
    required this.userId,
    required this.cardHolderName,
    required this.creditCardNumber,
    required this.expiryDate,
    required this.cvv,
  });
}