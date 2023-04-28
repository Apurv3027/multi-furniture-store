import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:Reflex_Furniture/config/colors.dart';
import 'package:Reflex_Furniture/config/common_button.dart';
import 'package:Reflex_Furniture/config/common_text_field.dart';
import 'package:Reflex_Furniture/config/text.dart';
import 'package:Reflex_Furniture/config/text_style.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String? myName;
  String? myEmail;
  String? myPhoneNumber;
  String? myAddress;
  String? myProfile;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? userName;
  String? userEmail;
  String? userPhoneNumber;
  String? userAddress;
  String? userProfile;

  updateUser() async {
    EasyLoading.show();
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (_formKey.currentState!.validate()) {
      await _firestore.collection('buyers').doc(firebaseUser!.uid).update({
        'email': myEmail,
        'fullName': myName,
        'phoneNumber': myPhoneNumber,
        'buyerId': firebaseUser.uid,
        'address': myAddress,
        'profile': myProfile,
      }).whenComplete(() {
        EasyLoading.dismiss();
        setState(() {
          _formKey.currentState!.reset();
        });
      });
    } else {
      print('O Bad Guy');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorFFFFFF,
      appBar: AppBar(
        backgroundColor: color5254A8,
        elevation: 0,
        title: Text(
          "Edit Profile",
          style: TextStyle(
            fontSize: 18,
            color: colorFFFFFF,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: colorFFFFFF,
            size: 30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   editProfile,
              //   style: color000000w90038,
              // ).paddingAll(18),
              // Divider(
              //   height: 1,
              //   thickness: 1,
              // ),
              FutureBuilder(
                future: _fetch(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done)
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ).paddingOnly(top: 30),
                    );
                  return Center(
                    child: CircleAvatar(
                      backgroundImage: myProfile == null || myProfile == ''
                          ? AssetImage('assets/icons/accountrb.png')
                              as ImageProvider
                          : NetworkImage(myProfile!),
                      backgroundColor: color5254A8,
                      radius: 50,
                    ),
                  );
                },
              ).paddingAll(18),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  border: Border.all(color: colorCCCCCC),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: FutureBuilder(
                  future: _fetch(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done)
                      return Text(
                        'Loading Data...Please Wait',
                        style: color999999w40016,
                      );
                    return commonTextField(
                      name: nameSuggestion,
                      suggestionTxt: myName,
                      controller: nameController,
                      onChanged: (value) {
                        myName = value;
                      },
                      enabled: false,
                      // validator: (value) {
                      //   if(value!.isEmpty){
                      //     return 'Please User Name Must Not Be Empty';
                      //   } else {
                      //     return null;
                      //   }
                      // },
                    );
                  },
                ),
              ).paddingSymmetric(horizontal: 18),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  border: Border.all(color: colorCCCCCC),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: FutureBuilder(
                  future: _fetch(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done)
                      return Text(
                        'Loading Data...Please Wait',
                        style: color999999w40016,
                      );
                    return commonTextField(
                      name: emailSuggestion,
                      suggestionTxt: myEmail,
                      controller: emailController,
                      onChanged: (value) {
                        myEmail = value;
                      },
                      enabled: false,
                      // validator: (value) {
                      //   if(value!.isEmpty){
                      //     return 'Please User Email Must Not Be Empty';
                      //   } else {
                      //     return null;
                      //   }
                      // },
                    );
                  },
                ),
              ).paddingAll(18),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  border: Border.all(color: colorCCCCCC),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: FutureBuilder(
                  future: _fetch(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done)
                      return Text(
                        'Loading Data...Please Wait',
                        style: color999999w40016,
                      );
                    return commonTextField(
                      name: phoneSuggestion,
                      suggestionTxt: myPhoneNumber,
                      controller: phoneController,
                      onChanged: (value) {
                        myPhoneNumber = value;
                      },
                      // validator: (value) {
                      //   if(value!.isEmpty){
                      //     return 'Please User Phone Number Must Not Be Empty';
                      //   } else {
                      //     return null;
                      //   }
                      // },
                    );
                  },
                ),
              ).paddingSymmetric(horizontal: 18),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  border: Border.all(color: colorCCCCCC),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: FutureBuilder(
                  future: _fetch(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done)
                      return Text(
                        'Loading Data...Please Wait',
                        style: color999999w40016,
                      );
                    return commonTextField(
                      name: addressSuggestion,
                      suggestionTxt: myAddress,
                      controller: addressController,
                      onChanged: (value) {
                        myAddress = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please User Address Must Not Be Empty';
                        } else {
                          return null;
                        }
                      },
                    );
                  },
                ),
              ).paddingAll(18),
              // Spacer(),
              // Align(
              //   alignment: Alignment.center,
              //   child: commonButton(
              //     onPressed: () {},
              //     child: Text(
              //       save,
              //       style: color172F49w40014.copyWith(
              //         fontSize: 20,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //     buttonColor: colorFFCA27,
              //     width: 355,
              //   ),
              // ).paddingOnly(bottom: 50,top: 50),
              // Spacer(),
              // Align(
              //   alignment: Alignment.center,
              //   child: commonButton(
              //     onPressed: () {},
              //     child: Text(
              //       save,
              //       style: color172F49w40014.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
              //     ),
              //     buttonColor: colorFFCA27,
              //     width: 370,
              //   ),
              // ).paddingOnly(bottom: 50),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.center,
            child: commonButton(
              onPressed: () {
                updateUser();
              },
              child: Text(
                save,
                style: color172F49w40014.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: colorFFFFFF),
              ),
              buttonColor: color5254A8,
              width: 355,
            ),
          ).paddingOnly(bottom: 20),
        ],
      ),
    );
  }

  _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null)
      await FirebaseFirestore.instance
          .collection('buyers')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        myName = ds.data()!['fullName'];
        myEmail = ds.data()!['email'];
        myPhoneNumber = ds.data()!['phoneNumber'];
        myAddress = ds.data()!['address'];
        myProfile = ds.data()!['profile'];
        print(myName);
        print(myEmail);
        print(myPhoneNumber);
        print(myAddress);
        print(myProfile);
      }).catchError((e) {
        print(e);
      });
  }
}


// When it hits you that the golden era of life is over and now you have to think twice before any action :)