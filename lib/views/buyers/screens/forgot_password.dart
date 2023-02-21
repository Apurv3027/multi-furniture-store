import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_furniture_store/utils/color_utilites.dart';
import 'package:multi_furniture_store/utils/common_button.dart';
import 'package:multi_furniture_store/utils/common_text_field.dart';
import 'package:multi_furniture_store/utils/text_utilities.dart';
import 'package:multi_furniture_store/utils/textstyle_utilites.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _forgotPassword() async{
    if (_formKey.currentState!.validate()){
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
      } on FirebaseAuthException catch (e){}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorFFFFFF,
      appBar: AppBar(
        toolbarHeight: 50,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.close,
            color: Colors.black,
            size: 31,
          ),
        ),
        backgroundColor: colorFFFFFF,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  forGet,
                  style: color000000w90022.copyWith(
                      fontWeight: FontWeight.bold, fontSize: 35),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 26, bottom: 32),
                  child: Text(
                    forgetTxt,
                    style: color999999w50018,
                    maxLines: 3,
                  ),
                ),
                commonTextField(
                  name: emailSuggestion,
                  suggestionTxt: enterMail,
                  controller: emailController,
                ),
                SizedBox(height: 52),
                Align(
                  alignment: Alignment.center,
                  child: commonButton(
                    onPressed: () {
                      _forgotPassword();
                      // Get.to(OtpVerification());
                    },
                    child: Text(send),
                    buttonColor: colorFFCA27,
                    width: 500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
