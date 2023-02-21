import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {

  bool isEmailVerified = false;
  Timer? timer;

  @override
  void initState(){
    super.initState();
    FirebaseAuth.instance.currentUser?.sendEmailVerification();
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      checkEmailVerified();
    });
  }

  checkEmailVerified() async{
    await FirebaseAuth.instance.currentUser?.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Email Successfully Verified'),
        ),
      );
      timer?.cancel();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 75,),
              Center(
                child: Text(
                  'Check Your \n Email',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 8,),
              Center(
                child: Text(
                  'We Have Sent You a Email on ${FirebaseAuth.instance.currentUser?.email}',
                  textAlign: TextAlign.center,
                ),
              ).paddingSymmetric(horizontal: 32),
              SizedBox(height: 16,),
              Center(
                child: CircularProgressIndicator(),
              ),
              SizedBox(height: 8,),
              Center(
                child: Text(
                  'Verifying email....',
                  textAlign: TextAlign.center,
                ),
              ).paddingSymmetric(horizontal: 32),
              SizedBox(height: 57,),
              ElevatedButton(
                onPressed: () {
                  try {
                    FirebaseAuth.instance.currentUser?.sendEmailVerification();
                  } catch (e) {
                    print('$e');
                  }
                },
                child: Text('Resend'),
              ).paddingSymmetric(horizontal: 32),
            ],
          ),
        ),
      ),
    );
  }
}
