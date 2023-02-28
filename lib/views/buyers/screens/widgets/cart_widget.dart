import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_furniture_store/services/cart_services.dart';
import 'package:multi_furniture_store/utils/color_utilites.dart';

class CartWidget extends StatefulWidget {

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  final Stream<QuerySnapshot> _cartStream = FirebaseFirestore.instance.collection('carts').where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots();

  final CollectionReference cartRef = FirebaseFirestore.instance.collection('carts');

  final CartService _cartService = CartService();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _cartStream,
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

        // return GridView.builder(
        //   shrinkWrap: true,
        //   itemCount: snapshot.data!.size,
        //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 2,
        //     mainAxisSpacing: 8,
        //     crossAxisSpacing: 8,
        //   ),
        //   itemBuilder: (context, index) {
        //     final categoryData = snapshot.data!.docs[index];
        //     return GestureDetector(
        //       onTap: () {},
        //       child: Column(
        //         children: [
        //           SizedBox(
        //             height: 100,
        //             width: 100,
        //             child: Image.network(categoryData['image']),
        //           ),
        //           Text(
        //             categoryData['categoryName'],
        //             style: TextStyle(
        //               fontSize: 20,
        //             ),
        //           ).paddingOnly(top: 20),
        //         ],
        //       ),
        //     );
        //   },
        // );

        return SizedBox(
          height: 670,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data!.size,
            itemBuilder: (context, index) {
              final cartData = snapshot.data!.docs[index];
              return GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    SizedBox(
                      height: 120,
                      width: 80,
                      child: Image.network(cartData['image']),
                    ).paddingOnly(left: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cartData['productName'],
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          cartData['productPrice'],
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Container(
                          color: color999999,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.remove_rounded),
                              ).paddingOnly(right: 5),
                              Text(
                                cartData['quantity'].toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.add_rounded),
                              ).paddingOnly(left: 5),
                            ],
                          ),
                        ),
                      ],
                    ).paddingOnly(left: 30),
                  ],
                ).paddingOnly(top: 10),
              );
            },
          ),
        );
      },
    );
  }
}
