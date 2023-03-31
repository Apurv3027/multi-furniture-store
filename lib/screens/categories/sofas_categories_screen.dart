import 'package:multi_furniture_store/config/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:multi_furniture_store/config/text.dart';

class SofasCategoriesScreen extends StatefulWidget {
  const SofasCategoriesScreen({super.key});

  @override
  State<SofasCategoriesScreen> createState() => _SofasCategoriesScreenState();
}

class _SofasCategoriesScreenState extends State<SofasCategoriesScreen> {
  final Stream<QuerySnapshot> _tablesCategorieStream = FirebaseFirestore
      .instance
      .collection('products')
      .where('productCategory', isEqualTo: 'Sofa')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorFFFFFF,
      appBar: AppBar(
        backgroundColor: color5254A8,
        elevation: 0.0,
        title: Text(
          "Sofa",
          style: TextStyle(
            fontSize: 18,
            color: colorFFFFFF,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _tablesCategorieStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.size,
              itemBuilder: (context, index) {
                final productData = snapshot.data!.docs[index];
                return Container(
                  width: 180,
                  child: Row(
                    children: [
                      Image.network(
                        productData['image'],
                        fit: BoxFit.fill,
                        height: 150,
                        width: 150,
                      ).paddingOnly(top: 10, bottom: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productData['productName'],
                            style: TextStyle(
                                    color: Color(0xFF000000),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppins')
                                .copyWith(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ).paddingOnly(left: 20),
                          Text(
                            rupees +
                                ' ' +
                                productData['productPrice'].toString(),
                            style: TextStyle(
                                    color: Color(0xFF000000),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppins')
                                .copyWith(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ).paddingOnly(left: 20),
                        ],
                      ),
                    ],
                  ).paddingOnly(top: 10, bottom: 10),
                ).paddingOnly(left: 10);
              },
            ),
          );
        },
      ),
    );
  }
}
