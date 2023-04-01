import 'dart:async';
import 'package:flutter/material.dart';
import 'package:multi_furniture_store/config/text.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:multi_furniture_store/config/colors.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({super.key});

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  final Stream<QuerySnapshot> _orderCompleteStream = FirebaseFirestore.instance
      .collection('ReviewCart')
      .where('userName',
          isEqualTo: FirebaseAuth.instance.currentUser!.displayName)
      .where('paymentStatus', isEqualTo: 'Payment Success')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorFFFFFF,
      appBar: AppBar(
        backgroundColor: color5254A8,
        title: Text(
          "My Orders",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: _orderCompleteStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
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

                // return SizedBox(
                //   height: 270,
                //   child: ListView.builder(
                //     padding: const EdgeInsets.symmetric(horizontal: 10),
                //     scrollDirection: Axis.horizontal,
                //     itemCount: snapshot.data!.size,
                //     itemBuilder: (context, index) {
                //       final productData = snapshot.data!.docs[index];
                //       final firebaseUser = FirebaseAuth.instance.currentUser;
                //       return GestureDetector(
                //         onTap: () {},
                //         child: Container(
                //           width: 180,
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Image.network(
                //                 productData['cartImage'],
                //                 fit: BoxFit.fill,
                //                 height: 200,
                //                 width: 200,
                //               ),
                //               Text(
                //                 productData['cartName'],
                //                 style: TextStyle(
                //                         color: Color(0xFF000000),
                //                         fontSize: 20,
                //                         fontWeight: FontWeight.w500,
                //                         fontFamily: 'Poppins')
                //                     .copyWith(),
                //                 overflow: TextOverflow.ellipsis,
                //                 maxLines: 2,
                //               ).paddingOnly(top: 10),
                //               Text(
                //                 rupees + productData['cartPrice'].toString(),
                //                 style: TextStyle(
                //                         color: Color(0xFF999999),
                //                         fontSize: 14,
                //                         fontWeight: FontWeight.w400,
                //                         fontFamily: 'Poppins')
                //                     .copyWith(fontSize: 18),
                //               ).paddingOnly(top: 5),
                //             ],
                //           ).paddingOnly(top: 10),
                //         ),
                //       ).paddingOnly(left: 10);
                //     },
                //   ),
                // );

                return GridView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.size,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6,
                  ),
                  itemBuilder: (context, index) {
                    final productData = snapshot.data!.docs[index];
                    return Column(
                      children: [
                        Image.network(
                          productData['cartImage'],
                          height: 100,
                          width: 100,
                          fit: BoxFit.fill,
                        ),
                        Text(
                          productData['cartName'],
                          style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins')
                              .copyWith(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ).paddingOnly(top: 10),
                        Text(
                          rupees + productData['cartPrice'].toString(),
                          style: TextStyle(
                                  color: Color(0xFF999999),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins')
                              .copyWith(fontSize: 18),
                        ).paddingOnly(top: 5),
                        productData['deliveryStatus'] == 'Pending'
                            ? Icon(Icons.pending_actions_rounded)
                            : Icon(Icons.done_all_rounded),
                      ],
                    );
                  },
                ).paddingOnly(top: 20);
              },
            ),
          ],
        ),
      ),
    );
  }
}
