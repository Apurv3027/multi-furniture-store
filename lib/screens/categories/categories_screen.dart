import 'package:Reflex_Furniture/config/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:Reflex_Furniture/screens/categories/chairs_categories_screen.dart';
import 'package:Reflex_Furniture/screens/categories/beds_categories_screen.dart';
import 'package:Reflex_Furniture/screens/categories/drawer_units_categories_screen.dart';
import 'package:Reflex_Furniture/screens/categories/mirrors_categories_screen.dart';
import 'package:Reflex_Furniture/screens/categories/outdoors_categories_screen.dart';
import 'package:Reflex_Furniture/screens/categories/sofas_categories_screen.dart';
import 'package:Reflex_Furniture/screens/categories/wardrobes_categories_screen.dart';

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
                    if (productData['categoryName'] == 'Chair') {
                      Get.to(ChairCategoriesScreen());
                    } else if (productData['categoryName'] == 'Bed') {
                      Get.to(BedsCategoriesScreen());
                    } else if (productData['categoryName'] == 'Drawer Units') {
                      Get.to(DrawerUnitsCategoriesScreen());
                    } else if (productData['categoryName'] == 'Mirror') {
                      Get.to(MirrorsCategoriesScreen());
                    } else if (productData['categoryName'] == 'Outdoor') {
                      Get.to(OutdoorsCategoriesScreen());
                    } else if (productData['categoryName'] == 'Sofa') {
                      Get.to(SofasCategoriesScreen());
                    } else {
                      Get.to(WardrobesCategoriesScreen());
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
