import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_furniture_store/config/colors.dart';
import 'package:multi_furniture_store/models/credit_card_model.dart';
import 'package:multi_furniture_store/providers/credit_card_provider.dart';
import 'package:multi_furniture_store/providers/review_cart_provider.dart';
import 'package:multi_furniture_store/screens/check_out/payment_methods/add_credit_card.dart';
import 'package:multi_furniture_store/screens/check_out/payment_methods/components/build_credit_card.dart';
import 'package:multi_furniture_store/screens/check_out/payment_methods/components/my_painter.dart';
import 'package:multi_furniture_store/screens/new_features/refer_a_friends.dart';
import 'package:provider/provider.dart';

class OnlinePayment extends StatefulWidget {
  @override
  State<OnlinePayment> createState() => _OnlinePaymentState();
}

class _OnlinePaymentState extends State<OnlinePayment> {
  late CreditCardProvider creditCardProvider;
  late CreditCardModel value;

  late ReviewCartProvider reviewCartProvider;

  String? cardHolderName;
  String? creditCardNumber;
  String? cvv;
  String? expiryDate;

  final Stream<QuerySnapshot> _creditCardStream = FirebaseFirestore.instance
      .collection('CreditCard')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('YourCreditCard')
      .snapshots();

  final FlipCardController flipCardController = FlipCardController();

  @override
  Widget build(BuildContext context) {
    creditCardProvider = Provider.of<CreditCardProvider>(context);
    creditCardProvider.getCreditCardData();
    return Scaffold(
      bottomNavigationBar: Container(
        // width: 160,
        height: 48,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: MaterialButton(
          child: creditCardProvider.getCreditCardDataList.isEmpty
              ? Text(
                  "Add new Credit Card",
                  style: TextStyle(color: colorFFFFFF),
                )
              : Text(
                  "Make Payment",
                  style: TextStyle(color: colorFFFFFF),
                ),
          onPressed: () {
            creditCardProvider.getCreditCardDataList.isEmpty
                ? Get.to(AddCreditCard())
                : Get.to(ReferFriends());
          },
          color: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              30,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: color5254A8,
        title: Text(
          "Online Payment",
          style: TextStyle(color: colorFFFFFF, fontSize: 18),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(AddCreditCard());
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(
                Icons.payment_outlined,
                size: 30,
              ),
              title: Text(
                "Select Your Card for Payment",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(
              height: 1,
            ),
            creditCardProvider.getCreditCardDataList.isEmpty
                ? Center(
                    child: Container(
                      child: Center(
                        child: Text("No Data"),
                      ),
                    ),
                  )
                : StreamBuilder<QuerySnapshot>(
                    stream: _creditCardStream,
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
                        height: 600,
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(top: 10),
                          scrollDirection: Axis.vertical,
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            final creditCardData = snapshot.data!.docs[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FlipCard(
                                  fill: Fill.fillFront,
                                  direction: FlipDirection.HORIZONTAL,
                                  controller: flipCardController,
                                  flipOnTouch: true,
                                  front: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: buildCreditCard(
                                      color: Color(0xFF090943),
                                      cardExpiration:
                                          creditCardData['expiryDate'],
                                      cardHolder:
                                          creditCardData['cardHolderName'],
                                      cardNumber:
                                          creditCardData['creditCardNumber'],
                                    ),
                                  ),
                                  back: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Card(
                                      elevation: 3.0,
                                      color: Color(0xFF090943),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      child: Container(
                                        height: 230,
                                        padding: const EdgeInsets.only(
                                            left: 16.0,
                                            right: 16.0,
                                            bottom: 22.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.2,
                                              decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                            ),
                                            CustomPaint(
                                              painter: MyPainter(),
                                              child: SizedBox(
                                                height: 35,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1.2,
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      creditCardData['cvv'],
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
                              ],
                            );
                            // return GestureDetector(
                            //   onTap: () {},
                            //   child: Container(
                            //     width: 180,
                            //     child: Column(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         Image.network(creditCardData['image']),
                            //         Text(
                            //           creditCardData['productName'],
                            //           style: TextStyle(color: Color(0xFF000000), fontSize: 20, fontWeight: FontWeight.w500, fontFamily: 'Poppins').copyWith(),
                            //           overflow: TextOverflow.ellipsis,
                            //           maxLines: 2,
                            //         ).paddingOnly(top: 10),
                            //         Text(
                            //           rupees + creditCardData['productPrice'].toString(),
                            //           style: TextStyle(color: Color(0xFF999999), fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'Poppins').copyWith(fontSize: 18),
                            //         ).paddingOnly(top: 5),
                            //       ],
                            //     ).paddingOnly(top: 10),
                            //   ),
                            // ).paddingOnly(left: 10);
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
}
