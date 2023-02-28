import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:multi_furniture_store/views/buyers/screens/wellcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () {
        Get.to(WelcomeScreen());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
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
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                  Image.asset(
                    'assets/icons/reflex-furniture-rb.png',
                    height: 250,
                  ).paddingOnly(top: 100),
                  Spacer(),
                  // commonWelcomeButton(
                  //   onPressed: () {
                  //     Get.to(LoginScreen());
                  //   },
                  //   buttonColor: colorFFFFFF,
                  //   txt: login,
                  //   minWidth: 500,
                  // ),
                  // commonWelcomeButton(
                  //   onPressed: () {
                  //     Get.to(RegisterScreen());
                  //   },
                  //   buttonColor: colorFFCA27,
                  //   txt: signUp,
                  //   minWidth: 500,
                  // ).paddingOnly(top: 15),
                ],
              ),
            ).paddingAll(42),
          ],
        ),
      ),
    );
  }
}
