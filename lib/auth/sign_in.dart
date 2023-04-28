import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:Reflex_Furniture/auth/login_screen.dart';
import 'package:Reflex_Furniture/auth/register_screen.dart';
import 'package:Reflex_Furniture/config/colors.dart';
import 'package:Reflex_Furniture/providers/user_provider.dart';
import 'package:Reflex_Furniture/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late UserProvider userProvider;

  bool _isLoading = false;
  void _loginWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    final googleSignIn = GoogleSignIn(scopes: ['email']);

    try {
      final googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount == null) {
        setState(() {
          _isLoading = false;
        });
        return;
      }
      final googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      await FirebaseFirestore.instance
          .collection('buyers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'email': googleSignInAccount.email,
        'fullName': googleSignInAccount.displayName,
        'phoneNumber': '',
        'googleId': googleSignInAccount.id,
        'buyerId': FirebaseAuth.instance.currentUser!.uid,
        'address': '',
        'profile': googleSignInAccount.photoUrl,
      });
      Get.offAll(HomeScreen());
    } on FirebaseAuthException catch (e) {
      var content = '';
      switch (e.code) {
        case 'account-exists-with-different-credential':
          content = 'This account exists with a different sign in provider';
          break;
        case 'invalid-credential':
          content = 'Unknown error has occurred';
          break;
        case 'operation-not-allowed':
          content = 'This operation is not allowed';
          break;
        case 'user-disabled':
          content = 'The user you tried to log into is disabled';
          break;
        case 'user-not-found':
          content = 'The user you tried to log into was not found';
          break;
      }
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Log in with google failed'),
                content: Text(content),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('Ok'),
                  ),
                ],
              ));
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Log in with google failed'),
                content: Text('An unknown error occurred'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('Ok'),
                  ),
                ],
              ));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/icons/bg.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/icons/shadow.png',
              fit: BoxFit.cover,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 400,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Sign in to continue',
                        style: TextStyle(color: colorFFFFFF),
                      ),
                      Text(
                        'Reflex Furniture',
                        // 'Reflex',
                        // 'REFLEX',
                        style: TextStyle(
                            fontSize: 50,
                            color: Colors.white,
                            shadows: [
                              BoxShadow(
                                blurRadius: 5,
                                color: Colors.green.shade900,
                                offset: Offset(3, 3),
                              )
                            ]),
                      ),
                      Column(
                        children: [
                          SignInButton(
                            Buttons.Email,
                            text: "Sign in with Email",
                            onPressed: () {
                              Get.to(LoginScreen());
                            },
                          ),
                          SignInButton(
                            Buttons.Google,
                            text: "Sign in with Google",
                            onPressed: () async {
                              _loginWithGoogle();
                            },
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'By signing in you are agreeing to our',
                            style: TextStyle(
                              // color: Colors.grey[800],
                              color: colorFFFFFF,
                            ),
                          ),
                          Text(
                            'Terms and Privacy Policy',
                            style: TextStyle(
                              // color: Colors.grey[800],
                              color: colorFFFFFF,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't Have Account?",
                            style: TextStyle(color: colorFFFFFF),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(RegisterScreen());
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: colorFFFFFF,
                                  fontWeight: FontWeight.bold),
                            ),
                          ).paddingOnly(left: 10),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // body: Container(
      //   height: double.infinity,
      //   width: double.infinity,
      //   decoration: BoxDecoration(
      //     image: DecorationImage(
      //         fit: BoxFit.cover, image: AssetImage('assets/images/background.png')),
      //   ),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Container(
      //         height: 400,
      //         width: double.infinity,
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //           children: [
      //             Text('Sign in to continue'),
      //             Text(
      //               'Reflex',
      //               style:
      //               TextStyle(fontSize: 50, color: Colors.white, shadows: [
      //                 BoxShadow(
      //                   blurRadius: 5,
      //                   color: Colors.green.shade900,
      //                   offset: Offset(3, 3),
      //                 )
      //               ]),
      //             ),
      //             Column(
      //               children: [
      //                 SignInButton(
      //                   Buttons.Email,
      //                   text: "Sign in with Email",
      //                   onPressed: () {
      //                     Get.to(Login());
      //                   },
      //                 ),
      //                 SignInButton(
      //                   Buttons.Google,
      //                   text: "Sign in with Google",
      //                   onPressed: () async {
      //                     _loginWithGoogle();
      //                   },
      //                 ),
      //               ],
      //             ),
      //             Column(
      //               children: [
      //                 Text(
      //                   'By signing in you are agreeing to our',
      //                   style: TextStyle(
      //                     color: Colors.grey[800],
      //                   ),
      //                 ),
      //                 Text(
      //                   'Terms and Privacy Policy',
      //                   style: TextStyle(
      //                     color: Colors.grey[800],
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
