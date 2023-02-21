import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_furniture_store/models/cart.dart';
import 'package:multi_furniture_store/models/product_details.dart';
import 'package:multi_furniture_store/services/cart_services.dart';
import 'package:multi_furniture_store/utils/color_utilites.dart';
import 'package:multi_furniture_store/utils/common_button.dart';
import 'package:multi_furniture_store/utils/text_utilities.dart';
import 'package:multi_furniture_store/utils/textstyle_utilites.dart';
import 'package:multi_furniture_store/views/buyers/screens/widgets/product_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productId;
  final String userId;

  ProductDetailsScreen({
    required this.productId,
    required this.userId,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final CartService _cartService = CartService();

  final CollectionReference productsRef =
  FirebaseFirestore.instance.collection('products');

  final firebaseUser = FirebaseAuth.instance.currentUser;

  bool _pinned = true;

  bool _snap = false;

  bool _floating = true;

  bool _isLoading = false;

  //Select Product Color
  RxInt selectedcolor = 0.obs;

  List<Color> colors = [
    colorDDB692,
    color007AFF,
    colorFF9500,
    colorFF2D55,
    color5856D6,
    colorE5E5EA,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<DocumentSnapshot>(
        stream: productsRef.doc(widget.productId).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          ProductDetails productDetails = ProductDetails(
            name: snapshot.data!['productName'],
            price: snapshot.data!['productPrice'],
            description: snapshot.data!['productDetail'],
            image: snapshot.data!['image'],
            quantity: snapshot.data!['productQuantity'],
          );

          print('Product Name: ' + snapshot.data!['productName']);
          print('Product Price: ' + '\$' + snapshot.data!['productPrice']);
          print('Product Detail: ' + snapshot.data!['productDetail']);

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                centerTitle: true,
                backgroundColor: Colors.white,
                elevation: 0,
                leading: GestureDetector(
                  onTap: () => Get.back(),
                  child: Image.asset('assets/icons/ArrowLeft.png'),
                ),
                title: Text(
                  productTxt,
                  style: color000000w90018,
                ),
                pinned: _pinned,
                snap: _snap,
                floating: _floating,
                expandedHeight: 400.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    productDetails.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18.0,
                              ),
                              child: SizedBox(
                                width: 340,
                                child: Text(
                                  productDetails.name,
                                  style: color000000w60030.copyWith(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 18.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\$' + productDetails.price,
                                    style: colorFF2D55w70026,
                                  ),
                                  FavoriteButton(
                                    iconColor: Colors.black,
                                    iconSize: 45,
                                    isFavorite: false,
                                    valueChanged: (_isFavorite) {
                                      print(
                                        'Is Favorite $_isFavorite)',
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                              child: Divider(
                                color: color000000,
                                thickness: 0.3,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 18),
                              child: Text(
                                color,
                                style: color000000w60020,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              height: 50,
                              child: ListView.builder(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 9.0),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: colors.length,
                                  itemBuilder: (context, index) {
                                    return Obx(() {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 9.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            selectedcolor.value = index;
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              color: colors[index],
                                              borderRadius:
                                              BorderRadius.circular(50),
                                            ),
                                            child: index == selectedcolor.value
                                                ? Icon(Icons.done)
                                                : SizedBox(),
                                          ),
                                        ),
                                      );
                                    });
                                  }),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 5,
                              child: Divider(
                                color: color000000,
                                thickness: 0.3,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18.0, vertical: 15),
                              child: Text(
                                description,
                                style: color000000w60020,
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 18.0),
                              child: SizedBox(
                                width: 450,
                                child: Text(
                                  productDetails.description,
                                  style: color000000w40020.copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 18.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        sku,
                                        style: color999999w50018.copyWith(
                                            fontWeight: FontWeight.normal),
                                      ),
                                      Text(
                                        categories,
                                        style: color999999w50018.copyWith(
                                            fontWeight: FontWeight.normal),
                                      ),
                                      Text(
                                        tags,
                                        style: color999999w50018.copyWith(
                                            fontWeight: FontWeight.normal),
                                      ),
                                      Text(
                                        dimensions,
                                        style: color999999w50018.copyWith(
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        model,
                                        style: color000000w50020,
                                      ),
                                      Text(
                                        modelDetails,
                                        style: color000000w50020,
                                      ),
                                      Text(
                                        hashtag,
                                        style: color000000w50020,
                                      ),
                                      Text(
                                        dimensionsSize,
                                        style: color000000w50020,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18.0, vertical: 10),
                              child: Text(
                                similarItems,
                                style: color000000w60020,
                              ),
                            ),
                            ProductWidget().paddingAll(10),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18.0,
                                vertical: 10,
                              ),
                              child: commonButton(
                                width: double.infinity,
                                onPressed: () async {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  Cart cart = Cart(
                                    productId: widget.productId,
                                    userId: firebaseUser!.uid,
                                    productName: productDetails.name,
                                    productPrice: productDetails.price,
                                  );
                                  await _cartService.addToCart(cart);
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  return ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Your Product was add to the cart'),
                                      duration: Duration(seconds: 3),
                                    ),
                                  );
                                  // Get.to(ShoppingCart());
                                },
                                child: _isLoading ? CircularProgressIndicator(
                                  color: Colors.white,
                                ) : Text(addToCart),
                                buttonColor: colorFFCA27,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                  childCount: 1,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}