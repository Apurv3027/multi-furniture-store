import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_furniture_store/config/colors.dart';
import 'package:multi_furniture_store/config/text.dart';
import 'package:multi_furniture_store/models/delivery_address_model.dart';
import 'package:multi_furniture_store/providers/review_cart_provider.dart';
import 'package:multi_furniture_store/screens/check_out/delivery_details/single_delivery_item.dart';
import 'package:multi_furniture_store/screens/check_out/payment_methods/online_payment.dart';
import 'package:multi_furniture_store/screens/check_out/payment_methods/razorpay.dart';
import 'package:multi_furniture_store/screens/check_out/payment_summary/order_item.dart';
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
  OnlinePayment,
}

class _PaymentSummaryState extends State<PaymentSummary> {
  var myType = AddressTypes.Cash_on_Delivery;

  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();

    double discount = 5;
    late double discountValue;
    double shippingCharge = 100;
    late double total;
    double totalPrice = reviewCartProvider.getTotalPrice();
    if (totalPrice > 300) {
      discountValue = (totalPrice * discount) / 100;
      shippingCharge = shippingCharge;
      total = totalPrice + shippingCharge - discountValue;
    }

    return Scaffold(
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
          rupees + total.toString(),
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
              myType == AddressTypes.OnlinePayment
                  ? Get.to(RazorPay(
                    paymentAmount: total.toInt(),
                  ))
                  // ? Get.to(OnlinePayment())
                  : Container();
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
                    rupees + discountValue.toString(),
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
                  value: AddressTypes.OnlinePayment,
                  groupValue: myType,
                  title: Text("OnlinePayment"),
                  onChanged: (value) {
                    setState(() {
                      myType = value!;
                    });
                  },
                  secondary: Icon(
                    Icons.devices_other_outlined,
                    color: primaryColor,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
