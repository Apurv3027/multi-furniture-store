class ReviewCartModel {
  String userName;
  String userEmail;
  String cartId;
  String cartImage;
  String cartName;
  String paymentMethod;
  String paymentStatus;
  String deliveryStatus;
  int cartPrice;
  int cartQuantity;
  ReviewCartModel({
    required this.userName,
    required this.userEmail,
    required this.cartId,
    required this.cartImage,
    required this.cartName,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.deliveryStatus,
    required this.cartPrice,
    required this.cartQuantity,
  });
}
