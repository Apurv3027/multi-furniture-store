import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:multi_furniture_store/auth/sign_in.dart';
import 'package:multi_furniture_store/config/colors.dart';
import 'package:multi_furniture_store/providers/check_out_provider.dart';
import 'package:multi_furniture_store/providers/credit_card_provider.dart';
import 'package:multi_furniture_store/providers/product_provider.dart';
import 'package:multi_furniture_store/providers/review_cart_provider.dart';
import 'package:multi_furniture_store/providers/user_provider.dart';
import 'package:multi_furniture_store/providers/wishlist_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<ReviewCartProvider>(
          create: (context) => ReviewCartProvider(),
        ),
        ChangeNotifierProvider<WishListProvider>(
          create: (context) => WishListProvider(),
        ),
        ChangeNotifierProvider<CheckoutProvider>(
          create: (context) => CheckoutProvider(),
        ),
        ChangeNotifierProvider<CreditCardProvider>(
          create: (context) => CreditCardProvider(),
        ),
      ],
      child: GetMaterialApp(
        theme: ThemeData(
            primaryColor: primaryColor,
            scaffoldBackgroundColor: scaffoldBackgroundColor),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return SplashScreen();
            }
            return SignIn();
          },
        ),
      ),
    );

    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle(
    //     statusBarColor: Colors.transparent,
    //   ),
    // );
    // return GetMaterialApp(
    //     title: 'Flutter Demo',
    //     theme: ThemeData(
    //       primarySwatch: Colors.blue,
    //       fontFamily: 'Brand-Bold',
    //     ),
    //     home: SplashScreen(),
    //     debugShowCheckedModeBanner: false,
    //   );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignIn())));
  }

  @override
  Widget build(BuildContext context) {
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
                Text(
                  'Reflex Furniture',
                  // 'Reflex',
                  // 'REFLEX',
                  style: TextStyle(fontSize: 50, color: Colors.white, shadows: [
                    BoxShadow(
                      blurRadius: 5,
                      color: Colors.green.shade900,
                      offset: Offset(3, 3),
                    )
                  ]),
                ).paddingOnly(top: 100),
                Image.asset(
                  'assets/icons/reflex-furniture-rb.png',
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
