import 'package:flutter/material.dart';

import '../utils/text_utilities.dart';

class GridItems {
  final dynamic img;
  final String? name;
  final String? price;

  GridItems({this.img,this.name,this.price});
}

List<GridItems> gridItemList = [
  GridItems(
      img: const AssetImage('assets/icons/Mask.png'),
      name: productDetail,
      price: '\$9.99'
  ),
  GridItems(
      img: const AssetImage('assets/icons/Mask (1).png'),
      name: productDetail,
      price: '\$9.99'
  ),
  GridItems(
      img: const AssetImage('assets/icons/Mask (2).png'),
      name: productDetail,
      price: '\$9.99'
  ),
  GridItems(
      img: const AssetImage('assets/icons/Mask (3).png'),
      name: productDetail,
      price: '\$9.99'
  ),
  GridItems(
      img: const AssetImage('assets/icons/Mask (4).png'),
      name: productDetail,
      price: '\$9.99'
  ),
  GridItems(
      img: const AssetImage('assets/icons/Mask.png'),
      name: productDetail,
      price: '\$9.99'
  ),
  GridItems(
      img: const AssetImage('assets/icons/Mask (1).png'),
      name: productDetail,
      price: '\$9.99'
  ),
  GridItems(
      img: const AssetImage('assets/icons/Mask (2).png'),
      name: productDetail,
      price: '\$9.99'
  ),
  GridItems(
      img: const AssetImage('assets/icons/Mask (3).png'),
      name: productDetail,
      price: '\$9.99'
  ),
  GridItems(
      img: const AssetImage('assets/icons/Mask (4).png'),
      name: productDetail,
      price: '\$9.99'
  ),
];