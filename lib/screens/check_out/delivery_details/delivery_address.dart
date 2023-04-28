import 'package:flutter/material.dart';
import 'package:Reflex_Furniture/config/colors.dart';
import 'package:Reflex_Furniture/models/delivery_address_model.dart';
import 'package:Reflex_Furniture/providers/check_out_provider.dart';
import 'package:Reflex_Furniture/screens/check_out/add_delivery_address/add_delivery_address.dart';
import 'package:Reflex_Furniture/screens/check_out/delivery_details/single_delivery_item.dart';
import 'package:provider/provider.dart';

class DeliveryAddress extends StatefulWidget {
  @override
  _DeliveryAddressState createState() => _DeliveryAddressState();
}

class _DeliveryAddressState extends State<DeliveryAddress> {
  late DeliveryAddressModel value;
  @override
  Widget build(BuildContext context) {
    CheckoutProvider deliveryAddressProvider = Provider.of(context);
    deliveryAddressProvider.getDeliveryAddressData();
    return Scaffold(
      backgroundColor: colorFFFFFF,
      appBar: AppBar(
        backgroundColor: color5254A8,
        title: Text("Delivery Address"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddDeliverAddress(),
            ),
          );
        },
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(
              Icons.location_on_outlined,
              size: 30,
            ),
            title: Text(
              "My Delivery Address",
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
                      value = e;
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
