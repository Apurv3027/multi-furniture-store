import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';
import 'package:Reflex_Furniture/models/delivery_address_model.dart';
import 'package:Reflex_Furniture/models/review_cart_model.dart';

class CheckoutProvider with ChangeNotifier {
  bool isloadding = false;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController alternateMobileNo = TextEditingController();
  TextEditingController scoiety = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController aera = TextEditingController();
  TextEditingController pincode = TextEditingController();
  LocationData? setLoaction;

  void validator(context, myType) async {
    if (firstName.text.isEmpty) {
      Fluttertoast.showToast(msg: "firstname is empty");
    } else if (lastName.text.isEmpty) {
      Fluttertoast.showToast(msg: "lastname is empty");
    } else if (mobileNo.text.isEmpty) {
      Fluttertoast.showToast(msg: "mobileNo is empty");
    } else if (alternateMobileNo.text.isEmpty) {
      Fluttertoast.showToast(msg: "alternateMobileNo is empty");
    } else if (scoiety.text.isEmpty) {
      Fluttertoast.showToast(msg: "scoiety is empty");
    } else if (street.text.isEmpty) {
      Fluttertoast.showToast(msg: "street is empty");
    } else if (landmark.text.isEmpty) {
      Fluttertoast.showToast(msg: "landmark is empty");
    } else if (city.text.isEmpty) {
      Fluttertoast.showToast(msg: "city is empty");
    } else if (aera.text.isEmpty) {
      Fluttertoast.showToast(msg: "aera is empty");
    } else if (pincode.text.isEmpty) {
      Fluttertoast.showToast(msg: "pincode is empty");
    }
    // else if (setLoaction == null) {
    //   Fluttertoast.showToast(msg: "setLoaction is empty");
    // }
    else {
      String? addressId;
      isloadding = true;
      notifyListeners();
      await FirebaseFirestore.instance
          .collection("AddDeliverAddress")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("YourDeliverAddress")
          .doc(addressId)
          .set({
        "addressId": addressId.toString(),
        "firstname": firstName.text,
        "lastname": lastName.text,
        "mobileNo": mobileNo.text,
        "alternateMobileNo": alternateMobileNo.text,
        "scoiety": scoiety.text,
        "street": street.text,
        "landmark": landmark.text,
        "city": city.text,
        "aera": aera.text,
        "pincode": pincode.text,
        "addressType": myType.toString(),
      }).then((value) async {
        isloadding = false;
        notifyListeners();
        await Fluttertoast.showToast(msg: "Add your deliver address");
        Navigator.of(context).pop();
        notifyListeners();
      });
      notifyListeners();
    }
  }

  List<DeliveryAddressModel> deliveryAdressList = [];
  getDeliveryAddressData() async {
    List<DeliveryAddressModel> newList = [];

    DeliveryAddressModel deliveryAddressModel;
    QuerySnapshot _db = await FirebaseFirestore.instance
        .collection("AddDeliverAddress")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourDeliverAddress")
        .get();

    _db.docs.forEach(
      (element) {
        DeliveryAddressModel deliveryAddressModel = DeliveryAddressModel(
          firstName: element.get("firstname"),
          lastName: element.get("lastname"),
          addressType: element.get("addressType"),
          aera: element.get("aera"),
          alternateMobileNo: element.get("alternateMobileNo"),
          city: element.get("city"),
          landMark: element.get("landmark"),
          mobileNo: element.get("mobileNo"),
          pinCode: element.get("pincode"),
          scoirty: element.get("scoiety"),
          street: element.get("street"),
        );
        newList.add(deliveryAddressModel);
      },
    );

    // if (_db.exists) {
    //   deliveryAddressModel = DeliveryAddressModel(
    //     firstName: _db.get("firstname"),
    //     lastName: _db.get("lastname"),
    //     addressType: _db.get("addressType"),
    //     aera: _db.get("aera"),
    //     alternateMobileNo: _db.get("alternateMobileNo"),
    //     city: _db.get("city"),
    //     landMark: _db.get("landmark"),
    //     mobileNo: _db.get("mobileNo"),
    //     pinCode: _db.get("pincode"),
    //     scoirty: _db.get("scoiety"),
    //     street: _db.get("street"),
    //   );
    //   newList.add(deliveryAddressModel);
    //   notifyListeners();
    // }

    deliveryAdressList = newList;
    notifyListeners();
  }

  List<DeliveryAddressModel> get getDeliveryAddressList {
    return deliveryAdressList;
  }

////// Order /////////

  addPlaceOderData({
    List<ReviewCartModel>? oderItemList,
    var subTotal,
    var address,
    var shipping,
  }) async {
    FirebaseFirestore.instance
        .collection("Order")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("MyOrders")
        .doc()
        .set(
      {
        "subTotal": "1234",
        "Shipping Charge": "",
        "Discount": "10",
        "orderItems": oderItemList!
            .map((e) => {
                  "orderTime": DateTime.now(),
                  "orderImage": e.cartImage,
                  "orderName": e.cartName,
                  "orderPrice": e.cartPrice,
                  "orderQuantity": e.cartQuantity
                })
            .toList(),
        // "address": address
        //     .map((e) => {
        //           "orderTime": DateTime.now(),
        //           "orderImage": e.cartImage,
        //           "orderName": e.cartName,
        //           "orderUnit": e.cartUnit,
        //           "orderPrice": e.cartPrice,
        //           "orderQuantity": e.cartQuantity
        //         })
        //     .toList(),
      },
    );
  }
}
