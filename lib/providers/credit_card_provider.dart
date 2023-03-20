import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:multi_furniture_store/models/credit_card_model.dart';

class CreditCardProvider with ChangeNotifier {
  void addCreditCardData({
    String? userId,
    String? cardHolderName,
    String? creditCardNumber,
    String? expiryDate,
    String? cvv,
  }) async {
    FirebaseFirestore.instance
        .collection("CreditCard")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourCreditCard")
        .doc()
        .set(
      {
        "userId": userId,
        "cardHolderName": cardHolderName,
        "creditCardNumber": creditCardNumber,
        "expiryDate": expiryDate,
        "cvv":cvv,
      },
    );
  }

  List<CreditCardModel> creditCardDataList = [];
  void getCreditCardData() async {
    List<CreditCardModel> newList = [];

    QuerySnapshot creditCardValue = await FirebaseFirestore.instance
        .collection("CreditCard")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourCreditCard")
        .get();
    creditCardValue.docs.forEach((element) {
      CreditCardModel creditCardModel = CreditCardModel(
        userId: element.get('userId'),
        cardHolderName: element.get('cardHolderName'),
        creditCardNumber: element.get('creditCardNumber'),
        expiryDate: element.get('expiryDate'),
        cvv: element.get('cvv'),
      );
      newList.add(creditCardModel);
    });
    creditCardDataList = newList;
    notifyListeners();
  }

  List<CreditCardModel> get getCreditCardDataList {
    return creditCardDataList;
  }

////////////// CreditCardDeleteFunction ////////////
  creditCardDataDelete(creditCardId) {
    FirebaseFirestore.instance
        .collection("CreditCard")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourCreditCard")
        .doc(creditCardId)
        .delete();
    notifyListeners();
  }
}