import 'package:flutter/material.dart';
import 'dart:async';
import 'package:multi_furniture_store/config/colors.dart';
import 'package:multi_furniture_store/screens/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:multi_furniture_store/providers/review_cart_provider.dart';
import 'package:multi_furniture_store/widgets/single_item.dart';
import 'package:multi_furniture_store/config/text.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multi_furniture_store/models/review_cart_model.dart';

// class ConfirmOrder extends StatelessWidget {
//   late ReviewCartProvider reviewCartProvider;
//
//   String? cartId;
//   String? cartImage;
//   String? cartName;
//   String? paymentMethod;
//   String? paymentStatus;
//   int? cartPrice;
//   int? cartQuantity;
//
//   final Stream<QuerySnapshot> _cartStream = FirebaseFirestore.instance
//       .collection('ReviewCart')
//       .doc(FirebaseAuth.instance.currentUser!.uid)
//       .collection("YourReviewCart")
//       .where('paymentMethod', isEqualTo: '')
//       .where('paymentStatus', isEqualTo: '')
//       .snapshots();
//
//   @override
//   Widget build(BuildContext context) {
//     ReviewCartProvider reviewCartProvider = Provider.of(context);
//     reviewCartProvider.getReviewCartData();
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: color5254A8,
//         title: Text(
//           "Confirm Order",
//           style: TextStyle(fontSize: 18),
//         ),
//       ),
//       body: Column(
//         children: [
//           StreamBuilder<QuerySnapshot>(
//             stream: _cartStream,
//             builder:
//                 (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//               if (snapshot.hasError) {
//                 return Text('Something went wrong');
//               }
//
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(
//                   child: CircularProgressIndicator(
//                     color: Colors.cyan,
//                   ),
//                 );
//               }
//
//               return SizedBox(
//                 height: 300,
//                 child: ListView.builder(
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   scrollDirection: Axis.horizontal,
//                   itemCount: snapshot.data!.size,
//                   itemBuilder: (context, index) {
//                     final productData = snapshot.data!.docs[index];
//                     final firebaseUser = FirebaseAuth.instance.currentUser;
//                     cartId = productData['cartId'];
//                     cartImage = productData['cartImage'];
//                     cartName = productData['cartName'];
//                     paymentMethod = productData['paymentMethod'];
//                     paymentStatus = productData['paymentStatus'];
//                     cartPrice = productData['cartPrice'];
//                     cartQuantity = productData['cartQuantity'];
//                     return GestureDetector(
//                       onTap: () {},
//                       child: Container(
//                         width: 180,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Image.network(
//                               productData['cartImage'],
//                               fit: BoxFit.fill,
//                               height: 200,
//                               width: 200,
//                             ),
//                             Text(
//                               productData['cartName'],
//                               style: TextStyle(
//                                       color: Color(0xFF000000),
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.w500,
//                                       fontFamily: 'Poppins')
//                                   .copyWith(),
//                               overflow: TextOverflow.ellipsis,
//                               maxLines: 2,
//                             ).paddingOnly(top: 10),
//                             Text(
//                               'Price: ' +
//                                   rupees +
//                                   productData['cartPrice'].toString(),
//                               style: TextStyle(
//                                       color: Color(0xFF999999),
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w400,
//                                       fontFamily: 'Poppins')
//                                   .copyWith(fontSize: 18),
//                             ).paddingOnly(top: 5),
//                             Text(
//                               'Quantity: ' +
//                                   productData['cartQuantity'].toString(),
//                               style: TextStyle(
//                                       color: Color(0xFF999999),
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w400,
//                                       fontFamily: 'Poppins')
//                                   .copyWith(fontSize: 18),
//                             ).paddingOnly(top: 5),
//                           ],
//                         ).paddingOnly(top: 10),
//                       ),
//                     ).paddingOnly(left: 10);
//                   },
//                 ),
//               );
//             },
//           ),
//           Container(
//             width: 160,
//             height: 50,
//             child: MaterialButton(
//               onPressed: () async {
//                 CollectionReference ref = FirebaseFirestore.instance
//                     .collection("ReviewCart")
//                     .doc(FirebaseAuth.instance.currentUser!.uid)
//                     .collection("YourReviewCart");
//
//                 QuerySnapshot eventsQuery = await ref
//                     .where('paymentMethod', isEqualTo: '')
//                     .where('paymentStatus', isEqualTo: '')
//                     .get();
//
//                 eventsQuery.docs.forEach((msgDoc) {
//                   msgDoc.reference.update({
//                     "paymentMethod": 'Cash on Delivery',
//                     "paymentStatus": 'In Progress',
//                   });
//                 });
//
//                 print('Cash on Delivery');
//                 Get.offAll(HomeScreen());
//               },
//               child: Text(
//                 "Confirm Order",
//                 style: TextStyle(
//                   color: colorFFFFFF,
//                 ),
//               ),
//               color: primaryColor,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//           ).paddingOnly(top: 20),
//         ],
//       ),
//     );
//   }
// }

class ConfirmOrder extends StatefulWidget {
  const ConfirmOrder({Key? key}) : super(key: key);

  @override
  State<ConfirmOrder> createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  late ReviewCartProvider reviewCartProvider;

  String? cartId;
  String? cartImage;
  String? cartName;
  String? paymentMethod;
  String? paymentStatus;
  int? cartPrice;
  int? cartQuantity;

  final Stream<QuerySnapshot> _cartStream = FirebaseFirestore.instance
      .collection('ReviewCart')
      .where('userName',
          isEqualTo: FirebaseAuth.instance.currentUser!.displayName)
      .where('paymentMethod', isEqualTo: '')
      .where('paymentStatus', isEqualTo: '')
      .snapshots();

  update() async {
    CollectionReference ref =
        FirebaseFirestore.instance.collection("ReviewCart");

    QuerySnapshot eventsQuery = await ref
        .where('userName',
            isEqualTo: FirebaseAuth.instance.currentUser!.displayName)
        .where('paymentMethod', isEqualTo: '')
        .where('paymentStatus', isEqualTo: '')
        .get();

    eventsQuery.docs.forEach((msgDoc) {
      msgDoc.reference.update({
        "paymentMethod": 'Cash on Delivery',
        "paymentStatus": 'Payment Success',
      });
    });
  }

  Timer? _timer;
  // int _start = 10;

  void startTimer() {
    const oneSec = const Duration(seconds: 20);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if ('paymentStatus' == 'In Progress') {
            update();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: color5254A8,
        title: Text(
          "Confirm Order",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: _cartStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                height: 300,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.size,
                  itemBuilder: (context, index) {
                    final productData = snapshot.data!.docs[index];
                    final firebaseUser = FirebaseAuth.instance.currentUser;
                    cartId = productData['cartId'];
                    cartImage = productData['cartImage'];
                    cartName = productData['cartName'];
                    paymentMethod = productData['paymentMethod'];
                    paymentStatus = productData['paymentStatus'];
                    cartPrice = productData['cartPrice'];
                    cartQuantity = productData['cartQuantity'];
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 180,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              productData['cartImage'],
                              fit: BoxFit.fill,
                              height: 200,
                              width: 200,
                            ),
                            Text(
                              productData['cartName'],
                              style: TextStyle(
                                      color: Color(0xFF000000),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins')
                                  .copyWith(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ).paddingOnly(top: 10),
                            Text(
                              'Price: ' +
                                  rupees +
                                  productData['cartPrice'].toString(),
                              style: TextStyle(
                                      color: Color(0xFF999999),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Poppins')
                                  .copyWith(fontSize: 18),
                            ).paddingOnly(top: 5),
                            Text(
                              'Quantity: ' +
                                  productData['cartQuantity'].toString(),
                              style: TextStyle(
                                      color: Color(0xFF999999),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Poppins')
                                  .copyWith(fontSize: 18),
                            ).paddingOnly(top: 5),
                          ],
                        ).paddingOnly(top: 10),
                      ),
                    ).paddingOnly(left: 10);
                  },
                ),
              );
            },
          ),
          Container(
            width: 160,
            height: 50,
            child: MaterialButton(
              onPressed: () async {
                CollectionReference ref =
                    FirebaseFirestore.instance.collection("ReviewCart");

                QuerySnapshot eventsQuery = await ref
                    .where('userName',
                        isEqualTo:
                            FirebaseAuth.instance.currentUser!.displayName)
                    .where('paymentMethod', isEqualTo: '')
                    .where('paymentStatus', isEqualTo: '')
                    .get();

                eventsQuery.docs.forEach((msgDoc) {
                  msgDoc.reference.update({
                    "paymentMethod": 'Cash on Delivery',
                    "paymentStatus": 'In Progress',
                  });
                });

                print('Cash on Delivery');
                // startTimer();
                Get.offAll(HomeScreen());
              },
              child: Text(
                "Confirm Order",
                style: TextStyle(
                  color: colorFFFFFF,
                ),
              ),
              color: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ).paddingOnly(top: 20),
        ],
      ),
    );
  }
}
