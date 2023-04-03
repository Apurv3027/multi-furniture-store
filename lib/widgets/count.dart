import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:multi_furniture_store/config/colors.dart';
import 'package:multi_furniture_store/config/text_style.dart';
import 'package:multi_furniture_store/providers/review_cart_provider.dart';
import 'package:provider/provider.dart';

class Count extends StatefulWidget {
  String productName;
  String productImage;
  String productId;
  int productPrice;

  Count({
    required this.productName,
    required this.productId,
    required this.productImage,
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

  // String? productName;
  // String? productPrice;
  // double? productQuantity;

//   String userName2 = "one@yopmail.com";

// //Removes everything after the first 'A'
// String result = userName2.substring(0, userName2.indexOf('@'));
// print(result);

  getAddAndQuantity() {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourReviewCart")
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
          ? FutureBuilder(
              future: _fetch(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done)
                  return Text(
                    'Loading Data...Please Wait',
                    style: colorFFFFFFw80024,
                  ).paddingOnly(top: 30);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        if (count == 1) {
                          setState(() {
                            isTrue = false;
                          });
                          reviewCartProvider
                              .reviewCartDataDelete(widget.productId);
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
                            userName: userName,
                            userEmail: userEmail,
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
                          userName: userName,
                          userEmail: userEmail,
                        );
                      },
                      child: Icon(
                        Icons.add,
                        size: 20,
                        color: color5254A8,
                      ),
                    ).paddingOnly(left: 5),
                  ],
                );
              },
            )
          : FutureBuilder(
              future: _fetch(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done)
                  return Text(
                    'Loading Data...Please Wait',
                    style: colorFFFFFFw80024,
                  ).paddingOnly(top: 30);
                return Center(
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
                        userName: userName,
                        userEmail: userEmail,
                      );
                    },
                    child: Text(
                      "ADD",
                      style: TextStyle(color: primaryColor),
                    ),
                  ),
                );
              },
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
