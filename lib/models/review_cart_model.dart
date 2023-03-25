class ReviewCartModel {
  String cartId;
  String cartImage;
  String cartName;
  String paymentMethod;
  String paymentStatus;
  int cartPrice;
  int cartQuantity;
  ReviewCartModel({
    required this.cartId,
    required this.cartImage,
    required this.cartName,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.cartPrice,
    required this.cartQuantity,
  });
}