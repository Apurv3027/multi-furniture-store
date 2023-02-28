import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_furniture_store/utils/color_utilites.dart';
import 'package:multi_furniture_store/utils/text_utilities.dart';
import 'package:multi_furniture_store/utils/textstyle_utilites.dart';
import 'package:multi_furniture_store/views/buyers/main_screen.dart';
import 'package:multi_furniture_store/views/buyers/screens/widgets/favorite_product_widget.dart';

class FavoriteProductScreen extends StatefulWidget {

  @override
  State<FavoriteProductScreen> createState() => _FavoriteProductScreenState();
}

class _FavoriteProductScreenState extends State<FavoriteProductScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorFFFFFF,
      appBar: AppBar(
        backgroundColor: colorFFFFFF,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.offAll(Home_ScreenEx());
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
            size: 30,
          ),
        ),
        title: Text(
          'Favorite Products',
          style: TextStyle(
            color: color000000,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: FavoriteProductWidget(),
      ),
      // body: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Text(
      //       favPro,
      //       style: color000000w90038,
      //     ).paddingAll(18),
      //     Divider(
      //       height: 1,
      //       thickness: 1,
      //     ),
      //     Container(
      //       width: double.infinity,
      //       padding: EdgeInsets.all(14),
      //       decoration: BoxDecoration(
      //         border: Border.all(color: colorCCCCCC),
      //         borderRadius:BorderRadius.circular(5),
      //       ),
      //       child: FutureBuilder(
      //         future: _fetch(),
      //         builder: (context, snapshot) {
      //           if(snapshot.connectionState != ConnectionState.done)
      //             return Text(
      //               'Loading Data...Please Wait',
      //               style: color999999w40016,
      //             );
      //           // return ListTile(
      //           //   leading: Image.network(
      //           //     image!,
      //           //     width: 50,
      //           //     height: 50,
      //           //   ),
      //           //   title: Text("Product Name: " + productName!),
      //           //   subtitle: Text("Product Price: " + productPrice!),
      //           // );
      //           return Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Text(
      //                 nameSuggestion,
      //                 style: color999999w40016,
      //               ),
      //               Text(
      //                 productName,
      //                 style: color000000w90020,
      //               ).paddingOnly(top: 5),
      //             ],
      //           );
      //         },
      //       ),
      //     ).paddingAll(18),
      //   ],
      // ),
    );
  }

}