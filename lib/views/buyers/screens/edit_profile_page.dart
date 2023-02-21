import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:multi_furniture_store/utils/color_utilites.dart';
import 'package:multi_furniture_store/utils/common_button.dart';
import 'package:multi_furniture_store/utils/common_text_field.dart';
import 'package:multi_furniture_store/utils/text_utilities.dart';
import 'package:multi_furniture_store/utils/textstyle_utilites.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  TextEditingController nameController =TextEditingController();
  TextEditingController emailController =TextEditingController();
  TextEditingController passController =TextEditingController();
  TextEditingController phoneController =TextEditingController();
  TextEditingController addressController =TextEditingController();

  String? myName;
  String? myEmail;
  String? myPassword;
  String? myPhoneNumber;
  String? myAddress;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? userName;
  String? userEmail;
  String? userPassword;
  String? userPhoneNumber;
  String? userAddress;

  updateUser() async{
    EasyLoading.show();
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if(_formKey.currentState!.validate()){
      await _firestore.collection('buyers').doc(firebaseUser!.uid).update({
        'email' : myEmail,
        'fullName' : myName,
        'phoneNumber' : myPhoneNumber,
        'password' : myPassword,
        'buyerId' : firebaseUser.uid,
        'address' : userAddress,
      }).whenComplete(() {
        EasyLoading.dismiss();
        setState(() {
          _formKey.currentState!.reset();
        });
      });
    }else{
      print('O Bad Guy');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorFFFFFF,
      appBar: AppBar(
        backgroundColor: colorFFFFFF,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
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
              Text(
                editProfile,
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
                    return commonTextField(
                      name: nameSuggestion,
                      suggestionTxt: myName,
                      controller: nameController,
                      onChanged: (value) {
                        myName = value;
                      },
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
                    return commonTextField(
                      name: emailSuggestion,
                      suggestionTxt: myEmail,
                      controller: emailController,
                      onChanged: (value) {
                        myEmail = value;
                      },
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
              ).paddingSymmetric(horizontal: 18),
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
                    return commonTextField(
                      name: passwordSuggestion,
                      suggestionTxt: myPassword,
                      controller: passController,
                      onChanged: (value) {
                        myPassword = value;
                      },
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
                    return commonTextField(
                      name: addressSuggestion,
                      suggestionTxt: myAddress == null ? enterAddress : myAddress,
                      controller: addressController,
                      onChanged: (value) {
                        userAddress = value;
                      },
                      validator: (value) {
                        if(value!.isEmpty){
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
                ),
              ),
              buttonColor: colorFFCA27,
              width: 355,
            ),
          ).paddingOnly(bottom: 20),
        ],
      ),
      // body: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Text(
      //       editProfile,
      //       style: color000000w90038,
      //     ).paddingAll(18),
      //     Divider(
      //       height: 1,
      //       thickness: 1,
      //     ),
      //     Column(
      //       children: [
      //         Container(
      //           width: double.infinity,
      //           padding: EdgeInsets.all(14),
      //           decoration: BoxDecoration(
      //             border: Border.all(color: colorCCCCCC),
      //             borderRadius:BorderRadius.circular(5),
      //           ),
      //           child: FutureBuilder(
      //             future: _fetch(),
      //             builder: (context, snapshot) {
      //               if(snapshot.connectionState != ConnectionState.done)
      //                 return Text(
      //                   'Loading Data...Please Wait',
      //                   style: color999999w40016,
      //                 );
      //               return Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Text(
      //                     nameSuggestion,
      //                     style: color999999w40016,
      //                   ),
      //                   Text(
      //                     myName!,
      //                     style: color000000w90020,
      //                   ).paddingOnly(top: 5),
      //                 ],
      //               );
      //             },
      //           ),
      //         ).paddingAll(18),
      //         Container(
      //           width: double.infinity,
      //           padding: EdgeInsets.all(14),
      //           decoration: BoxDecoration(
      //             border: Border.all(color: colorCCCCCC),
      //             borderRadius:BorderRadius.circular(5),
      //           ),
      //           child: FutureBuilder(
      //             future: _fetch(),
      //             builder: (context, snapshot) {
      //               if(snapshot.connectionState != ConnectionState.done)
      //                 return Text(
      //                   'Loading Data...Please Wait',
      //                   style: color999999w40016,
      //                 );
      //               return Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Text(
      //                     emailSuggestion,
      //                     style: color999999w40016,
      //                   ),
      //                   Text(
      //                     myEmail!,
      //                     style: color000000w90020,
      //                   ).paddingOnly(top: 5),
      //                 ],
      //               );
      //             },
      //           ),
      //         ).paddingSymmetric(horizontal: 18),
      //         FutureBuilder(
      //           future: _fetch(),
      //           builder: (context, snapshot) {
      //             if(snapshot.connectionState != ConnectionState.done)
      //               return Text(
      //                 'Loading Data...Please Wait',
      //                 style: color999999w40016,
      //               );
      //             return Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 // Text(
      //                 //   emailSuggestion,
      //                 //   style: color999999w40016,
      //                 // ),
      //                 // Text(
      //                 //   myEmail!,
      //                 //   style: color000000w90020,
      //                 // ).paddingOnly(top: 5),
      //                 commonTextField(
      //                   name: nameSuggestion,
      //                   suggestionTxt: myName,
      //                   controller: nameController,
      //                 ),
      //                 commonTextField(
      //                   name: emailSuggestion,
      //                   suggestionTxt: myEmail,
      //                   controller: emailController,
      //                 ).paddingOnly(top: 30),
      //                 commonTextField(
      //                   name: phoneSuggestion,
      //                   suggestionTxt: myPhoneNumber,
      //                   controller: phoneController,
      //                 ).paddingOnly(top: 30),
      //                 commonTextField(
      //                   name: addressSuggestion,
      //                   suggestionTxt: myAddress != null ? enterAddress : myAddress,
      //                   controller: emailController,
      //                 ).paddingOnly(top: 30),
      //               ],
      //             );
      //           },
      //         ),
      //         // commonTextField(
      //         //   name: nameSuggestion,
      //         //   suggestionTxt: enterName,
      //         //   controller: nameController,
      //         // ),
      //         // commonTextField(
      //         //   name: emailSuggestion,
      //         //   suggestionTxt: enterMail,
      //         //   controller: emailController,
      //         // ).paddingOnly(top: 30),
      //         // commonTextField(
      //         //   name: phoneSuggestion,
      //         //   suggestionTxt: enterPhoneNumber,
      //         //   controller: phoneController,
      //         // ).paddingOnly(top: 30),
      //         // commonTextField(
      //         //   name: addressSuggestion,
      //         //   suggestionTxt: enterAddress,
      //         //   controller: emailController,
      //         // ).paddingOnly(top: 30),
      //       ],
      //     ).paddingAll(18),
      //     Spacer(),
      //     Align(
      //       alignment: Alignment.center,
      //       child: commonButton(
      //         onPressed: () {},
      //         child: Text(
      //           save,
      //           style: color172F49w40014.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
      //         ),
      //         buttonColor: colorFFCA27,
      //         width: 370,
      //       ),
      //     ).paddingOnly(bottom: 50),
      //   ],
      // ),
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
        myName=ds.data()!['fullName'];
        myEmail=ds.data()!['email'];
        myPassword=ds.data()!['password'];
        myPhoneNumber=ds.data()!['phoneNumber'];
        myAddress=ds.data()!['address'];
        print(myName);
        print(myEmail);
        print(myPassword);
        print(myPhoneNumber);
        print(myAddress);
      }).catchError((e){
        print(e);
      });
  }

}


// When it hits you that the golden era of life is over and now you have to think twice before any action :)