import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_furniture_store/config/colors.dart';
import 'package:multi_furniture_store/config/text.dart';
import 'package:multi_furniture_store/providers/product_provider.dart';
import 'package:multi_furniture_store/providers/user_provider.dart';
import 'package:multi_furniture_store/screens/home/drawer_side.dart';
import 'package:multi_furniture_store/screens/home/search_screen.dart';
import 'package:multi_furniture_store/screens/product_overview/product_overview.dart';
import 'package:multi_furniture_store/screens/review_cart/review_cart.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ProductProvider productProvider;

  String? userName;
  String? userEmail;

  final Stream<QuerySnapshot> _bannerStream =
      FirebaseFirestore.instance.collection('banners').snapshots();

  final List _bannerImage = [];
  getBanners() {
    return FirebaseFirestore.instance.collection('banners').get().then(
      (QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          setState(() {
            _bannerImage.add(doc['image']);
          });
        });
      },
    );
  }

  final Stream<QuerySnapshot> _chairStream = FirebaseFirestore.instance
      .collection('products')
      .where('productCategory', isEqualTo: 'Chair')
      .snapshots();
  final Stream<QuerySnapshot> _bedStream = FirebaseFirestore.instance
      .collection('products')
      .where('productCategory', isEqualTo: 'Bed')
      .snapshots();
  final Stream<QuerySnapshot> _drawerUnitsStream = FirebaseFirestore.instance
      .collection('products')
      .where('productCategory', isEqualTo: 'Drawer Units')
      .snapshots();
  final Stream<QuerySnapshot> _mirrorStream = FirebaseFirestore.instance
      .collection('products')
      .where('productCategory', isEqualTo: 'Mirror')
      .snapshots();
  final Stream<QuerySnapshot> _outdoorStream = FirebaseFirestore.instance
      .collection('products')
      .where('productCategory', isEqualTo: 'Outdoor')
      .snapshots();
  final Stream<QuerySnapshot> _sofaStream = FirebaseFirestore.instance
      .collection('products')
      .where('productCategory', isEqualTo: 'Sofa')
      .snapshots();
  final Stream<QuerySnapshot> _wardrobesStream = FirebaseFirestore.instance
      .collection('products')
      .where('productCategory', isEqualTo: 'Wardrobes')
      .snapshots();

  TextEditingController _reviewController = TextEditingController();
  double _rating = 0.0;

  final Stream<QuerySnapshot> _reviewStream = FirebaseFirestore.instance
      .collection('Ratings')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('Reviews')
      .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  @override
  void initState() {
    getBanners();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of(context);
    UserProvider userProvider = Provider.of(context);
    userProvider.getUserData();
    return Scaffold(
      backgroundColor: colorFFFFFF,
      drawer: DrawerSide(
        userProvider: userProvider,
      ),
      appBar: AppBar(
        backgroundColor: color5254A8,
        iconTheme: IconThemeData(color: colorFFFFFF),
        title: FutureBuilder(
          future: _fetchUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done)
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ).paddingOnly(top: 20),
              );
            return Text(
              'Hello, ' + userName!,
              style: TextStyle(color: colorFFFFFF, fontSize: 17),
            );
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: GestureDetector(
              onTap: () {
                Get.to(SearchScreen());
              },
              child: CircleAvatar(
                backgroundColor: Color(0xffd6d382),
                radius: 20,
                child: Icon(
                  Icons.search_rounded,
                  size: 25,
                  color: textColor,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ReviewCart(),
                  ),
                );
              },
              child: CircleAvatar(
                backgroundColor: Color(0xffd6d382),
                radius: 20,
                child: Icon(
                  Icons.shop,
                  size: 25,
                  color: textColor,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: ListView(
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/icons/collectionBg.png'),
                ),
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 130, bottom: 10),
                            child: Container(
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Color(0xffd1ad17),
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(50),
                                  bottomLeft: Radius.circular(50),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Reflex',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    shadows: [
                                      BoxShadow(
                                          color: Colors.green,
                                          blurRadius: 10,
                                          offset: Offset(3, 3))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            '10% Off',
                            style: TextStyle(
                                fontSize: 40,
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              'On all furniture products',
                              style: TextStyle(
                                color: color000000,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
            ),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text('Collections')
            //         .paddingSymmetric(vertical: 20)
            //         .paddingOnly(bottom: 15),
            //     BannerWidget().paddingAll(15),
            //   ],
            // ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Chairs'),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'view all',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: _chairStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.cyan,
                        ),
                      );
                    }

                    return SizedBox(
                      height: 300,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.size,
                        itemBuilder: (context, index) {
                          final productData = snapshot.data!.docs[index];
                          final firebaseUser =
                              FirebaseAuth.instance.currentUser;
                          return GestureDetector(
                            onTap: () {
                              Get.to(ProductOverview(
                                productId: productData['productID'],
                                productImage: productData['image'],
                                productName: productData['productName'],
                                productPrice: productData['productPrice'],
                                productDetail: productData['productDetail'],
                                userName: userName!,
                                UserEmail: userEmail!,
                              ));
                            },
                            child: Container(
                              width: 180,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    productData['image'],
                                    fit: BoxFit.fill,
                                    height: 200,
                                    width: 200,
                                  ),
                                  Text(
                                    productData['productName'],
                                    style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Poppins')
                                        .copyWith(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ).paddingOnly(top: 10),
                                  Text(
                                    rupees +
                                        productData['productPrice'].toString(),
                                    style: TextStyle(
                                            color: Color(0xFF999999),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Poppins')
                                        .copyWith(fontSize: 18),
                                  ).paddingOnly(top: 5),
                                ],
                              ).paddingOnly(top: 10),
                            ),
                          ).paddingOnly(left: 10);
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Beds'),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'view all',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: _bedStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.cyan,
                        ),
                      );
                    }

                    return SizedBox(
                      height: 300,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.size,
                        itemBuilder: (context, index) {
                          final productData = snapshot.data!.docs[index];
                          final firebaseUser =
                              FirebaseAuth.instance.currentUser;
                          return GestureDetector(
                            onTap: () {
                              Get.to(ProductOverview(
                                productId: productData['productID'],
                                productImage: productData['image'],
                                productName: productData['productName'],
                                productPrice: productData['productPrice'],
                                productDetail: productData['productDetail'],
                                userName: userName!,
                                UserEmail: userEmail!,
                              ));
                            },
                            child: Container(
                              width: 180,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    productData['image'],
                                    fit: BoxFit.fill,
                                    height: 200,
                                    width: 200,
                                  ),
                                  Text(
                                    productData['productName'],
                                    style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Poppins')
                                        .copyWith(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ).paddingOnly(top: 10),
                                  Text(
                                    rupees +
                                        productData['productPrice'].toString(),
                                    style: TextStyle(
                                            color: Color(0xFF999999),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Poppins')
                                        .copyWith(fontSize: 18),
                                  ).paddingOnly(top: 5),
                                ],
                              ).paddingOnly(top: 10),
                            ),
                          ).paddingOnly(left: 10);
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Drawer Units'),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'view all',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: _drawerUnitsStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.cyan,
                        ),
                      );
                    }

                    return SizedBox(
                      height: 300,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.size,
                        itemBuilder: (context, index) {
                          final productData = snapshot.data!.docs[index];
                          final firebaseUser =
                              FirebaseAuth.instance.currentUser;
                          return GestureDetector(
                            onTap: () {
                              Get.to(ProductOverview(
                                productId: productData['productID'],
                                productImage: productData['image'],
                                productName: productData['productName'],
                                productPrice: productData['productPrice'],
                                productDetail: productData['productDetail'],
                                userName: userName!,
                                UserEmail: userEmail!,
                              ));
                            },
                            child: Container(
                              width: 180,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    productData['image'],
                                    fit: BoxFit.fill,
                                    height: 200,
                                    width: 200,
                                  ),
                                  Text(
                                    productData['productName'],
                                    style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Poppins')
                                        .copyWith(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ).paddingOnly(top: 10),
                                  Text(
                                    rupees +
                                        productData['productPrice'].toString(),
                                    style: TextStyle(
                                            color: Color(0xFF999999),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Poppins')
                                        .copyWith(fontSize: 18),
                                  ).paddingOnly(top: 5),
                                ],
                              ).paddingOnly(top: 10),
                            ),
                          ).paddingOnly(left: 10);
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Mirror'),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'view all',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: _mirrorStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.cyan,
                        ),
                      );
                    }

                    return SizedBox(
                      height: 300,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.size,
                        itemBuilder: (context, index) {
                          final productData = snapshot.data!.docs[index];
                          final firebaseUser =
                              FirebaseAuth.instance.currentUser;
                          return GestureDetector(
                            onTap: () {
                              Get.to(ProductOverview(
                                productId: productData['productID'],
                                productImage: productData['image'],
                                productName: productData['productName'],
                                productPrice: productData['productPrice'],
                                productDetail: productData['productDetail'],
                                userName: userName!,
                                UserEmail: userEmail!,
                              ));
                            },
                            child: Container(
                              width: 180,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    productData['image'],
                                    fit: BoxFit.fill,
                                    height: 200,
                                    width: 200,
                                  ),
                                  Text(
                                    productData['productName'],
                                    style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Poppins')
                                        .copyWith(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ).paddingOnly(top: 10),
                                  Text(
                                    rupees +
                                        productData['productPrice'].toString(),
                                    style: TextStyle(
                                            color: Color(0xFF999999),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Poppins')
                                        .copyWith(fontSize: 18),
                                  ).paddingOnly(top: 5),
                                ],
                              ).paddingOnly(top: 10),
                            ),
                          ).paddingOnly(left: 10);
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Outdoors'),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'view all',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: _outdoorStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.cyan,
                        ),
                      );
                    }

                    return SizedBox(
                      height: 300,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.size,
                        itemBuilder: (context, index) {
                          final productData = snapshot.data!.docs[index];
                          final firebaseUser =
                              FirebaseAuth.instance.currentUser;
                          return GestureDetector(
                            onTap: () {
                              Get.to(ProductOverview(
                                productId: productData['productID'],
                                productImage: productData['image'],
                                productName: productData['productName'],
                                productPrice: productData['productPrice'],
                                productDetail: productData['productDetail'],
                                userName: userName!,
                                UserEmail: userEmail!,
                              ));
                            },
                            child: Container(
                              width: 180,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    productData['image'],
                                    fit: BoxFit.fill,
                                    height: 200,
                                    width: 200,
                                  ),
                                  Text(
                                    productData['productName'],
                                    style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Poppins')
                                        .copyWith(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ).paddingOnly(top: 10),
                                  Text(
                                    rupees +
                                        productData['productPrice'].toString(),
                                    style: TextStyle(
                                            color: Color(0xFF999999),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Poppins')
                                        .copyWith(fontSize: 18),
                                  ).paddingOnly(top: 5),
                                ],
                              ).paddingOnly(top: 10),
                            ),
                          ).paddingOnly(left: 10);
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Sofas'),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'view all',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: _sofaStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.cyan,
                        ),
                      );
                    }

                    return SizedBox(
                      height: 300,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.size,
                        itemBuilder: (context, index) {
                          final productData = snapshot.data!.docs[index];
                          final firebaseUser =
                              FirebaseAuth.instance.currentUser;
                          return GestureDetector(
                            onTap: () {
                              Get.to(ProductOverview(
                                productId: productData['productID'],
                                productImage: productData['image'],
                                productName: productData['productName'],
                                productPrice: productData['productPrice'],
                                productDetail: productData['productDetail'],
                                userName: userName!,
                                UserEmail: userEmail!,
                              ));
                            },
                            child: Container(
                              width: 180,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    productData['image'],
                                    fit: BoxFit.fill,
                                    height: 200,
                                    width: 200,
                                  ),
                                  Text(
                                    productData['productName'],
                                    style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Poppins')
                                        .copyWith(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ).paddingOnly(top: 10),
                                  Text(
                                    rupees +
                                        productData['productPrice'].toString(),
                                    style: TextStyle(
                                            color: Color(0xFF999999),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Poppins')
                                        .copyWith(fontSize: 18),
                                  ).paddingOnly(top: 5),
                                ],
                              ).paddingOnly(top: 10),
                            ),
                          ).paddingOnly(left: 10);
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Wardrobes'),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'view all',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: _wardrobesStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.cyan,
                        ),
                      );
                    }

                    return SizedBox(
                      height: 300,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.size,
                        itemBuilder: (context, index) {
                          final productData = snapshot.data!.docs[index];
                          final firebaseUser =
                              FirebaseAuth.instance.currentUser;
                          return GestureDetector(
                            onTap: () {
                              Get.to(ProductOverview(
                                productId: productData['productID'],
                                productImage: productData['image'],
                                productName: productData['productName'],
                                productPrice: productData['productPrice'],
                                productDetail: productData['productDetail'],
                                userName: userName!,
                                UserEmail: userEmail!,
                              ));
                            },
                            child: Container(
                              width: 180,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    productData['image'],
                                    fit: BoxFit.fill,
                                    height: 200,
                                    width: 200,
                                  ),
                                  Text(
                                    productData['productName'],
                                    style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Poppins')
                                        .copyWith(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ).paddingOnly(top: 10),
                                  Text(
                                    rupees +
                                        productData['productPrice'].toString(),
                                    style: TextStyle(
                                            color: Color(0xFF999999),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Poppins')
                                        .copyWith(fontSize: 18),
                                  ).paddingOnly(top: 5),
                                ],
                              ).paddingOnly(top: 10),
                            ),
                          ).paddingOnly(left: 10);
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _fetchUser() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null)
      await FirebaseFirestore.instance
          .collection("buyers")
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        userName = ds.data()!['fullName'];
        userEmail = ds.data()!['email'];
        print(userName);
        print(userEmail);
      }).catchError((e) {
        print(e);
      });
  }
}
