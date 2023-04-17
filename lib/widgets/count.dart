import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:multi_furniture_store/config/colors.dart';
import 'package:multi_furniture_store/config/text_style.dart';
import 'package:multi_furniture_store/providers/review_cart_provider.dart';
import 'package:provider/provider.dart';

class Count extends StatefulWidget {
  final String productName;
  final String productImage;
  final String productId;
  final String userName;
  final String userEmail;
  final int productPrice;

  Count({
    required this.productName,
    required this.productId,
    required this.productImage,
    required this.userName,
    required this.userEmail,
    required this.productPrice,
  });
  @override
  _CountState createState() => _CountState();
}

class _CountState extends State<Count> {
  int count = 1;
  bool isTrue = false;

  String? paymentMethod;
  String? paymentStatus;

  String? userName;
  String? userEmail;

  getAddAndQuantity() {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(widget.productId)
        .get()
        .then(
          (value) => {
            if (this.mounted)
              {
                if (value.exists)
                  {
                    setState(() {
                      count = value.get("cartQuantity");
                      isTrue = value.get("isAdd");
                    })
                  }
              }
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    getAddAndQuantity();

    ReviewCartProvider reviewCartProvider = Provider.of(context);
    return Container(
      height: 30,
      width: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: isTrue == true
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    if (count == 1) {
                      setState(() {
                        isTrue = false;
                      });
                      reviewCartProvider.reviewCartDataDelete(widget.productId);
                    } else if (count > 1) {
                      setState(() {
                        count--;
                      });
                      reviewCartProvider.updateReviewCartData(
                        cartId: widget.productId,
                        cartImage: widget.productImage,
                        cartName: widget.productName,
                        cartPrice: widget.productPrice,
                        cartQuantity: count,
                        paymentMethod: '',
                        paymentStatus: '',
                        deliveryStatus: '',
                        userName: widget.userName,
                        userEmail: widget.userEmail,
                      );
                    }
                  },
                  child: Icon(
                    Icons.remove,
                    size: 20,
                    color: color5254A8,
                  ),
                ).paddingOnly(right: 5),
                Text(
                  "$count",
                  style: TextStyle(
                    color: color5254A8,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      count++;
                    });
                    reviewCartProvider.updateReviewCartData(
                      cartId: widget.productId,
                      cartImage: widget.productImage,
                      cartName: widget.productName,
                      cartPrice: widget.productPrice,
                      cartQuantity: count,
                      paymentMethod: '',
                      paymentStatus: '',
                      deliveryStatus: '',
                      userName: widget.userName,
                      userEmail: widget.userEmail,
                    );
                  },
                  child: Icon(
                    Icons.add,
                    size: 20,
                    color: color5254A8,
                  ),
                ).paddingOnly(left: 5),
              ],
            )
          : Center(
              child: InkWell(
                onTap: () {
                  setState(() {
                    isTrue = true;
                  });
                  reviewCartProvider.addReviewCartData(
                    cartId: widget.productId,
                    cartImage: widget.productImage,
                    cartName: widget.productName,
                    cartPrice: widget.productPrice,
                    cartQuantity: count,
                    paymentMethod: '',
                    paymentStatus: '',
                    deliveryStatus: '',
                    userName: widget.userName,
                    userEmail: widget.userEmail,
                  );
                },
                child: Text(
                  "ADD",
                  style: TextStyle(color: primaryColor),
                ),
              ),
            ),
    );
  }

  _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null)
      await FirebaseFirestore.instance
          .collection("buyers")
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        userName = ds.data()!['fullName'];
        userEmail = ds.data()!['email'];
        print(userName);
      }).catchError((e) {
        print(e);
      });
  }
}

class CountProduct extends StatefulWidget {
  final String productName;
  final String productImage;
  final String productId;
  final String userName;
  final String userEmail;
  final int productPrice;

  CountProduct({
    required this.productName,
    required this.productId,
    required this.productImage,
    required this.userName,
    required this.userEmail,
    required this.productPrice,
  });
  @override
  _CountProductState createState() => _CountProductState();
}

class _CountProductState extends State<CountProduct> {
  int count = 1;
  bool isTrue = false;

  String? paymentMethod;
  String? paymentStatus;

  String? userName;
  String? userEmail;

  getAddAndQuantity() {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(widget.productId)
        .get()
        .then(
          (value) => {
            if (this.mounted)
              {
                if (value.exists)
                  {
                    setState(() {
                      count = value.get("cartQuantity");
                      isTrue = value.get("isAdd");
                    })
                  }
              }
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    getAddAndQuantity();

    ReviewCartProvider reviewCartProvider = Provider.of(context);
    return Container(
      height: 30,
      width: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: isTrue == true
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    if (count == 1) {
                      setState(() {
                        isTrue = false;
                      });
                      reviewCartProvider.reviewCartDataDelete(widget.productId);
                    } else if (count > 1) {
                      setState(() {
                        count--;
                      });
                      reviewCartProvider.updateReviewCartData(
                        cartId: widget.productId,
                        cartImage: widget.productImage,
                        cartName: widget.productName,
                        cartPrice: widget.productPrice,
                        cartQuantity: count,
                        paymentMethod: '',
                        paymentStatus: '',
                        deliveryStatus: '',
                        userName: widget.userName,
                        userEmail: widget.userEmail,
                      );
                    }
                  },
                  child: Icon(
                    Icons.remove,
                    size: 20,
                    color: color5254A8,
                  ),
                ).paddingOnly(right: 5),
                Text(
                  "$count",
                  style: TextStyle(
                    color: color5254A8,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      count++;
                    });
                    reviewCartProvider.updateReviewCartData(
                      cartId: widget.productId,
                      cartImage: widget.productImage,
                      cartName: widget.productName,
                      cartPrice: widget.productPrice,
                      cartQuantity: count,
                      paymentMethod: '',
                      paymentStatus: '',
                      deliveryStatus: '',
                      userName: widget.userName,
                      userEmail: widget.userEmail,
                    );
                  },
                  child: Icon(
                    Icons.add,
                    size: 20,
                    color: color5254A8,
                  ),
                ).paddingOnly(left: 5),
              ],
            )
          : Center(
              child: InkWell(
                onTap: () {
                  setState(() {
                    isTrue = true;
                  });
                  reviewCartProvider.addReviewCartData(
                    cartId: widget.productId,
                    cartImage: widget.productImage,
                    cartName: widget.productName,
                    cartPrice: widget.productPrice,
                    cartQuantity: count,
                    paymentMethod: '',
                    paymentStatus: '',
                    deliveryStatus: '',
                    userName: widget.userName,
                    userEmail: widget.userEmail,
                  );
                },
                child: Text(
                  "ADD",
                  style: TextStyle(color: primaryColor),
                ),
              ),
            ),
    );
  }

  _fetchUser() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null)
      await FirebaseFirestore.instance
          .collection("buyers")
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        userName = ds.data()!['fullName'];
        userEmail = ds.data()!['email'];
        print(userName);
      }).catchError((e) {
        print(e);
      });
  }
}
