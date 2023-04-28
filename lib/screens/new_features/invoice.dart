import 'package:flutter/material.dart';
import 'package:Reflex_Furniture/config/colors.dart';
import 'package:Reflex_Furniture/config/text.dart';
import 'package:Reflex_Furniture/providers/review_cart_provider.dart';
import 'package:Reflex_Furniture/screens/check_out/payment_summary/order_item.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Invoice extends StatelessWidget {
  final String orderId;
  final String customerName;
  final String customerEmail;
  final double totalAmount;
  final double totalPrice;
  final double shippingCharge;
  final double discountPrice;

  Invoice({
    required this.orderId,
    required this.customerName,
    required this.customerEmail,
    required this.totalAmount,
    required this.totalPrice,
    required this.shippingCharge,
    required this.discountPrice,
  });

  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();
    return Scaffold(
      backgroundColor: colorFFFFFF,
      appBar: AppBar(
        backgroundColor: color5254A8,
        title: Text('Invoice Summary'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/icons/reflex-furniture-rb.png'),
                  backgroundColor: color5254A8,
                  radius: 50,
                ),
              ),
              Text(
                'Order Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ).paddingOnly(top: 10),
              SizedBox(height: 10),
              Text('Invoice ID: $orderId'),
              SizedBox(height: 10),
              Text('Customer Name: $customerName'),
              SizedBox(height: 10),
              Text('Customer Email: $customerEmail'),
              SizedBox(height: 20),
              ExpansionTile(
                initiallyExpanded: true,
                children: reviewCartProvider.getReviewCartDataList.map(
                  (e) {
                    return OrderItem(
                      e: e,
                    );
                  },
                ).toList(),
                title: Text(
                  "Order Items ${reviewCartProvider.getReviewCartDataList.length}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
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
              // Add your list of items here
              SizedBox(height: 20),
              Text(
                'Total Amount: ' + rupees + '$totalAmount',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
