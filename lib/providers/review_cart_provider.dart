import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:Reflex_Furniture/models/review_cart_model.dart';

class ReviewCartProvider with ChangeNotifier {
  void addReviewCartData({
    String? userName,
    String? userEmail,
    String? cartId,
    String? cartName,
    String? cartImage,
    String? paymentMethod,
    String? paymentStatus,
    String? deliveryStatus,
    int? cartPrice,
    int? cartQuantity,
  }) async {
    FirebaseFirestore.instance.collection("ReviewCart").doc(cartId).set(
      {
        "userName": userName,
        "userEmail": userEmail,
        "cartId": cartId,
        "cartName": cartName,
        "cartImage": cartImage,
        "paymentMethod": paymentMethod,
        "paymentStatus": paymentStatus,
        "deliveryStatus": deliveryStatus,
        "cartPrice": cartPrice,
        "cartQuantity": cartQuantity,
        "isAdd": true,
      },
    );
  }

  void updateReviewCartData({
    String? userName,
    String? userEmail,
    String? cartId,
    String? cartName,
    String? cartImage,
    String? paymentMethod,
    String? paymentStatus,
    String? deliveryStatus,
    int? cartPrice,
    int? cartQuantity,
  }) async {
    FirebaseFirestore.instance.collection("ReviewCart").doc(cartId).update(
      {
        "userName": userName,
        "userEmail": userEmail,
        "cartId": cartId,
        "cartName": cartName,
        "cartImage": cartImage,
        "paymentMethod": '',
        "paymentStatus": '',
        "deliveryStatus": '',
        "cartPrice": cartPrice,
        "cartQuantity": cartQuantity,
        "isAdd": true,
      },
    );
  }

  List<ReviewCartModel> reviewCartDataList = [];
  void getReviewCartData() async {
    List<ReviewCartModel> newList = [];

    QuerySnapshot reviewCartValue = await FirebaseFirestore.instance
        .collection("ReviewCart")
        .where('userEmail', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .where('paymentMethod', isEqualTo: '')
        .where('paymentStatus', isEqualTo: '')
        .get();
    reviewCartValue.docs.forEach((element) {
      ReviewCartModel reviewCartModel = ReviewCartModel(
        userName: element.get("userName"),
        userEmail: FirebaseAuth.instance.currentUser!.email!,
        cartId: element.get("cartId"),
        cartImage: element.get("cartImage"),
        cartName: element.get("cartName"),
        paymentMethod: '',
        paymentStatus: '',
        deliveryStatus: '',
        cartPrice: element.get("cartPrice"),
        cartQuantity: element.get("cartQuantity"),
      );
      newList.add(reviewCartModel);
    });
    reviewCartDataList = newList;
    notifyListeners();
  }

  List<ReviewCartModel> get getReviewCartDataList {
    return reviewCartDataList;
  }

//// TotalPrice  ///

  getTotalPrice() {
    double total = 0.0;
    reviewCartDataList.forEach((element) {
      total += element.cartPrice * element.cartQuantity;
    });
    return total;
  }

////////////// ReviCartDeleteFunction ////////////
  reviewCartDataDelete(cartId) {
    FirebaseFirestore.instance.collection("ReviewCart").doc(cartId).delete();
    notifyListeners();
  }
}
