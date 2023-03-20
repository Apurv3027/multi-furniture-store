import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_furniture_store/config/text.dart';
import 'package:multi_furniture_store/models/review_cart_model.dart';
import 'package:multi_furniture_store/providers/review_cart_provider.dart';

class OrderItem extends StatelessWidget {
  final ReviewCartModel e;
  late ReviewCartProvider reviewCartProvider;
  OrderItem({required this.e});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        e.cartImage,
        width: 60,
      ),
      title: Text(e.cartName),
      subtitle: Text(e.cartQuantity.toString()),
      trailing: Column(
        children: [
          Text(rupees + e.cartPrice.toString()),
          SizedBox(
            height: 5,
          ),
          InkWell(
            // onTap: widget.onDelete,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Cart Product"),
                  content: Text("Are you sure you want to delete your cart product?"),
                  actions: [
                    MaterialButton(
                      child: Text("No"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    MaterialButton(
                      child: Text("Yes"),
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection("ReviewCart")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection("YourReviewCart")
                            .doc(e.cartId)
                            .delete();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
            },
            child: Container(
              height: 30,
              width: 80,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ).paddingOnly(bottom: 10,top: 10);
  }
}