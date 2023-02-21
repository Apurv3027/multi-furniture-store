import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multi_furniture_store/models/cart.dart';

class CartService {
  final CollectionReference _cartRef = FirebaseFirestore.instance.collection('carts');

  Future<void> addToCart(Cart cart) async {
    await _cartRef.doc().set({
      'productId': cart.productId,
      'userId': cart.userId,
      'productName': cart.productName,
      'productPrice': cart.productPrice,
      'quantity': cart.quantity,
    }, SetOptions(merge: true));
  }

  Future<void> removeFromCart(String productId) async {
    await _cartRef.doc(productId).delete();
  }

  Future<void> updateCartQuantity(String productId, int quantity) async {
    await _cartRef.doc(productId).update({'quantity': quantity});
  }

  Stream<QuerySnapshot> getCartItems() {
    return _cartRef.snapshots();
  }
}