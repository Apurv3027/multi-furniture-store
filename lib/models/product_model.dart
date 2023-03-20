class ProductModel {
  String productName;
  String productImage;
  int productPrice;
  String productId;
  int productQuantity;
  ProductModel(
      {
        required this.productQuantity,
        required this.productId,
        required this.productImage,
        required this.productName,
        required this.productPrice});
}