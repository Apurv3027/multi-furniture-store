import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:multi_furniture_store/config/colors.dart';
import 'package:multi_furniture_store/config/common_text_field.dart';
import 'package:multi_furniture_store/config/text.dart';
import 'package:multi_furniture_store/models/delivery_address_model.dart';
import 'package:multi_furniture_store/providers/review_cart_provider.dart';
import 'package:multi_furniture_store/screens/check_out/delivery_details/single_delivery_item.dart';
import 'package:multi_furniture_store/screens/check_out/payment_methods/razorpay.dart';
import 'package:multi_furniture_store/screens/check_out/payment_summary/order_item.dart';
import 'package:multi_furniture_store/screens/new_features/confirm_order.dart';
import 'package:multi_furniture_store/screens/new_features/invoice.dart';
import 'package:multi_furniture_store/service/coupon_service.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentSummary extends StatefulWidget {
  final DeliveryAddressModel deliverAddressList;
  PaymentSummary({required this.deliverAddressList});

  @override
  _PaymentSummaryState createState() => _PaymentSummaryState();
}

enum AddressTypes {
  Cash_on_Delivery,
  Online_Payment,
}

class _PaymentSummaryState extends State<PaymentSummary> {
  var myType = AddressTypes.Cash_on_Delivery;

  TextEditingController couponController = TextEditingController();

  String? userEmail;
  String? userName;
  String? buyerId;

  final Stream<QuerySnapshot> _buyersStream =
      FirebaseFirestore.instance.collection('buyers').snapshots();

  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();

    final couponService = CouponService();
    late String couponCode = '';
    final isCoupon = couponController.text.toString();

    double discount = 10;
    late double discountAmount = 0;
    late double discountPrice = 0;
    double shippingCharge = 100;
    double totalPrice = reviewCartProvider.getTotalPrice();
    double? totalAmount;
    late double discountValue = 0;

    couponCodeDis() {
      if (couponService.isCouponValid(couponController.text.toString())) {
        discountValue = couponService.calculateDiscount(
            couponController.text.toString(), totalPrice);
        print("Discount: " + discountValue.toString());
        // final total = totalPrice - discountValue + shippingCharge;
        setState(() {
          discountPrice = discountValue;
          print("dis" + discountPrice.toString());
        });
        // final total = totalPrice - discountValue;
        // total = totalPrice + shippingCharge - discountValue;
        // Display the discounted price to the user
      } else {
        // Display an error message to the user
        Fluttertoast.showToast(msg: 'Coupon Code is not valid...');
        // if (totalPrice > 300) {
        //   discountValue = (totalPrice * discount) / 100;
        //   shippingCharge = shippingCharge;
        //   total = totalPrice + shippingCharge - discountValue;
        // }
      }
      print("Total Price: " + totalPrice.toString());
      print("Total Discount: " + discountValue.toString());
      print("Shipping Charge: " + shippingCharge.toString());
      // print("Total: " + total.toString());
      // print("Total Amount: " + totalAmount.toString());
      print("Total Discount: " + discountPrice.toString());
    }

    if (totalPrice > 300) {
      print(couponController.text.toString());
      // if (isCoupon != null) {
      //   print(couponController.text.toString());
      // } else {}
      discountPrice = (totalPrice * discount) / 100;
      shippingCharge = shippingCharge;
      totalAmount = totalPrice - discountPrice + shippingCharge;
    }

    // if (couponService.isCouponValid(couponController.text.toString())) {
    //   final discountValue = couponService.calculateDiscount(
    //       couponController.text.toString(), totalPrice);
    //   final total = totalPrice - discountValue + shippingCharge;
    //   discountPrice = discountValue;
    //   totalAmount = total;
    // } else {
    //   discountPrice = (totalPrice * discount) / 100;
    //   shippingCharge = shippingCharge;
    //   totalAmount = totalPrice - discountPrice + shippingCharge;
    // }

    return Scaffold(
      backgroundColor: colorFFFFFF,
      appBar: AppBar(
        backgroundColor: color5254A8,
        title: Text(
          "Payment Summary",
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: ListTile(
        title: Text("Total Amount"),
        subtitle: Text(
          rupees + totalAmount.toString(),
          style: TextStyle(
            color: Colors.green[900],
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        trailing: Container(
          width: 160,
          child: MaterialButton(
            onPressed: () {
              myType == AddressTypes.Online_Payment
                  ? Get.to(RazorPay(
                      paymentAmount: totalAmount!.toInt(),
                      paymentDiscountValue: discount.toInt(),
                      paymentShippingCharge: shippingCharge.toInt(),
                    ))
                  // ? Get.to(OnlinePayment())
                  : Get.to(ConfirmOrder());
            },
            child: Text(
              "Place Order",
              style: TextStyle(
                color: colorFFFFFF,
              ),
            ),
            color: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Column(
              children: [
                SingleDeliveryItem(
                  address:
                      "${widget.deliverAddressList.aera}, ${widget.deliverAddressList.street}, ${widget.deliverAddressList.scoirty}, \npincode - ${widget.deliverAddressList.pinCode}",
                  title:
                      "${widget.deliverAddressList.firstName} ${widget.deliverAddressList.lastName}",
                  number: widget.deliverAddressList.mobileNo,
                  addressType: widget.deliverAddressList.addressType ==
                          "AddressTypes.Home"
                      ? "Home"
                      : widget.deliverAddressList.addressType ==
                              "AddressTypes.Other"
                          ? "Other"
                          : "Work",
                ),
                Divider(),
                ExpansionTile(
                  // children: reviewCartProvider.getReviewCartDataList.map((e) {
                  //   return OrderItem(
                  //     e: e,
                  //   );
                  // }).toList(),
                  children: reviewCartProvider.getReviewCartDataList.map(
                    (e) {
                      return OrderItem(
                        e: e,
                      );
                    },
                  ).toList(),
                  title: Text(
                      "Order Items ${reviewCartProvider.getReviewCartDataList.length}"),
                ),
                // Divider(),
                // ListTile(
                //   leading: SizedBox(
                //     width: 250,
                //     // child: TextField(
                //     //   controller: couponController,
                //     //   decoration: InputDecoration(
                //     //     border: OutlineInputBorder(),
                //     //     labelText: 'Coupon Code',
                //     //   ),
                //     //   onChanged: (value) {
                //     //     couponCode = value;
                //     //   },
                //     // ),
                //     child: TextFormField(
                //       controller: couponController,
                //       decoration: InputDecoration(
                //         labelText: 'Coupon code',
                //         border: OutlineInputBorder(),
                //       ),
                //     ),
                //   ),
                //   trailing: Container(
                //     width: 100,
                //     child: MaterialButton(
                //       onPressed: () {
                //         print(couponController.text.toString());
                //         couponCodeDis();
                //       },
                //       child: Text(
                //         "Apply",
                //         style: TextStyle(
                //           color: colorFFFFFF,
                //         ),
                //       ),
                //       color: primaryColor,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(30),
                //       ),
                //     ),
                //   ),
                // ),
                Divider(),
                ListTile(
                  minVerticalPadding: 5,
                  leading: Text(
                    "Sub Total",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    rupees + totalPrice.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  minVerticalPadding: 5,
                  leading: Text(
                    "Shipping Charge",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  trailing: Text(
                    rupees + shippingCharge.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  minVerticalPadding: 5,
                  leading: Text(
                    "Compen Discount",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  trailing: Text(
                    rupees + discountPrice.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Text("Payment Options"),
                ),
                RadioListTile(
                  value: AddressTypes.Cash_on_Delivery,
                  groupValue: myType,
                  title: Text("Cash on Delivery"),
                  onChanged: (value) {
                    setState(() {
                      myType = value!;
                    });
                  },
                  secondary: Icon(
                    Icons.money_outlined,
                    color: primaryColor,
                  ),
                ),
                RadioListTile(
                  value: AddressTypes.Online_Payment,
                  groupValue: myType,
                  title: Text("Online Payment"),
                  onChanged: (value) {
                    setState(() {
                      myType = value!;
                    });
                  },
                  secondary: Icon(
                    Icons.devices_other_outlined,
                    color: primaryColor,
                  ),
                ),
                Divider(),
                StreamBuilder<QuerySnapshot>(
                  stream: _buyersStream,
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

                    final buyersData = snapshot.data!.docs[index];

                    return TextButton(
                      onPressed: () {
                        Get.to(
                          Invoice(
                            orderId: buyersData['buyerId'],
                            customerName: buyersData['fullName'],
                            customerEmail: buyersData['email'],
                            totalAmount: totalAmount!.toDouble(),
                            totalPrice: totalPrice,
                            shippingCharge: shippingCharge,
                            discountPrice: discountPrice,
                          ),
                        );
                      },
                      child: Text('Generate Invoice'),
                    );
                  },
                ),
              ],
            );
          },
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
        userEmail = ds.data()!['email'];
        userName = ds.data()!['fullName'];
        buyerId = ds.data()!['buyerId'];
        print(userName);
        print(userEmail);
        print(buyerId);
      }).catchError((e) {
        print(e);
      });
  }
}
