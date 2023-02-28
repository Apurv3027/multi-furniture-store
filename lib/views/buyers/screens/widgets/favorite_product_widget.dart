import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteProductWidget extends StatelessWidget {

  final Stream<QuerySnapshot> _favoritesStream = FirebaseFirestore.instance.collection('favorites').where("buyerId", isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _favoritesStream,
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
          height: 670,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data!.size,
            itemBuilder: (context, index) {
              final favoriteData = snapshot.data!.docs[index];
              return GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.network(favoriteData['image']),
                    ).paddingOnly(left: 15),
                    Column(
                      children: [
                        Text(
                          favoriteData['productName'],
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          favoriteData['productPrice'],
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ).paddingOnly(top: 20),
                      ],
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
