class Cart {
  final String productId;
  final String userId;
  final String productName;
  final String productPrice;
  int quantity;

  Cart({
    required this.productId,
    required this.userId,
    required this.productName,
    required this.productPrice,
    this.quantity = 1,
  });
}