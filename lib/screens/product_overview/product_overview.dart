import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:multi_furniture_store/config/colors.dart';
import 'package:multi_furniture_store/config/text.dart';
import 'package:multi_furniture_store/providers/wishlist_provider.dart';
import 'package:multi_furniture_store/screens/review_cart/review_cart.dart';
import 'package:multi_furniture_store/widgets/count.dart';
import 'package:provider/provider.dart';

enum SinginCharacter { fill, outline }

class ProductOverview extends StatefulWidget {
  final String productName;
  final String productImage;
  final int productPrice;
  final String productId;
  ProductOverview(
      {required this.productId,
      required this.productImage,
      required this.productName,
      required this.productPrice});

  @override
  _ProductOverviewState createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  SinginCharacter _character = SinginCharacter.fill;

  Widget bonntonNavigatorBar({
    Color? iconColor,
    Color? backgroundColor,
    Color? color,
    String? title,
    IconData? iconData,
    Function? onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(20),
          color: backgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 20,
                color: iconColor,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                title!,
                style: TextStyle(color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool wishListBool = false;

  getWishtListBool() {
    FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourWishList")
        .doc(widget.productId)
        .get()
        .then((value) => {
              if (this.mounted)
                {
                  if (value.exists)
                    {
                      setState(
                        () {
                          wishListBool = value.get("wishList");
                        },
                      ),
                    }
                }
            });
  }

  final _formKey = GlobalKey<FormState>();
  // TextEditingController _reviewController = TextEditingController();
  // double _rating = 0.0;

  // final Stream<QuerySnapshot> _reviewStream = FirebaseFirestore.instance
  //     .collection('Ratings')
  //     .doc(FirebaseAuth.instance.currentUser!.uid)
  //     .collection('Reviews')
  //     .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //     .snapshots();

  String? myEmail;
  String? myName;
  String? myProfile;

  String? paymentMethod;
  String? paymentStatus;

  @override
  Widget build(BuildContext context) {
    WishListProvider wishListProvider = Provider.of(context);
    getWishtListBool();
    return Scaffold(
      backgroundColor: colorFFFFFF,
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  wishListBool = !wishListBool;
                });
                if (wishListBool == true) {
                  wishListProvider.addWishListData(
                    wishListId: widget.productId,
                    wishListImage: widget.productImage,
                    wishListName: widget.productName,
                    wishListPrice: widget.productPrice,
                    wishListQuantity: 2,
                  );
                } else {
                  wishListProvider.wishlistDataDelete(widget.productId);
                }
              },
              child: Container(
                padding: EdgeInsets.all(20),
                color: color000000,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      wishListBool == false
                          ? Icons.favorite_outline
                          : Icons.favorite,
                      size: 20,
                      color: colorFFFFFF,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Add To WishList',
                      style: TextStyle(color: colorFFFFFF),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.to(ReviewCart());
              },
              child: Container(
                padding: EdgeInsets.all(20),
                color: color5254A8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shop_outlined,
                      size: 20,
                      color: colorFFFFFF,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Go To Cart',
                      style: TextStyle(color: colorFFFFFF),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: color5254A8,
        iconTheme: IconThemeData(color: colorFFFFFF),
        title: Text(
          "Product Overview",
          style: TextStyle(color: colorFFFFFF),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                        height: 250,
                        padding: EdgeInsets.all(40),
                        child: Image.network(
                          widget.productImage ?? "",
                        )),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      child: Text(
                        "Available Options",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Row(
                          //   children: [
                          //     CircleAvatar(
                          //       radius: 3,
                          //       backgroundColor: Colors.green[700],
                          //     ),
                          //     Radio(
                          //       value: SinginCharacter.fill,
                          //       groupValue: _character,
                          //       activeColor: Colors.green[700],
                          //       onChanged: (value) {
                          //         setState(() {
                          //           _character = value!;
                          //         });
                          //       },
                          //     ),
                          //   ],
                          // ),
                          Column(
                            children: [
                              Text(
                                widget.productName,
                                style: TextStyle(fontSize: 20),
                              ).paddingOnly(bottom: 5),
                              Text(
                                rupees + widget.productPrice.toString(),
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          Count(
                            productId: widget.productId,
                            productImage: widget.productImage,
                            productName: widget.productName,
                            productPrice: widget.productPrice,
                          ),
                          // Container(
                          //   padding: EdgeInsets.symmetric(
                          //     horizontal: 30,
                          //     vertical: 10,
                          //   ),
                          //   decoration: BoxDecoration(
                          //     border: Border.all(
                          //       color: Colors.grey,
                          //     ),
                          //     borderRadius: BorderRadius.circular(
                          //       30,
                          //     ),
                          //   ),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       Icon(
                          //         Icons.add,
                          //         size: 17,
                          //         color: primaryColor,
                          //       ),
                          //       Text(
                          //         "ADD",
                          //         style: TextStyle(color: primaryColor),
                          //       )
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "About This Product",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "of a customer. Wikipedi In marketing, a product is an object or system made available for consumer use; it is anything that can be offered to a market to satisfy the desire or need of a customer. Wikipedi",
                      style: TextStyle(
                        fontSize: 16,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
              // Container(
              //   decoration: BoxDecoration(
              //     border: Border.all(color: Colors.black),
              //     borderRadius: BorderRadius.circular(8),
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         "Rating & Review",
              //         style: TextStyle(
              //           fontSize: 18,
              //           fontWeight: FontWeight.w600,
              //         ),
              //       ).paddingOnly(left: 20, top: 10),
              //       RatingBar.builder(
              //         initialRating: _rating,
              //         minRating: 1,
              //         direction: Axis.horizontal,
              //         allowHalfRating: true,
              //         itemCount: 5,
              //         itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              //         itemBuilder: (context, _) => Icon(
              //           Icons.star,
              //           color: color5254A8,
              //         ),
              //         onRatingUpdate: (rating) {
              //           setState(() {
              //             _rating = rating;
              //           });
              //         },
              //       ).paddingOnly(left: 15, right: 15, top: 15, bottom: 10),
              //       TextFormField(
              //         decoration: InputDecoration(
              //           hintText: 'Describe your experience',
              //           focusedBorder: UnderlineInputBorder(
              //             borderSide: BorderSide(
              //               color: color5254A8,
              //             ),
              //           ),
              //         ),
              //         cursorColor: color5254A8,
              //         maxLength: 500,
              //         controller: _reviewController,
              //       ).paddingOnly(left: 15, right: 15, bottom: 10),
              //       Align(
              //         alignment: Alignment.bottomRight,
              //         child: ElevatedButton(
              //           onPressed: () {
              //             if (_formKey.currentState!.validate()) {
              //               _formKey.currentState!.save();
              //               FirebaseFirestore.instance
              //                   .collection('Ratings')
              //                   .doc(FirebaseAuth.instance.currentUser!.uid)
              //                   .collection('Reviews')
              //                   .add({
              //                 'productId': widget.productId,
              //                 'userId': FirebaseAuth.instance.currentUser!.uid,
              //                 'productName': widget.productName,
              //                 'userName': myName,
              //                 'userEmail': myEmail,
              //                 'userProfile': myProfile,
              //                 'rating': _rating,
              //                 'review': _reviewController.text.trim(),
              //                 'timestamp': DateTime.now(),
              //               });
              //               showDialog(
              //                 context: context,
              //                 builder: (context) => AlertDialog(
              //                   title: const Text('Rating & Review'),
              //                   content: Text(
              //                       'Your rating & review is submitted successfully.'),
              //                   actions: [
              //                     TextButton(
              //                       onPressed: () {
              //                         Get.back();
              //                       },
              //                       child: Text('OK'),
              //                     ),
              //                   ],
              //                 ),
              //               );
              //               _formKey.currentState!.reset();
              //             }
              //           },
              //           child: Text('Submit'),
              //         ).paddingOnly(left: 15, right: 15, bottom: 10),
              //       ),
              //     ],
              //   ),
              // ).paddingAll(10),
              // SizedBox(height: 20.0),
              // StreamBuilder<QuerySnapshot>(
              //   stream: _reviewStream,
              //   builder: (BuildContext context,
              //       AsyncSnapshot<QuerySnapshot> snapshot) {
              //     if (snapshot.hasError) {
              //       return Text('Something went wrong');
              //     }

              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return Center(
              //         child: CircularProgressIndicator(
              //           color: Colors.cyan,
              //         ),
              //       );
              //     }

              //     return SizedBox(
              //       height: 380,
              //       child: ListView.builder(
              //         physics: NeverScrollableScrollPhysics(),
              //         padding: const EdgeInsets.symmetric(horizontal: 10),
              //         scrollDirection: Axis.vertical,
              //         itemCount: snapshot.data!.size,
              //         shrinkWrap: true,
              //         itemBuilder: (context, index) {
              //           final productData = snapshot.data!.docs[index];
              //           return GestureDetector(
              //             onTap: () {},
              //             child: Container(
              //               width: 180,
              //               child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Text(
              //                     productData['productId'],
              //                     style: TextStyle(
              //                             color: Color(0xFF000000),
              //                             fontSize: 20,
              //                             fontWeight: FontWeight.w500,
              //                             fontFamily: 'Poppins')
              //                         .copyWith(),
              //                     overflow: TextOverflow.ellipsis,
              //                     maxLines: 2,
              //                   ).paddingOnly(top: 10),
              //                   Text(
              //                     productData['rating'].toString(),
              //                     style: TextStyle(
              //                             color: Color(0xFF999999),
              //                             fontSize: 14,
              //                             fontWeight: FontWeight.w400,
              //                             fontFamily: 'Poppins')
              //                         .copyWith(fontSize: 18),
              //                   ).paddingOnly(top: 5),
              //                   Text(
              //                     productData['review'],
              //                     style: TextStyle(
              //                             color: Color(0xFF999999),
              //                             fontSize: 14,
              //                             fontWeight: FontWeight.w400,
              //                             fontFamily: 'Poppins')
              //                         .copyWith(fontSize: 18),
              //                   ).paddingOnly(top: 5),
              //                   Text(
              //                     productData['userId'],
              //                     style: TextStyle(
              //                             color: Color(0xFF999999),
              //                             fontSize: 14,
              //                             fontWeight: FontWeight.w400,
              //                             fontFamily: 'Poppins')
              //                         .copyWith(fontSize: 18),
              //                   ).paddingOnly(top: 5),
              //                 ],
              //               ).paddingOnly(top: 10),
              //             ),
              //           ).paddingOnly(left: 10);
              //         },
              //       ),
              //     );
              //   },
              // ).paddingOnly(bottom: 20),
            ],
          ),
        ),
      ),
    );
  }

  _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null)
      await FirebaseFirestore.instance
          .collection('buyers')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        myEmail = ds.data()!['email'];
        myName = ds.data()!['fullName'];
        myProfile = ds.data()!['profile'];
        print(myName);
        print(myEmail);
        print(myProfile);
      }).catchError((e) {
        print(e);
      });
  }
}
