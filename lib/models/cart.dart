class Cart {
  final String productId;
  final String userId;
  final String image;
  final String productName;
  final String productPrice;
  final String userName;
  final String userEmail;
  int quantity;

  Cart({
    required this.productId,
    required this.userId,
    required this.image,
    required this.productName,
    required this.productPrice,
    required this.userName,
    required this.userEmail,
    this.quantity = 1,
  });
}
