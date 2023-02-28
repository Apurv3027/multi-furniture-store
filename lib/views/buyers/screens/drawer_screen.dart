import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_furniture_store/utils/color_utilites.dart';
import 'package:multi_furniture_store/utils/text_utilities.dart';
import 'package:multi_furniture_store/utils/textstyle_utilites.dart';
import 'package:multi_furniture_store/views/buyers/auth/login_screen.dart';
import 'package:multi_furniture_store/views/buyers/screens/contact_us_screen.dart';
import 'package:multi_furniture_store/views/buyers/screens/favorite_product_screen.dart';
import 'package:multi_furniture_store/views/buyers/screens/profile_page.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {

  String? myEmail;
  String? myName;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              const Image(
                image: AssetImage('assets/icons/drawerBg.png'),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 290,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      child: const Icon(
                        Icons.clear,
                        color: colorFFFFFF,
                        size: 30,
                      ),
                      onTap: () {
                        Get.back();
                      },
                    ),
                  ).paddingOnly(top: 20),
                  FutureBuilder(
                    future: _fetch(),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState != ConnectionState.done)
                        return Text(
                          'Loading Data...Please Wait',
                          style: colorFFFFFFw80024,
                        ).paddingOnly(top: 100);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            myName!,
                            style: colorFFFFFFw80024,
                          ).paddingOnly(top: 100),
                          Text(
                            myEmail!,
                            style: colorFFFFFFw50016,
                          ).paddingOnly(top: 20),
                        ],
                      );
                    },
                  ),
                ],
              ).paddingAll(25),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                child: Text(
                  home,
                  style: color000000w50022,
                ),
                onTap: () {
                  Get.back();
                },
              ),
              GestureDetector(
                child: Text(
                  profile,
                  style: color000000w50022,
                ),
                onTap: () {
                  Get.to(const ProfilePage());
                },
              ).paddingOnly(top: 25),
              GestureDetector(
                child: Text(
                  myOrders,
                  style: color000000w50022,
                ),
                onTap: () {},
              ).paddingOnly(top: 25),
              GestureDetector(
                child: Text(
                  favorites,
                  style: color000000w50022,
                ),
                onTap: () {
                  Get.to(FavoriteProductScreen());
                },
              ).paddingOnly(top: 25),
              GestureDetector(
                child: Text(
                  contactUs,
                  style: color000000w50022,
                ),
                onTap: () {
                  Get.to(ContactUsScreen());
                  // Get.to(const About_Us_Screen());
                },
              ).paddingOnly(top: 25),
              GestureDetector(
                child: Text(
                  settings,
                  style: color000000w50022,
                ),
                onTap: () {
                  // Get.to(const Setting_Screen());
                },
              ).paddingOnly(top: 25),
              GestureDetector(
                child: Text(
                  logout,
                  style: color000000w50022,
                ),
                onTap: () {
                  Get.offAll(LoginScreen());
                  FirebaseAuth.instance.signOut();
                  print('User is currently signed out!');
                },
              ).paddingOnly(top: 25),
            ],
          ).paddingAll(25),
        ],
      ),
    );
  }

  _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if(firebaseUser != null)
      await FirebaseFirestore.instance
          .collection('buyers')
          .doc(firebaseUser.uid)
          .get()
          .then((ds){
        myEmail=ds.data()!['email'];
        myName=ds.data()!['fullName'];
        print(myName);
        print(myEmail);
      }).catchError((e){
        print(e);
      });
  }

}