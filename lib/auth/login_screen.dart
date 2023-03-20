import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_furniture_store/auth/forgot_password_screen.dart';
import 'package:multi_furniture_store/auth/register_screen.dart';
import 'package:multi_furniture_store/auth/sign_in.dart';
import 'package:multi_furniture_store/config/colors.dart';
import 'package:multi_furniture_store/config/common_button.dart';
import 'package:multi_furniture_store/config/common_text_field.dart';
import 'package:multi_furniture_store/config/text.dart';
import 'package:multi_furniture_store/config/text_style.dart';
import 'package:multi_furniture_store/screens/home/home_screen.dart';

class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String email;
  late String password;

  bool _isLoading = false;
  bool _isLoggingIn = true;

  loginUsers() async{
    setState(() {
      _isLoggingIn = true;
    });
    try {
      if(email.isNotEmpty && password.isNotEmpty){
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        Get.offAll(HomeScreen());
        print('User is signed in!');
      }else{
        setState(() {
          _isLoading = false;
        });
        // return showSnack(context, 'Please Fields Must Not Be Empty');
        return SnackBar(
          backgroundColor: color5254A8,
          content: Text(
            'Please Fields Must Not Be Empty',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: colorFFFFFF,
            ),
          ),
        );
      }
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
        case 'wrong-password':
          message = 'Incorrect Password';
          break;
        default :
          message = 'Enter Email or Password';
          break;
      }

      print(message);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Login Failed...'),
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

    } finally {
      setState(() {
        _isLoggingIn = false;
      });
    }
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isObscure = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RichText(
            text: TextSpan(
              text: notAccount.tr,
              style: color999999w50018,
              children: [
                TextSpan(
                  text: signup.tr,
                  style: color7AFF18w50018.copyWith(color: color5254A8),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Get.to(RegisterScreen());
                    },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 26,
          )
        ],
      ),
      backgroundColor: colorFFFFFF,
      appBar: AppBar(
        toolbarHeight: 50,
        leading: GestureDetector(
          onTap: () {
            Get.offAll(SignIn());
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
                  logIn,
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
                      return 'Please Email Must Not Be Empty';
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
                commonPasswordTextField(
                  obsecure: !_isObscure,
                  name: passwordSuggestion,
                  action: TextInputAction.done,
                  suggestionTxt: enterPassword,
                  controller: passwordController,
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Please Password Must Not Be Empty';
                    }else{
                      return null;
                    }
                  },
                  onChanged: (value) {
                    password = value;
                  },
                  btn: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                      color: color5254A8,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(ForgotPassword());
                      // Get.to(ForgotPasswordScreen());
                    },
                    child: Text(
                      forgate,
                      style: color000000w90018,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Align(
                  alignment: Alignment.center,
                  child: commonButton(
                    onPressed: () {
                      if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                        loginUsers();
                      }
                    },
                    child: Center(
                      child: _isLoading ? CircularProgressIndicator(
                        color: Colors.white,
                      ) : Text(
                        'Login',
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
    );
    // return Scaffold(
    //   body: Center(
    //     child: Form(
    //       key: _formKey,
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Text(
    //             'Login Customer\'s Account',
    //             style: TextStyle(
    //               fontSize: 20,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //           Stack(
    //             children: [
    //               CircleAvatar(
    //                 radius: 64,
    //                 backgroundColor: Colors.yellow.shade900,
    //               ),
    //               Positioned(
    //                 top: 15,
    //                 left: 15,
    //                 child: Image.asset(
    //                   'assets/icons/accountrb.png',
    //                   height: 100,
    //                 ),
    //               ),
    //             ],
    //           ).paddingOnly(top: 20),
    //           Padding(
    //             padding: const EdgeInsets.all(13.0),
    //             child: TextFormField(
    //               validator: (value) {
    //                 if(value!.isEmpty){
    //                   return 'Please Email Field Must Not Be Empty';
    //                 }else{
    //                   return null;
    //                 }
    //               },
    //               onChanged: (value) {
    //                 email = value;
    //               },
    //               decoration: InputDecoration(
    //                 labelText: 'Email Email Address',
    //               ),
    //             ),
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.all(13.0),
    //             child: TextFormField(
    //               obscureText: true,
    //               validator: (value) {
    //                 if(value!.isEmpty){
    //                   return 'Please Password Field Must Not Be Empty';
    //                 }else{
    //                   return null;
    //                 }
    //               },
    //               onChanged: (value) {
    //                 password = value;
    //               },
    //               decoration: InputDecoration(
    //                 labelText: 'Enter Password',
    //               ),
    //             ),
    //           ),
    //           SizedBox(
    //             height: 20,
    //           ),
    //           InkWell(
    //             onTap: () {
    //               _loginUsers();
    //             },
    //             child: Container(
    //               width: MediaQuery.of(context).size.width - 40,
    //               height: 50,
    //               decoration: BoxDecoration(
    //                 color: Colors.yellow.shade900,
    //                 borderRadius: BorderRadius.circular(10),
    //               ),
    //               child: Center(
    //                 child: _isLoading ? CircularProgressIndicator(
    //                   color: Colors.white,
    //                 ) : Text(
    //                   'Login',
    //                   style: TextStyle(
    //                     letterSpacing: 5,
    //                     color: Colors.white,
    //                     fontWeight: FontWeight.bold,
    //                     fontSize: 19,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ).paddingOnly(top: 20),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Text('Need An Account?'),
    //               TextButton(
    //                 onPressed: () {
    //                   Get.to(RegisterScreen());
    //                 },
    //                 child: Text('Register'),
    //               ),
    //             ],
    //           ).paddingOnly(top: 20),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}