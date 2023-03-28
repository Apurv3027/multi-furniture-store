import 'package:multi_furniture_store/config/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:multi_furniture_store/screens/categories/chairs_categories_screen.dart';
import 'package:multi_furniture_store/screens/categories/clocks_categories_screen.dart';
import 'package:multi_furniture_store/screens/categories/lamps_categories_screen.dart';
import 'package:multi_furniture_store/screens/categories/lights_categories_screen.dart';
import 'package:multi_furniture_store/screens/categories/tables_categories_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final Stream<QuerySnapshot> _categorieStream =
      FirebaseFirestore.instance.collection('categories').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorFFFFFF,
      appBar: AppBar(
        backgroundColor: color5254A8,
        elevation: 0.0,
        title: Text(
          "Categories",
          style: TextStyle(
            fontSize: 18,
            color: colorFFFFFF,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _categorieStream,
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
                return GestureDetector(
                  onTap: () {
                    if (productData['categoryName'] == 'Lights') {
                      Get.to(LightCategoriesScreen());
                    } else if (productData['categoryName'] == 'Chairs') {
                      Get.to(ChairCategoriesScreen());
                    } else if (productData['categoryName'] == 'Clocks') {
                      Get.to(ClocksCategoriesScreen());
                    } else if (productData['categoryName'] == 'Lamps') {
                      Get.to(LampsCategoriesScreen());
                    } else {
                      Get.to(TablesCategoriesScreen());
                    }
                  },
                  child: Container(
                    width: 180,
                    child: Row(
                      children: [
                        Image.network(
                          productData['image'],
                          fit: BoxFit.fill,
                          height: 150,
                          width: 150,
                        ).paddingOnly(top: 10, bottom: 10),
                        Text(
                          productData['categoryName'],
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
                    ).paddingOnly(top: 10, bottom: 10),
                  ),
                ).paddingOnly(left: 10);
              },
            ),
          );
        },
      ),
    );
  }
}
