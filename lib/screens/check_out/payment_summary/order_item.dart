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
      trailing: Text(rupees + e.cartPrice.toString()),
    ).paddingOnly(bottom: 10, top: 10);
  }
}
