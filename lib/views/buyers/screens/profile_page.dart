import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_furniture_store/utils/color_utilites.dart';
import 'package:multi_furniture_store/utils/text_utilities.dart';
import 'package:multi_furniture_store/utils/textstyle_utilites.dart';
import 'package:multi_furniture_store/views/buyers/main_screen.dart';
import 'package:multi_furniture_store/views/buyers/screens/edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin{

  String? myEmail;
  String? myName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorFFFFFF,
      appBar: AppBar(
        backgroundColor: colorFFFFFF,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.offAll(Home_ScreenEx());
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
            size: 30,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: GestureDetector(
              onTap: () {
                Get.to(EditProfilePage());
              },
              child: Image.asset(
                'assets/icons/edit.png',
                height: 60,
              ),
            ),
          ).paddingAll(10),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            profile,
            style: color000000w90038,
          ).paddingAll(18),
          Divider(
            height: 1,
            thickness: 1,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              border: Border.all(color: colorCCCCCC),
              borderRadius:BorderRadius.circular(5),
            ),
            child: FutureBuilder(
              future: _fetch(),
              builder: (context, snapshot) {
                if(snapshot.connectionState != ConnectionState.done)
                  return Text(
                    'Loading Data...Please Wait',
                    style: color999999w40016,
                  );
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nameSuggestion,
                      style: color999999w40016,
                    ),
                    Text(
                      myName!,
                      style: color000000w90020,
                    ).paddingOnly(top: 5),
                  ],
                );
              },
            ),
          ).paddingAll(18),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              border: Border.all(color: colorCCCCCC),
              borderRadius:BorderRadius.circular(5),
            ),
            child: FutureBuilder(
              future: _fetch(),
              builder: (context, snapshot) {
                if(snapshot.connectionState != ConnectionState.done)
                  return Text(
                    'Loading Data...Please Wait',
                    style: color999999w40016,
                  );
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      emailSuggestion,
                      style: color999999w40016,
                    ),
                    Text(
                      myEmail!,
                      style: color000000w90020,
                    ).paddingOnly(top: 5),
                  ],
                );
              },
            ),
          ).paddingSymmetric(horizontal: 18),
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
