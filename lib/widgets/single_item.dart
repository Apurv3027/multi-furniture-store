import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:multi_furniture_store/config/colors.dart';
import 'package:multi_furniture_store/config/text.dart';
import 'package:multi_furniture_store/providers/review_cart_provider.dart';
import 'package:multi_furniture_store/providers/wishlist_provider.dart';
import 'package:multi_furniture_store/widgets/count.dart';
import 'package:provider/provider.dart';

class SingleItem extends StatefulWidget {
  bool isBool = false;
  String productImage;
  String productName;
  bool wishList = false;
  int productPrice;
  String productId;
  int productQuantity;
  Function onDelete;
  SingleItem(
      {required this.productQuantity,
        required this.productId,
        required this.onDelete,
        required this.isBool,
        required this.productImage,
        required this.productName,
        required this.productPrice,
        required this.wishList});

  @override
  _SingleItemState createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  late ReviewCartProvider reviewCartProvider;

  late int count;
  getCount() {
    setState(() {
      count = widget.productQuantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    getCount();
    reviewCartProvider = Provider.of<ReviewCartProvider>(context);
    reviewCartProvider.getReviewCartData();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 90,
                  child: Center(
                    child: Image.network(
                      widget.productImage,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 90,
                  child: Column(
                    mainAxisAlignment: widget.isBool == false
                        ? MainAxisAlignment.spaceAround
                        : MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.productName,
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Text(
                            rupees + widget.productPrice.toString(),
                            style: TextStyle(
                                color: textColor, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 90,
                  padding: widget.isBool == false
                      ? EdgeInsets.symmetric(horizontal: 15, vertical: 32)
                      : EdgeInsets.only(left: 15, right: 15),
                  child: widget.isBool == false
                      ? Count(
                    productId: widget.productId,
                    productImage: widget.productImage,
                    productName: widget.productName,
                    productPrice: widget.productPrice,
                  )
                      : Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // InkWell(
                        //   // onTap: widget.onDelete,
                        //   onTap: () {
                        //     showDialog(
                        //       context: context,
                        //       builder: (context) => AlertDialog(
                        //         title: Text("Cart Product"),
                        //         content: Text("Are you sure you want to delete your cart product?"),
                        //         actions: [
                        //           MaterialButton(
                        //             child: Text("No"),
                        //             onPressed: () {
                        //               Navigator.of(context).pop();
                        //             },
                        //           ),
                        //           MaterialButton(
                        //             child: Text("Yes"),
                        //             onPressed: () {
                        //               reviewCartProvider.reviewCartDataDelete(widget.productId);
                        //               Navigator.of(context).pop();
                        //             },
                        //           ),
                        //         ],
                        //       ),
                        //     );
                        //   },
                        //   child: Icon(
                        //     Icons.delete,
                        //     size: 30,
                        //     color: Colors.black54,
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        widget.wishList == false
                            ? Container(
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (count == 1) {
                                      Fluttertoast.showToast(
                                        msg:
                                        "You reach minimum limit",

                                      );
                                    } else {
                                      setState(() {
                                        count--;
                                      });
                                      reviewCartProvider.updateReviewCartData(
                                        cartImage: widget.productImage,
                                        cartId: widget.productId,
                                        cartName: widget.productName,
                                        cartPrice: widget.productPrice,
                                        cartQuantity: count,
                                      );
                                    }
                                  },
                                  child: Icon(
                                    Icons.remove,
                                    color: primaryColor,
                                    size: 20,
                                  ),
                                ).paddingOnly(left: 5),
                                Text(
                                  "$count",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 20
                                  ),
                                ).paddingOnly(left: 5,right: 5),
                                InkWell(
                                  onTap: () {
                                    if (count < 10) {
                                      setState(() {
                                        count++;
                                      });
                                      reviewCartProvider.updateReviewCartData(
                                        cartImage: widget.productImage,
                                        cartId: widget.productId,
                                        cartName: widget.productName,
                                        cartPrice: widget.productPrice,
                                        cartQuantity: count,
                                      );
                                    }
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: primaryColor,
                                    size: 20,
                                  ),
                                ).paddingOnly(right: 5),
                              ],
                            ),
                          ),
                        )
                            : Container(),
                        SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          // onTap: widget.onDelete,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Cart Product"),
                                content: Text("Are you sure you want to delete your cart product?"),
                                actions: [
                                  MaterialButton(
                                    child: Text("No"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  MaterialButton(
                                    child: Text("Yes"),
                                    onPressed: () {
                                      reviewCartProvider.reviewCartDataDelete(widget.productId);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Container(
                            height: 30,
                            width: 80,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                'Delete',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        widget.isBool == false
            ? Container()
            : Divider(
          height: 1,
          color: Colors.black45,
        )
      ],
    );
  }
}

class WishListSingleItem extends StatefulWidget {
  bool isBool = false;
  String productImage;
  String productName;
  bool wishList = false;
  int productPrice;
  String productId;
  int productQuantity;
  Function onDelete;
  WishListSingleItem(
      {required this.productQuantity,
        required this.productId,
        required this.onDelete,
        required this.isBool,
        required this.productImage,
        required this.productName,
        required this.productPrice,
        required this.wishList});

  @override
  _WishListSingleItemState createState() => _WishListSingleItemState();
}

class _WishListSingleItemState extends State<WishListSingleItem> {
  late WishListProvider wishListProvider;

  late int count;
  getCount() {
    setState(() {
      count = widget.productQuantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    getCount();
    wishListProvider = Provider.of<WishListProvider>(context);
    wishListProvider.getWishtListData();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 90,
                  child: Center(
                    child: Image.network(
                      widget.productImage,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 90,
                  child: Column(
                    mainAxisAlignment: widget.isBool == false
                        ? MainAxisAlignment.spaceAround
                        : MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.productName,
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Text(
                            rupees + widget.productPrice.toString(),
                            style: TextStyle(
                                color: textColor, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 90,
                  padding: widget.isBool == false
                      ? EdgeInsets.symmetric(horizontal: 15, vertical: 32)
                      : EdgeInsets.only(left: 15, right: 15),
                  child: InkWell(
                    // onTap: widget.onDelete,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Wish List Product"),
                          content: Text("Are you sure you want to delete your wish list product?"),
                          actions: [
                            MaterialButton(
                              child: Text("No"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            MaterialButton(
                              child: Text("Yes"),
                              onPressed: () {
                                wishListProvider.wishlistDataDelete(widget.productId);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    child: Icon(
                      Icons.close,
                      size: 30,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        widget.isBool == false
            ? Container()
            : Divider(
          height: 1,
          color: Colors.black45,
        )
      ],
    );
  }
}