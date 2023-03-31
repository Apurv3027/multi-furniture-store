import 'package:flutter/material.dart';
import 'package:multi_furniture_store/config/text.dart';
import 'package:multi_furniture_store/screens/home/home_screen.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:get/get.dart';
import 'package:multi_furniture_store/config/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:multi_furniture_store/config/text_style.dart';

class RazorPay extends StatefulWidget {
  final int paymentAmount;
  final int paymentShippingCharge;
  final int paymentDiscountValue;
  RazorPay({
    required this.paymentAmount,
    required this.paymentShippingCharge,
    required this.paymentDiscountValue,
  });

  @override
  State<RazorPay> createState() => _RazorPayState();
}

class _RazorPayState extends State<RazorPay> {
  TextEditingController _reviewController = TextEditingController();
  double _rating = 0.0;

  //Buyers
  String? myEmail;
  String? myName;
  String? myPhoneNum;
  String? myProfile;

  //Review Cart
  String? cartId;
  String? cartImage;
  String? paymentMethod;
  String? paymentStatus;
  String? cartName;
  String? cartPrice;
  String? cartQuantity;

  String img = '';
  String name = '';
  String id = '';
  int price = 0;
  int qun = 0;

  final Stream<QuerySnapshot> _cartStream = FirebaseFirestore.instance
      .collection('ReviewCart')
      .where('userName',
          isEqualTo: FirebaseAuth.instance.currentUser!.displayName)
      .where('paymentMethod', isEqualTo: '')
      .where('paymentStatus', isEqualTo: '')
      .snapshots();

  var _razorpay = Razorpay();

  @override
  void initState() {
    // TODO: implement initState
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    // _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Do something when payment succeeds
    print('Payment Success');
    Fluttertoast.showToast(msg: 'Payment Success: ' + myName!);
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
        "paymentMethod": 'Online Payment',
        "paymentStatus": 'Payment Success',
      });
    });
    Get.off(HomeScreen());
    Fluttertoast.showToast(msg: 'Thanks for shopping...');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print('Payment Fail');
    Fluttertoast.showToast(msg: 'Failed to Payment');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Reflex Furniture"),
        content: Text("Oh no, your payment failed"),
        actions: [
          MaterialButton(
            child: Text("Try Again"),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  // void _handleExternalWallet(ExternalWalletResponse response) {
  //   // Do something when an external wallet is selected
  //   Fluttertoast.showToast(msg: 'Sucess Wallet payment');
  // }

  TextEditingController amountController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: color5254A8,
        title: Text(
          "Online Payment",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: color5254A8,
                border: Border.all(
                  width: 8,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  FutureBuilder(
                    future: _fetch(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done)
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ).paddingOnly(top: 20),
                        );
                      return Center(
                        child: CircleAvatar(
                          backgroundImage: myProfile == null || myProfile == ''
                              ? AssetImage('assets/icons/accountrb.png')
                                  as ImageProvider
                              : NetworkImage(myProfile!),
                          backgroundColor: colorFFCA27,
                          radius: 50,
                        ),
                      );
                    },
                  ).paddingOnly(top: 30),
                  FutureBuilder(
                    future: _fetch(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done)
                        return Text(
                          'Loading Data...Please Wait',
                          style: colorFFFFFFw80024,
                        ).paddingOnly(top: 30);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Name: ' + myName!,
                            style: colorFFFFFFw80024.copyWith(fontSize: 22),
                          ).paddingOnly(top: 30),
                          Text(
                            'Email: ' + myEmail!,
                            style: colorFFFFFFw50016.copyWith(fontSize: 15),
                          ).paddingOnly(top: 20),
                          Text(
                            myPhoneNum == null || myPhoneNum == ''
                                ? 'Phone Number : !! Not Found !!'
                                : myPhoneNum!,
                            style: colorFFFFFFw50016.copyWith(fontSize: 15),
                          ).paddingOnly(top: 20),
                        ],
                      );
                    },
                  ),
                  Text(
                    'Total Amount',
                    style: colorFFFFFFw50016.copyWith(fontSize: 15),
                  ).paddingOnly(top: 20),
                  Text(
                    rupees + ' ' + widget.paymentAmount.toString(),
                    style: colorFFFFFFw50016.copyWith(fontSize: 15),
                  ).paddingOnly(top: 5),
                  Text(
                    'Shipping Charge',
                    style: colorFFFFFFw50016.copyWith(fontSize: 15),
                  ).paddingOnly(top: 20),
                  Text(
                    rupees + ' ' + widget.paymentShippingCharge.toString(),
                    style: colorFFFFFFw50016.copyWith(fontSize: 15),
                  ).paddingOnly(top: 5),
                  Text(
                    'Discount (10%)',
                    style: colorFFFFFFw50016.copyWith(fontSize: 15),
                  ).paddingOnly(top: 20),
                  Text(
                    rupees + ' ' + widget.paymentDiscountValue.toString(),
                    style: colorFFFFFFw50016.copyWith(fontSize: 15),
                  ).paddingOnly(top: 5, bottom: 20),
                  // FutureBuilder(
                  //   future: _fetchReviewCart(),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.connectionState != ConnectionState.done)
                  //       return Text(
                  //         'Loading Data...Please Wait',
                  //         style: colorFFFFFFw80024,
                  //       ).paddingOnly(top: 30);
                  //     return Text(
                  //       'Name: ' + cartName!,
                  //       style: colorFFFFFFw80024.copyWith(fontSize: 22),
                  //     ).paddingOnly(top: 30);
                  //   },
                  // ),
                ],
              ),
            ).paddingAll(20),
            // StreamBuilder<QuerySnapshot>(
            //   stream: _cartStream,
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
            //       height: 300,
            //       child: ListView.builder(
            //         padding: const EdgeInsets.symmetric(horizontal: 10),
            //         scrollDirection: Axis.horizontal,
            //         itemCount: snapshot.data!.size,
            //         itemBuilder: (context, index) {
            //           final productData = snapshot.data!.docs[index];
            //           final firebaseUser = FirebaseAuth.instance.currentUser;
            //           cartId = productData['cartId'];
            //           cartImage = productData['cartImage'];
            //           cartName = productData['cartName'];
            //           paymentMethod = productData['paymentMethod'];
            //           paymentStatus = productData['paymentStatus'];
            //           cartPrice = productData['cartPrice'];
            //           cartQuantity = productData['cartQuantity'];
            //           return GestureDetector(
            //             onTap: () {},
            //             child: Container(
            //               width: 180,
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Image.network(productData['cartImage']),
            //                   Text(
            //                     productData['cartName'],
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
            //                     'Price: ' +
            //                         rupees +
            //                         productData['cartPrice'].toString(),
            //                     style: TextStyle(
            //                             color: Color(0xFF999999),
            //                             fontSize: 14,
            //                             fontWeight: FontWeight.w400,
            //                             fontFamily: 'Poppins')
            //                         .copyWith(fontSize: 18),
            //                   ).paddingOnly(top: 5),
            //                   Text(
            //                     'Quantity: ' +
            //                         productData['cartQuantity'].toString(),
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
            // ).paddingAll(20),
            Container(
              width: 160,
              height: 50,
              child: MaterialButton(
                onPressed: () async {
                  ///Make Payment
                  var options = {
                    'key': 'rzp_test_Iv5oyKJHohxjk5',
                    //Amount will be multiple of 100
                    // 'amount': 50000, // Amount in paisa = Rs/100
                    'amount': widget.paymentAmount * 100,
                    'name': myName,
                    'description': 'Demo Payment',
                    'timeout': 120, // in seconds
                    'prefill': {'contact': myPhoneNum, 'email': myEmail}
                  };
                  try {
                    _razorpay.open(options);
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text(
                  "Pay Amount",
                  style: TextStyle(
                    color: colorFFFFFF,
                  ),
                ),
                color: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _cartStream,
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

                return SizedBox(
                  height: 270,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.size,
                    itemBuilder: (context, index) {
                      final productData = snapshot.data!.docs[index];
                      final firebaseUser = FirebaseAuth.instance.currentUser;
                      img = productData['cartImage'];
                      id = productData['cartId'];
                      name = productData['cartName'];
                      price = productData['cartPrice'];
                      qun = productData['cartQuantity'];
                      // print("CartImage: " + img);
                      // print("CartId: " + id);
                      // print("CartName: " + name);
                      // print("CartPrice: " + price.toString());
                      // print("CartQun: " + qun.toString());
                      return Container().paddingOnly(left: 10);
                    },
                  ),
                );
              },
            ),
          ],
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
        myPhoneNum = ds.data()!['phoneNumber'];
        myProfile = ds.data()!['profile'];
        print(myName);
        print(myEmail);
        print(myPhoneNum);
        print(myProfile);
      }).catchError((e) {
        print(e);
      });
  }

  _fetchReviewCart() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null)
      await FirebaseFirestore.instance
          .collection('ReviewCart')
          .doc(firebaseUser.uid)
          .collection('YourReviewCart')
          .doc()
          .get()
          .then((ds) {
        cartImage = ds.data()!['cartImage'];
        cartName = ds.data()!['cartName'];
        cartPrice = ds.data()!['cartPrice'];
        cartQuantity = ds.data()!['cartQuantity'];
        print(myName);
        print(myEmail);
        print(myPhoneNum);
        print(myProfile);
      }).catchError((e) {
        print(e);
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _razorpay.clear();
    super.dispose();
  }
}
