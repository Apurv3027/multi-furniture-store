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
import 'package:multi_furniture_store/views/buyers/auth/email_verification_screen.dart';
import 'package:multi_furniture_store/views/buyers/auth/login_screen.dart';
import 'package:multi_furniture_store/views/buyers/main_screen.dart';

class RegisterScreen extends StatefulWidget {

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final AuthController _authController = AuthController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String email;
  late String fullName;
  late String phoneNumber;
  late String password;
  
  bool _isLoading = false;

  // For Create User Account
  _signUpUser() async{
    setState(() {
      _isLoading = true;
    });
    if(_formKey.currentState!.validate()){
      await _authController.signUpUsers(email, fullName, phoneNumber, password).whenComplete(() {
        setState(() {
          _formKey.currentState!.reset();
          _isLoading = false;
        });
      });
      Get.offAll(Home_ScreenEx());
      // Get.to(EmailVerificationScreen());
      return showSnack(context, 'Congratulations An Account Has Been Created For You');
    }else{
      setState(() {
        _isLoading = false;
      });
      return showSnack(context, 'Please Fields Must Not Be Empty');
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool _isObscure = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: signUpAccount.tr,
            style: color999999w50018,
            children: [
              TextSpan(
                  text: signIn.tr,
                  style: color7AFF18w50018,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Get.offAll(LoginScreen());
                    })
            ],
          ),
        ),
      ),
      backgroundColor: colorFFFFFF,
      appBar: AppBar(
        toolbarHeight: 50,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          // child: Image(image: backArrow),
          child: Image.asset('assets/icons/ArrowLeft.png'),
        ),
        backgroundColor: colorFFFFFF,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 25,
                ),
                Text(
                  signup,
                  style: color000000w90022.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                commonTextField(
                  name: nameSuggestion,
                  suggestionTxt: enterName,
                  controller: nameController,
                  action: TextInputAction.next,
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Please Full Name Must Not Be Empty';
                    }else{
                      return null;
                    }
                  },
                  onChanged: (value) {
                    fullName = value;
                  },
                ),
                SizedBox(
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
                SizedBox(
                  height: 40,
                ),
                commonPasswordTextField(
                  obsecure: !_isObscure,
                  name: passwordSuggestion,
                  action: TextInputAction.next,
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
                SizedBox(
                  height: 40,
                ),
                commonTextField(
                  action: TextInputAction.done,
                  name: phoneSuggestion,
                  suggestionTxt: enterPhoneNumber,
                  controller: phoneController,
                  keyBoard: TextInputType.number,
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Please Phone Number Must Not Be Empty';
                    }else{
                      return null;
                    }
                  },
                  onChanged: (value) {
                    phoneNumber = value;
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                Align(
                  alignment: Alignment.center,
                  child: commonButton(
                    onPressed: () {
                      _signUpUser();
                    },
                    child: Center(
                      child: _isLoading ? CircularProgressIndicator(
                        color: Colors.white,
                      ) : Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 19,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4,
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
    //     child: SingleChildScrollView(
    //       child: Form(
    //         key: _formKey,
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Text(
    //               'Create Customer\'s Account',
    //               style: TextStyle(
    //                 fontSize: 20,
    //               ),
    //             ),
    //             Stack(
    //               children: [
    //                 CircleAvatar(
    //                   radius: 64,
    //                   backgroundColor: Colors.yellow.shade900,
    //                 ),
    //                 Positioned(
    //                   top: 15,
    //                   left: 15,
    //                   child: Image.asset(
    //                     'assets/icons/accountrb.png',
    //                     height: 100,
    //                   ),
    //                 ),
    //               ],
    //             ).paddingOnly(top: 20),
    //             Padding(
    //               padding: const EdgeInsets.all(13.0),
    //               child: TextFormField(
    //                 validator: (value) {
    //                   if(value!.isEmpty){
    //                     return 'Please Email Must Not Be Empty';
    //                   }else{
    //                     return null;
    //                   }
    //                 },
    //                 onChanged: (value) {
    //                   email = value;
    //                 },
    //                 decoration: InputDecoration(
    //                   labelText: 'Enter Email',
    //                 ),
    //               ),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.all(13.0),
    //               child: TextFormField(
    //                 validator: (value) {
    //                   if(value!.isEmpty){
    //                     return 'Please Full Name Must Not Be Empty';
    //                   }else{
    //                     return null;
    //                   }
    //                 },
    //                 onChanged: (value) {
    //                   fullName = value;
    //                 },
    //                 decoration: InputDecoration(
    //                   labelText: 'Enter Full Name',
    //                 ),
    //               ),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.all(13.0),
    //               child: TextFormField(
    //                 validator: (value) {
    //                   if(value!.isEmpty){
    //                     return 'Please Phone Number Must Not Be Empty';
    //                   }else{
    //                     return null;
    //                   }
    //                 },
    //                 onChanged: (value) {
    //                   phoneNumber = value;
    //                 },
    //                 decoration: InputDecoration(
    //                   labelText: 'Enter Phone Number',
    //                 ),
    //               ),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.all(13.0),
    //               child: TextFormField(
    //                 obscureText: true,
    //                 validator: (value) {
    //                   if(value!.isEmpty){
    //                     return 'Please Password Must Not Be Empty';
    //                   }else{
    //                     return null;
    //                   }
    //                 },
    //                 onChanged: (value) {
    //                   password = value;
    //                 },
    //                 decoration: InputDecoration(
    //                   labelText: 'Password',
    //                 ),
    //               ),
    //             ),
    //             GestureDetector(
    //               onTap: () {
    //                 _signUpUser();
    //               },
    //               child: Container(
    //                 width: MediaQuery.of(context).size.width - 40,
    //                 height: 50,
    //                 decoration: BoxDecoration(
    //                   color: Colors.yellow.shade900,
    //                   borderRadius: BorderRadius.circular(10),
    //                 ),
    //                 child: Center(
    //                   child: _isLoading ? CircularProgressIndicator(
    //                     color: Colors.white,
    //                   ) : Text(
    //                     'Register',
    //                     style: TextStyle(
    //                       fontSize: 19,
    //                       color: Colors.white,
    //                       fontWeight: FontWeight.bold,
    //                       letterSpacing: 4,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ).paddingOnly(top: 20),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 Text('Already Have An Account?'),
    //                 TextButton(
    //                   onPressed: () {
    //                     Get.offAll(LoginScreen());
    //                   },
    //                   child: Text('Login'),
    //                 ),
    //               ],
    //             ).paddingOnly(top: 20),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
