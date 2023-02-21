import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_furniture_store/views/buyers/main_screen.dart';

class UserManagement {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  storeNewUser(user, context) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    _firestore.collection('buyers')
      .doc(firebaseUser?.uid)
      .set({'email':user.email,'uid':user.uid})
      .then((value) => Navigator.push(
        context, MaterialPageRoute(builder: (context) => Home_ScreenEx(),)))
      .catchError((e){
        print(e);
    });
  }
}