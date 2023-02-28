import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:multi_furniture_store/views/buyers/screens/add_to_cart_screen.dart';
import 'package:multi_furniture_store/views/buyers/screens/profile_page.dart';
import 'package:multi_furniture_store/views/buyers/screens/cart_screen.dart';
import 'package:multi_furniture_store/views/buyers/screens/category_screen.dart';
import 'package:multi_furniture_store/views/buyers/screens/drawer_screen.dart';
import 'package:multi_furniture_store/views/buyers/screens/home_screen.dart';
import 'package:multi_furniture_store/views/buyers/screens/widgets/all_category_widget.dart';
import 'package:multi_furniture_store/views/buyers/screens/widgets/banner_widget.dart';
import 'package:multi_furniture_store/views/buyers/screens/widgets/product_widget.dart';

import '../../utils/color_utilites.dart';
import '../../utils/text_utilities.dart';
import '../../utils/textstyle_utilites.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _pageIndex = 0;

  List<Widget> _pages = [
    HomeScreen(),
    CategoryScreen(),
    //StoreScreen(),
    CartScreen(),
    //SearchScreen(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _pageIndex,
        onTap: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.yellow.shade900,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/homeicon.svg',width: 20,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/exploreicon.svg',width: 20,),
            label: 'Categories',
          ),
          // BottomNavigationBarItem(
          //   icon: SvgPicture.asset('assets/icons/shopicon.svg',width: 20,),
          //   label: 'Store',
          // ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/carticon.svg',width: 20,),
            label: 'Cart',
          ),
          // BottomNavigationBarItem(
          //   icon: SvgPicture.asset('assets/icons/searchicon.svg',width: 20,),
          //   label: 'Search',
          // ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/accounticon.svg',width: 20,),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}

class Home_ScreenEx extends StatefulWidget {
  const Home_ScreenEx({Key? key}) : super(key: key);

  @override
  State<Home_ScreenEx> createState() => _Home_ScreenExState();
}

class _Home_ScreenExState extends State<Home_ScreenEx> {

  String? myName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorFFFFFF,
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: colorFFFFFF,
        elevation: 0,
        title: FutureBuilder(
          future: _fetch(),
          builder: (context, snapshot) {
            if(snapshot.connectionState != ConnectionState.done)
              return Text(
                // 'Loading Data...Please Wait',
                'Welcome To Reflex Furniture!',
                style: color000000w90018,
              );
            return Row(
              children: [
                Text(
                  hello,
                  style: color000000w90018,
                ),
                Text(
                  myName!,
                  style: color000000w90018,
                ).paddingOnly(left: 5),
              ],
            );
          },
        ),
        iconTheme: const IconThemeData(color: color000000),
        actions: [
          GestureDetector(
            // child: const Image(
            //   image: AssetImage('assets/icons/notification.png'),
            // ),
            child: SvgPicture.asset(
              'assets/icons/carticon.svg',
              width: 20,
            ).paddingOnly(right: 20),
            onTap: () {
              Get.to(AddToCartScreen());
            },
          ),
        ],
      ),
      drawer: const DrawerScreen(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   width: double.infinity,
            //   height: 52,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(5),
            //     border: Border.all(
            //       color: colorCCCCCC,
            //     ),
            //   ),
            //   child: Row(
            //     children: [
            //       const Icon(
            //         Icons.search_rounded,
            //         color: colorCCCCCC,
            //         size: 26,
            //       ),
            //       Text(
            //         search,
            //         style: colorCCCCCCw90018,
            //       ).paddingOnly(left: 10),
            //     ],
            //   ).paddingAll(10),
            // ).paddingSymmetric(horizontal: 18).paddingOnly(top: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  categories,
                  style: color000000w90020,
                ),
                InkWell(
                  child: Text(
                    seeall,
                    style: color7AFF18w50018,
                  ),
                  onTap: () {
                    Get.to(const CategoryScreen());
                  },
                ),
              ],
            ).paddingSymmetric(horizontal: 18).paddingOnly(top: 22),
            CategoryHomeScreenWidget().paddingAll(10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                color: Colors.grey,
              ),
            ),
            Text(
              collection,
              style: color000000w90020,
            ).paddingSymmetric(horizontal: 18,vertical: 15),
            BannerWidget(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                color: Colors.grey,
              ),
            ),
            // Stack(
            //   children: [
            //     SizedBox(
            //       width: MediaQuery.of(context).size.width,
            //       child: const Image(
            //         image: AssetImage('assets/icons/collectionBg.png'),
            //         fit: BoxFit.cover,
            //       ),
            //     ),
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(
            //           friday,
            //           style: color999999w40022,
            //         ),
            //         Text(
            //           arrivals,
            //           style: color000000w90038,
            //         ),
            //         Row(
            //           children: [
            //             Text(
            //               shop,
            //               style: const TextStyle(
            //                 decoration: TextDecoration.underline,
            //               ),
            //             ),
            //             const Icon(Icons.skip_next_rounded),
            //           ],
            //         ).paddingOnly(left: 5,top: 10),
            //       ],
            //     ).paddingOnly(top: 20,right: 100,left: 15),
            //   ],
            // ).paddingSymmetric(horizontal: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  featured,
                  style: color000000w90020,
                ),
                InkWell(
                  child: Text(
                    seeall,
                    style: color7AFF18w50018,
                  ),
                  onTap: () {
                    // Get.to(const Featured_Screen());
                  },
                ),
              ],
            ).paddingSymmetric(horizontal: 18,vertical: 10).paddingOnly(top: 15),
            ProductWidget().paddingAll(10),
          ],
        ),
      ),
    );
  }

  _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if(firebaseUser != null)
      await FirebaseFirestore.instance
          .collection('buyers')
          .doc(firebaseUser!.uid)
          .get()
          .then((ds){
        myName=ds.data()!['fullName'];
        print(myName);
      }).catchError((e){
        print(e);
      });
  }

}
