import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Reflex_Furniture/config/colors.dart';
import 'package:Reflex_Furniture/config/common_button.dart';
import 'package:Reflex_Furniture/config/common_text_field.dart';
import 'package:Reflex_Furniture/config/text.dart';
import 'package:Reflex_Furniture/config/text_style.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  late String email;

  bool _isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
      const snackBar = SnackBar(
        content: Text('Password Reset Link Sent! Check Your Email...'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } on FirebaseAuthException catch (e) {
      var message = '';
      switch (e.code){
        case 'invalid-email':
          message = 'The email you entered was invalid';
          break;
        case 'user-disabled':
          message = 'The user you tried to log into is disabled';
          break;
        case 'user-not-found':
          message = 'The user you tried to log into was not found';
          break;
        default :
          message = 'Enter Email';
          break;
      }

      print(message);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
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
          child: Image.asset('assets/icons/ArrowLeft.png'),
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
                const SizedBox(
                  height: 25,
                ),
                Text(
                  forgot,
                  style: color000000w90022.copyWith(
                      fontWeight: FontWeight.bold, fontSize: 35),
                ),
                const SizedBox(
                  height: 40,
                ),
                commonTextField(
                  name: emailSuggestion,
                  suggestionTxt: enterMail,
                  controller: emailController,
                  action: TextInputAction.next,
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Please Email Field Must Not Be Empty';
                    }else{
                      return null;
                    }
                  },
                  onChanged: (value) {
                    email = value;
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                Align(
                  alignment: Alignment.center,
                  child: commonButton(
                    onPressed: () {
                      if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                        passwordReset();
                      }
                    },
                    child: Center(
                      child: _isLoading ? CircularProgressIndicator(
                        color: Colors.white,
                      ) : Text(
                        'Reset Password',
                        style: TextStyle(
                          letterSpacing: 5,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                        ),
                      ),
                    ),
                    buttonColor: color5254A8,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // body: SingleChildScrollView(
      //   child: Padding(
      //     padding: const EdgeInsets.all(16),
      //     child: Form(
      //       key: _formKey,
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.start,
      //         children: [
      //           const SizedBox(
      //             height: 25,
      //           ),
      //           Text(
      //             forGet,
      //             style: color000000w90022.copyWith(
      //                 fontWeight: FontWeight.bold, fontSize: 35),
      //           ),
      //           const SizedBox(
      //             height: 40,
      //           ),
      //           const Text(
      //               'Enter Your Email and we will send you a password reset link...',
      //               textAlign: TextAlign.center,
      //               style: TextStyle(
      //                 fontSize: 20
      //               ),
      //           ).paddingOnly(top: 50),
      //           _TextFieldPassword(
      //             label: 'Email',
      //             controller: emailController,
      //             keyboardType: TextInputType.emailAddress,
      //             validator: _requiredValidator,
      //           ).paddingOnly(top: 20),
      //           Container(
      //             width: MediaQuery.of(context).size.width,
      //             height: 50,
      //             margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
      //             decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(90),
      //             ),
      //             child: ElevatedButton(
      //               onPressed: (){
      //                 if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      //                   passwordReset();
      //                 }
      //               },
      //               style: ButtonStyle(
      //                 backgroundColor: MaterialStateProperty.resolveWith((states) {
      //                   if (states.contains(MaterialState.pressed)) {
      //                     return Colors.black26;
      //                   }
      //                   return Theme.of(context).primaryColor;
      //                 }),
      //                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      //                   RoundedRectangleBorder(
      //                     borderRadius: BorderRadius.circular(30),
      //                   ),
      //                 ),
      //               ),
      //               child: const Text(
      //                 'Reset Password',
      //                 style: TextStyle(
      //                   color: colorFFFFFF,
      //                   fontWeight: FontWeight.bold,
      //                   fontSize: 16,
      //                 ),
      //               ),
      //             ),
      //           ).paddingOnly(top: 40),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

}