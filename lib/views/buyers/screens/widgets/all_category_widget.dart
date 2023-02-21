import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllCategoryWidget extends StatelessWidget {

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

        // return GridView.builder(
        //   shrinkWrap: true,
        //   itemCount: snapshot.data!.size,
        //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 2,
        //     mainAxisSpacing: 8,
        //     crossAxisSpacing: 8,
        //   ),
        //   itemBuilder: (context, index) {
        //     final categoryData = snapshot.data!.docs[index];
        //     return GestureDetector(
        //       onTap: () {},
        //       child: Column(
        //         children: [
        //           SizedBox(
        //             height: 100,
        //             width: 100,
        //             child: Image.network(categoryData['image']),
        //           ),
        //           Text(
        //             categoryData['categoryName'],
        //             style: TextStyle(
        //               fontSize: 20,
        //             ),
        //           ).paddingOnly(top: 20),
        //         ],
        //       ),
        //     );
        //   },
        // );

        return SizedBox(
          height: 670,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data!.size,
            itemBuilder: (context, index) {
              final categoryData = snapshot.data!.docs[index];
              return GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    SizedBox(
                      height: 125,
                      width: 125,
                      child: Image.network(categoryData['image']),
                    ).paddingOnly(left: 15),
                    Text(
                      categoryData['categoryName'],
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ).paddingOnly(left: 30),
                  ],
                ).paddingOnly(top: 10),
              );
            },
          ),
        );
      },
    );
  }
}

class CategoryHomeScreenWidget extends StatelessWidget {

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

        // return GridView.builder(
        //   shrinkWrap: true,
        //   itemCount: snapshot.data!.size,
        //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 2,
        //     mainAxisSpacing: 8,
        //     crossAxisSpacing: 8,
        //   ),
        //   itemBuilder: (context, index) {
        //     final categoryData = snapshot.data!.docs[index];
        //     return GestureDetector(
        //       onTap: () {},
        //       child: Column(
        //         children: [
        //           SizedBox(
        //             height: 100,
        //             width: 100,
        //             child: Image.network(categoryData['image']),
        //           ),
        //           Text(
        //             categoryData['categoryName'],
        //             style: TextStyle(
        //               fontSize: 20,
        //             ),
        //           ).paddingOnly(top: 20),
        //         ],
        //       ),
        //     );
        //   },
        // );

        return SizedBox(
          height: 180,
          width: double.infinity,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.size,
            itemBuilder: (context, index) {
              final categoryData = snapshot.data!.docs[index];
              return GestureDetector(
                onTap: () {},
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.network(categoryData['image']),
                    ),
                    Text(
                      categoryData['categoryName'],
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ).paddingOnly(top: 20),
                  ],
                ),
              ).paddingAll(10);
            },
          ),
        );
      },
    );
  }
}