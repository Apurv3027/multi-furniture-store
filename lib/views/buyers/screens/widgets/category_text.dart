import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_furniture_store/views/buyers/screens/category_screen.dart';

class CategoryText extends StatelessWidget {

  final Stream<QuerySnapshot> _categoriesStream = FirebaseFirestore.instance.collection('categories').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _categoriesStream,
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

        return Container(
          height: 40,
          child: Row(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.size,
                  itemBuilder: (context, index) {
                    final categoryData = snapshot.data!.docs[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ActionChip(
                        backgroundColor: Colors.yellow.shade900,
                        onPressed: () {},
                        label: Center(
                          child: Text(
                            categoryData['categoryName'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ).paddingOnly(bottom: 10),
                        ),
                      ),
                    );
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.to(CategoryScreen());
                },
                icon: Icon(Icons.keyboard_arrow_down_rounded),
              ),
            ],
          ),
        );
      },
    );
  }
}
