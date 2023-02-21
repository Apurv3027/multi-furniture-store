import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_furniture_store/utils/textstyle_utilites.dart';
import 'package:multi_furniture_store/views/buyers/screens/product_details_screen.dart';

class ProductWidget extends StatelessWidget {

  final Stream<QuerySnapshot> _productsStream =
      FirebaseFirestore.instance.collection('products').snapshots();

  bool _like = false;

  String? myId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _productsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.cyan,
            ),
          );
        }

        return SizedBox(
          height: 270,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.size,
            itemBuilder: (context, index) {
              final productData = snapshot.data!.docs[index];
              final firebaseUser = FirebaseAuth.instance.currentUser;
              // FirebaseFirestore.instance
              //     .collection('buyers')
              //     .doc(firebaseUser?.uid)
              //     .get()
              //     .then((ds){
              //   // myId=ds.data()!['buyerId'];
              //   // print('buyerId: ' + myId!);
              // });
              return GestureDetector(
                onTap: () {
                  Get.to(
                    ProductDetailsScreen(
                      productId: productData['productID'],
                      userId: firebaseUser!.uid,
                    ),
                  );
                },
                child: Container(
                  width: 180,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Image.network(productData['image']),
                          Positioned(
                            top: 10,
                            right: 12,
                            child: FavoriteButton(
                              iconColor: Colors.black,
                              iconSize: 35,
                              isFavorite: _like,
                              valueChanged: (_isFavorite) {
                                if(_isFavorite == true){
                                  FirebaseFirestore.instance
                                      .collection('favorites')
                                      .doc(productData['productID'])
                                      .set({
                                    'buyerId': FirebaseAuth.instance.currentUser!.uid,
                                    'productId': productData['productID'],
                                    'image': productData['image'],
                                    'productName': productData['productName'],
                                    'productPrice': productData['productPrice'],
                                  });
                                  print('Added to Favorite Product');
                                } else{
                                  FirebaseFirestore.instance
                                      .collection('favorites')
                                      .doc(productData['productID'])
                                      .delete();
                                  print('Delete from Favorite Product');
                                }
                                print(
                                  'Is Favorite $_isFavorite ${index + 1}',
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Text(
                        productData['productName'],
                        style: color000000w50020.copyWith(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ).paddingOnly(top: 10),
                      Text(
                        '\$' + productData['productPrice'],
                        style: color999999w40016.copyWith(fontSize: 18),
                      ).paddingOnly(top: 5),
                    ],
                  ).paddingOnly(top: 10),
                ),
              ).paddingOnly(left: 10);
            },
          ),
        );
      },
    );
  }
}
