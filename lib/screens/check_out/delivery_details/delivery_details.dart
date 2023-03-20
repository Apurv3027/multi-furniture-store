import 'package:flutter/material.dart';
import 'package:multi_furniture_store/config/colors.dart';
import 'package:multi_furniture_store/models/delivery_address_model.dart';
import 'package:multi_furniture_store/providers/check_out_provider.dart';
import 'package:multi_furniture_store/screens/check_out/add_delivery_address/add_delivery_address.dart';
import 'package:multi_furniture_store/screens/check_out/delivery_details/single_delivery_item.dart';
import 'package:multi_furniture_store/screens/check_out/payment_summary/payment_summary.dart';
import 'package:provider/provider.dart';

class DeliveryDetails extends StatefulWidget {
  @override
  _DeliveryDetailsState createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  late DeliveryAddressModel value;
  @override
  Widget build(BuildContext context) {
    CheckoutProvider deliveryAddressProvider = Provider.of(context);
    deliveryAddressProvider.getDeliveryAddressData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color5254A8,
        title: Text("Delivery Details"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddDeliverAddress(

              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        // width: 160,
        height: 48,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: MaterialButton(
          child: deliveryAddressProvider.getDeliveryAddressList.isEmpty
              ? Text(
            "Add new Address",
            style: TextStyle(color: colorFFFFFF),
          )
              : Text(
            "Payment Summary",
            style: TextStyle(color: colorFFFFFF),
          ),
          onPressed: () {
            deliveryAddressProvider.getDeliveryAddressList.isEmpty
                ? Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddDeliverAddress(),
              ),
            )
                : Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PaymentSummary(
                  deliverAddressList: value,
                ),
              ),
            );
          },
          color: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              30,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(
              Icons.map_outlined,
              size: 30,
            ),
            title: Text(
              "Deliver To",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(
            height: 1,
          ),
          deliveryAddressProvider.getDeliveryAddressList.isEmpty
              ? Center(
            child: Container(
              child: Center(
                child: Text("No Data"),
              ),
            ),
          )
              : Column(
            children: deliveryAddressProvider.getDeliveryAddressList
                .map<Widget>((e) {
              setState(() {
                value  = e;
              });
              return SingleDeliveryItem(
                address:
                "${e.aera}, ${e.street}, ${e.scoirty}, \npincode - ${e.pinCode}",
                title: "${e.firstName} ${e.lastName}",
                number: e.mobileNo,
                addressType: e.addressType == "AddressTypes.Home"
                    ? "Home"
                    : e.addressType == "AddressTypes.Other"
                    ? "Other"
                    : "Work",
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}