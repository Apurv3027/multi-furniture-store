import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:multi_furniture_store/config/colors.dart';
import 'package:multi_furniture_store/config/text.dart';
import 'package:get/get.dart';
import 'package:multi_furniture_store/screens/product_overview/product_overview.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Stream<QuerySnapshot>? _stream;

  @override
  void initState() {
    super.initState();
    _stream = FirebaseFirestore.instance.collection('products').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorFFFFFF,
      appBar: AppBar(
        backgroundColor: color5254A8,
        elevation: 0.0,
        title: TextField(
          controller: _searchController,
          cursorColor: colorFFFFFF,
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: colorFFFFFF),
            prefixIcon: Icon(Icons.search_rounded, color: colorFFFFFF),
            border: InputBorder.none,
          ),
          onChanged: (value) {
            setState(() {
              _stream = FirebaseFirestore.instance
                  .collection('products')
                  .where('productCategory', isGreaterThanOrEqualTo: value)
                  .snapshots();
            });
          },
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: _stream,
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

            // return SizedBox(
            //   height: 300,
            //   child: ListView.builder(
            //     padding: const EdgeInsets.symmetric(horizontal: 10),
            //     scrollDirection: Axis.horizontal,
            //     itemCount: snapshot.data!.size,
            //     itemBuilder: (context, index) {
            //       final productData = snapshot.data!.docs[index];
            //       final firebaseUser = FirebaseAuth.instance.currentUser;
            //       return GestureDetector(
            //         onTap: () {
            //           Get.to(ProductOverview(
            //             productId: productData['productID'],
            //             productImage: productData['image'],
            //             productName: productData['productName'],
            //             productPrice: productData['productPrice'],
            //           ));
            //         },
            //         child: Container(
            //           width: 180,
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Image.network(
            //                 productData['image'],
            //                 fit: BoxFit.fill,
            //                 height: 200,
            //                 width: 200,
            //               ),
            //               Text(
            //                 productData['productName'],
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
            //                 rupees + productData['productPrice'].toString(),
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

            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.size,
                itemBuilder: (context, index) {
                  final productData = snapshot.data!.docs[index];
                  final firebaseUser = FirebaseAuth.instance.currentUser;
                  return GestureDetector(
                    onTap: () {
                      // Get.to(ProductOverview(
                      //   productId: productData['productID'],
                      //   productImage: productData['image'],
                      //   productName: productData['productName'],
                      //   productPrice: productData['productPrice'],
                      //   productDetail: productData['productDetail'],
                      // ));
                    },
                    child: Container(
                      child: ListTile(
                        leading: Image.network(
                          productData['image'],
                          fit: BoxFit.fill,
                          width: 125,
                        ),
                        title: Text(
                          productData['productName'],
                          style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins')
                              .copyWith(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        subtitle: Text(
                          rupees + productData['productPrice'].toString(),
                          style: TextStyle(
                                  color: Color(0xFF999999),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins')
                              .copyWith(fontSize: 18),
                        ),
                        // trailing:
                        //     Text(document['timestamp'].toDate().toString()),
                      ),
                      // child: Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Image.network(
                      //       productData['image'],
                      //       fit: BoxFit.fill,
                      //       height: 200,
                      //       width: 200,
                      //     ),
                      //     Text(
                      //       productData['productName'],
                      //       style: TextStyle(
                      //               color: Color(0xFF000000),
                      //               fontSize: 20,
                      //               fontWeight: FontWeight.w500,
                      //               fontFamily: 'Poppins')
                      //           .copyWith(),
                      //       overflow: TextOverflow.ellipsis,
                      //       maxLines: 2,
                      //     ).paddingOnly(top: 10),
                      //     Text(
                      //       rupees + productData['productPrice'].toString(),
                      //       style: TextStyle(
                      //               color: Color(0xFF999999),
                      //               fontSize: 14,
                      //               fontWeight: FontWeight.w400,
                      //               fontFamily: 'Poppins')
                      //           .copyWith(fontSize: 18),
                      //     ).paddingOnly(top: 5),
                      //   ],
                      // ).paddingOnly(top: 10),
                    ),
                  ).paddingOnly(left: 10);
                },
              ),
            );

            // return GridView.builder(
            //   scrollDirection: Axis.vertical,
            //   shrinkWrap: true,
            //   itemCount: snapshot.data!.size,
            //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 2,
            //     mainAxisSpacing: 6,
            //     crossAxisSpacing: 6,
            //   ),
            //   itemBuilder: (context, index) {
            //     final productData = snapshot.data!.docs[index];
            //     final firebaseUser = FirebaseAuth.instance.currentUser;
            //     return GestureDetector(
            //       onTap: () {
            //         Get.to(ProductOverview(
            //           productId: productData['productID'],
            //           productImage: productData['image'],
            //           productName: productData['productName'],
            //           productPrice: productData['productPrice'],
            //         ));
            //       },
            //       child: Container(
            //         width: 100,
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Image.network(
            //               productData['image'],
            //               fit: BoxFit.fill,
            //               height: 125,
            //               width: 125,
            //             ),
            //             Text(
            //               productData['productName'],
            //               style: TextStyle(
            //                       color: Color(0xFF000000),
            //                       fontSize: 18,
            //                       fontWeight: FontWeight.w500,
            //                       fontFamily: 'Poppins')
            //                   .copyWith(),
            //               overflow: TextOverflow.ellipsis,
            //               maxLines: 2,
            //             ).paddingOnly(top: 5),
            //             Text(
            //               rupees + productData['productPrice'].toString(),
            //               style: TextStyle(
            //                       color: Color(0xFF999999),
            //                       fontSize: 12,
            //                       fontWeight: FontWeight.w400,
            //                       fontFamily: 'Poppins')
            //                   .copyWith(fontSize: 18),
            //             ).paddingOnly(top: 5),
            //           ],
            //         ).paddingOnly(top: 5),
            //       ),
            //     );
            //   },
            // ).paddingAll(10);
          },
        ),
      ),
    );
  }
}
