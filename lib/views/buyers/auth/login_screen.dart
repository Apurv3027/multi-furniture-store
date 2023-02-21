import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_furniture_store/controllers/auth_controller.dart';
import 'package:multi_furniture_store/utils/color_utilites.dart';
import 'package:multi_furniture_store/utils/common_button.dart';
import 'package:multi_furniture_store/utils/common_text_field.dart';
import 'package:multi_furniture_store/utils/show_snackBar.dart';
import 'package:multi_furniture_store/utils/text_utilities.dart';
import 'package:multi_furniture_store/utils/textstyle_utilites.dart';
import 'package:multi_furniture_store/views/buyers/auth/register_screen.dart';
import 'package:multi_furniture_store/views/buyers/main_screen.dart';
import 'package:multi_furniture_store/views/buyers/screens/forgot_password.dart';
import 'package:multi_furniture_store/views/buyers/screens/wellcome_screen.dart';

class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();

  late String email;
  late String password;

  bool _isLoading = false;

  _loginUsers() async{
    setState(() {
      _isLoading = true;
    });
    if(_formKey.currentState!.validate()){
      await _authController.loginUsers(email, password).whenComplete(() {
        setState(() {
          _formKey.currentState!.reset();
          _isLoading = false;
        });
      });
      Get.offAll(Home_ScreenEx());
      print('User is signed in!');
      // return showSnack(context, '$email You Are Now Logged In');
    }else{
      setState(() {
        _isLoading = false;
      });
      return showSnack(context, 'Please Fields Must Not Be Empty');
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
                  style: color7AFF18w50018,
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
            Get.offAll(const WelcomeScreen());
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
                commonPasswordTextField(
                  obsecure: !_isObscure,
                  name: passwordSuggestion,
                  action: TextInputAction.done,
                  suggestionTxt: enterPassword,
                  controller: passwordController,
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Please Password Field Must Not Be Empty';
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
                      color: colorFFCA27,
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
                      Get.to(ForgotPasswordScreen());
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
                      _loginUsers();
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
                    buttonColor: colorFFCA27,
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
