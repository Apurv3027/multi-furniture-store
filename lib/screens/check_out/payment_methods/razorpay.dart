import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_furniture_store/config/text.dart';
import 'package:multi_furniture_store/screens/new_features/refer_a_friends.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:get/get.dart';
import 'package:multi_furniture_store/config/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:multi_furniture_store/config/text_style.dart';

class RazorPay extends StatefulWidget {
  final int paymentAmount;
  RazorPay({
    required this.paymentAmount,
  });

  @override
  State<RazorPay> createState() => _RazorPayState();
}

class _RazorPayState extends State<RazorPay> {
  String? myEmail;
  String? myName;
  String? myPhoneNum;
  String? myProfile;

  var _razorpay = Razorpay();

  @override
  void initState() {
    // TODO: implement initState
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print('Payment Success');
    Fluttertoast.showToast(msg: 'Success');
    Get.to(ReferFriends());
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print('Payment Fail');
    Fluttertoast.showToast(msg: 'Failure' + response.code.toString());
    Get.back();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
    Fluttertoast.showToast(msg: 'Sucess Wallet payment');
  }

  TextEditingController amountController = TextEditingController();

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
      body: Column(
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
                          // 'Phone Number: ' + myPhoneNum!,
                          myPhoneNum == null || myPhoneNum == ''
                              ? 'Phone Number Not Found'
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
                ).paddingOnly(top: 5, bottom: 20),
              ],
            ),
          ).paddingAll(20),
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
                  'name': 'Apurv Patel',
                  'description': 'Demo Payment',
                  'timeout': 120, // in seconds
                  'prefill': {
                    'contact': '4589745623',
                    'email': 'demo.pay@gmail.com'
                  }
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
          // CupertinoButton(
          //   color: Colors.grey,
          //   child: Text('Pay Amount'),
          //   onPressed: () async {
          //     ///Make Payment
          //     var options = {
          //       'key': 'rzp_test_Iv5oyKJHohxjk5',
          //       //Amount will be multiple of 100
          //       // 'amount': 50000, // Amount in paisa = Rs/100
          //       'amount': widget.paymentAmount * 100,
          //       'name': 'Apurv Patel',
          //       'description': 'Demo Payment',
          //       'timeout': 120, // in seconds
          //       'prefill': {
          //         'contact': '4589745623',
          //         'email': 'demo.pay@gmail.com'
          //       }
          //     };
          //     try {
          //       _razorpay.open(options);
          //     } catch (e) {
          //       print(e);
          //     }
          //   },
          // ),
        ],
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

  @override
  void dispose() {
    // TODO: implement dispose
    _razorpay.clear();
    super.dispose();
  }
}
