import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_furniture_store/utils/color_utilites.dart';
import 'package:multi_furniture_store/views/buyers/screens/widgets/cart_widget.dart';

class AddToCartScreen extends StatelessWidget {
  const AddToCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorFFFFFF,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
            size: 30,
          ),
        ),
        title: Text(
          'Add To Cart',
          style: TextStyle(
            color: color000000,
          ),
        ),
        centerTitle: true,
      ),
      body: CartWidget(),
    );
  }
}
