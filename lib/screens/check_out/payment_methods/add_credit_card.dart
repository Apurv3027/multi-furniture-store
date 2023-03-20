import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:multi_furniture_store/config/colors.dart';
import 'package:multi_furniture_store/screens/check_out/payment_methods/components/build_credit_card.dart';
import 'package:multi_furniture_store/screens/check_out/payment_methods/components/card_data_input_formatter.dart';
import 'package:multi_furniture_store/screens/check_out/payment_methods/components/card_input_formatter.dart';
import 'package:multi_furniture_store/screens/check_out/payment_methods/components/my_painter.dart';
import 'package:multi_furniture_store/screens/check_out/payment_methods/online_payment.dart';
import 'package:provider/provider.dart';

class AddCreditCard extends StatefulWidget {
  const AddCreditCard({Key? key}) : super(key: key);

  @override
  State<AddCreditCard> createState() => _AddCreditCardState();
}

class _AddCreditCardState extends State<AddCreditCard> {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardHolderNameController =
      TextEditingController();
  final TextEditingController cardExpiryDateController =
      TextEditingController();
  final TextEditingController cardCvvController = TextEditingController();

  final FlipCardController flipCardController = FlipCardController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  uploadCreditCard() async{
    if(_formKey.currentState!.validate()) {
      await _firestore.collection("CreditCard")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("YourCreditCard")
          .doc()
          .set({
        "userId": FirebaseAuth.instance.currentUser!.uid,
        "cardHolderName": cardHolderNameController.text,
        "creditCardNumber":  cardNumberController.text,
        "expiryDate": cardExpiryDateController.text,
        "cvv": cardCvvController.text,
      }).whenComplete(() {
        setState(() {
          _formKey.currentState!.reset();
          print('Success');
        });
      });
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Successfully...'),
        content: Text('Your credit card added successfully...'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              Get.back();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  String? cardHolderName;
  String? creditCardNumber;
  String? cvv;
  String? expiryDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorFFFFFF,
      appBar: AppBar(
        backgroundColor: color5254A8,
        title: Text(
          "Add Credit Card",
          style: TextStyle(color: colorFFFFFF, fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FlipCard(
                  fill: Fill.fillFront,
                  direction: FlipDirection.HORIZONTAL,
                  controller: flipCardController,
                  flipOnTouch: true,
                  front: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: buildCreditCard(
                      color: Color(0xFF090943),
                      cardExpiration: cardExpiryDateController.text.isEmpty
                          ? "MM/YYYY"
                          : cardExpiryDateController.text,
                      cardHolder: cardHolderNameController.text.isEmpty
                          ? "Card Holder"
                          : cardHolderNameController.text.toUpperCase(),
                      cardNumber: cardNumberController.text.isEmpty
                          ? "XXXX XXXX XXXX XXXX"
                          : cardNumberController.text,
                    ),
                  ),
                  back: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Card(
                      elevation: 4.0,
                      color: Color(0xFF090943),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Container(
                        height: 230,
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 22.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(height: 0),
                            const Text(
                              'https://www.paypal.com',
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 11,
                              ),
                            ),
                            Container(
                              height: 45,
                              width: MediaQuery.of(context).size.width / 1.2,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            CustomPaint(
                              painter: MyPainter(),
                              child: SizedBox(
                                height: 35,
                                width: MediaQuery.of(context).size.width / 1.2,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      cardCvvController.text.isEmpty
                                          ? "***"
                                          : cardCvvController.text,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 21,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.',
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 11,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ).paddingOnly(top: 30),
                Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width / 1.12,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextFormField(
                    controller: cardNumberController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if(value!.isEmpty){
                        return 'Please Enter Card Number';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      hintText: 'Card Number',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      prefixIcon: Icon(
                        Icons.credit_card,
                        color: Colors.grey,
                      ),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(16),
                      CardInputFormatter(),
                    ],
                    onChanged: (value) {
                      creditCardNumber = value;
                      var text = value.replaceAll(RegExp(r'\s+\b|\b\s'), ' ');
                      setState(() {
                        cardNumberController.value = cardNumberController.value
                            .copyWith(
                                text: text,
                                selection:
                                    TextSelection.collapsed(offset: text.length),
                                composing: TextRange.empty);
                      });
                    },
                  ),
                ).paddingOnly(top: 40),
                Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width / 1.12,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextFormField(
                    controller: cardHolderNameController,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if(value!.isEmpty){
                        return 'Please Enter Card Holder Name';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      hintText: 'Full Name',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                    ),
                    onChanged: (value) {
                      cardHolderName = value;
                      setState(() {
                        cardHolderNameController.value =
                            cardHolderNameController.value.copyWith(
                                text: value,
                                selection:
                                    TextSelection.collapsed(offset: value.length),
                                composing: TextRange.empty);
                      });
                    },
                  ),
                ).paddingOnly(top: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width / 2.4,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        controller: cardExpiryDateController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if(value!.isEmpty){
                            return 'Please Enter Expiry Date';
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          hintText: 'MM/YY',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                          prefixIcon: Icon(
                            Icons.calendar_today,
                            color: Colors.grey,
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(4),
                          CardDateInputFormatter(),
                        ],
                        onChanged: (value) {
                          expiryDate = value;
                          var text = value.replaceAll(RegExp(r'\s+\b|\b\s'), ' ');
                          setState(() {
                            cardExpiryDateController.value =
                                cardExpiryDateController.value.copyWith(
                                    text: text,
                                    selection: TextSelection.collapsed(
                                        offset: text.length),
                                    composing: TextRange.empty);
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 14),
                    Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width / 2.4,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        controller: cardCvvController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if(value!.isEmpty){
                            return 'Please Enter CVV Number';
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          hintText: 'CVV',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3),
                        ],
                        onTap: () {
                          setState(() {
                            Future.delayed(const Duration(milliseconds: 300), () {
                              flipCardController.toggleCard();
                            });
                          });
                        },
                        onChanged: (value) {
                          cvv = value;
                          setState(() {
                            int length = value.length;
                            if (length == 4 || length == 9 || length == 14) {
                              cardNumberController.text = '$value ';
                              cardNumberController.selection =
                                  TextSelection.fromPosition(
                                      TextPosition(offset: value.length + 1));
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ).paddingOnly(top: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepPurpleAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minimumSize:
                        Size(MediaQuery.of(context).size.width / 1.12, 55),
                  ),
                  onPressed: () {
                    uploadCreditCard();
                    // creditCardProvider.addCreditCardData(
                    //   cardHolderName: cardHolderName,
                    //   creditCardNumber: creditCardNumber,
                    //   cvv: cvv,
                    //   expiryDate: expiryDate,
                    //   userId: FirebaseAuth.instance.currentUser!.uid,
                    //   userEmail: FirebaseAuth.instance.currentUser!.email,
                    //   userName: FirebaseAuth.instance.currentUser!.displayName,
                    // );
                    // Future.delayed(const Duration(milliseconds: 300), () {
                    //   showDialog(
                    //     context: context,
                    //     builder: (context) => AlertDialog(
                    //       content: Stack(
                    //         clipBehavior: Clip.none,
                    //         children: [
                    //           Positioned(
                    //             right: 80.0,
                    //             top: -90.0,
                    //             child: Image.asset(
                    //               'assets/icons/checked.png',
                    //               height: 90,
                    //               width: 90,
                    //             ),
                    //           ),
                    //           Positioned(
                    //             right: -40.0,
                    //             top: -40.0,
                    //             child: InkResponse(
                    //               onTap: () {
                    //                 Navigator.of(context).pop();
                    //               },
                    //               child: const CircleAvatar(
                    //                 backgroundColor: Colors.red,
                    //                 child: Icon(Icons.close, color: Colors.white),
                    //               ),
                    //             ),
                    //           ),
                    //           Column(
                    //             mainAxisSize: MainAxisSize.min,
                    //             children: const [
                    //               Padding(
                    //                 padding: EdgeInsets.all(8.0),
                    //                 child: Text(
                    //                   'Card Added Successfully',
                    //                   style: TextStyle(
                    //                     fontSize: 20,
                    //                     fontWeight: FontWeight.bold,
                    //                     color: Colors.green,
                    //                   ),
                    //                 ),
                    //               ),
                    //               Padding(
                    //                 padding: EdgeInsets.all(8.0),
                    //                 child: Text(
                    //                   'You can now use your card to make payments',
                    //                   style: TextStyle(
                    //                       fontSize: 16,
                    //                       fontWeight: FontWeight.w600),
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   );
                    //   cardCvvController.clear();
                    //   cardExpiryDateController.clear();
                    //   cardHolderNameController.clear();
                    //   cardNumberController.clear();
                    //   flipCardController.toggleCard();
                    // });
                  },
                  child: Text(
                    'Add Card'.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ).paddingOnly(top: 20*3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
