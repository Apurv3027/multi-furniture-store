import 'package:flutter/material.dart';

import '../utils/text_utilities.dart';

class CategoriesItems {
  dynamic img;
  String? name;
  String? items;

  CategoriesItems({this.img,this.name,this.items});
}

List<CategoriesItems> categoriesItems = [
  CategoriesItems(
    img: const AssetImage('assets/icons/Chair01.png'),
    name: chair,
    items: '1065 Items',
  ),
  CategoriesItems(
    img: const AssetImage('assets/icons/Ceiling.png'),
    name: light,
    items: '512 Items',
  ),
  CategoriesItems(
    img: const AssetImage('assets/icons/Lamps.png'),
    name: clock,
    items: '233 Items',
  ),
  CategoriesItems(
    img: const AssetImage('assets/icons/Wooden.png'),
    name: metal,
    items: '1300 Items',
  ),
  CategoriesItems(
    img: const AssetImage('assets/icons/Chair01.png'),
    name: chair,
    items: '1065 Items',
  ),
  CategoriesItems(
    img: const AssetImage('assets/icons/Ceiling.png'),
    name: light,
    items: '512 Items',
  ),
  CategoriesItems(
    img: const AssetImage('assets/icons/Lamps.png'),
    name: clock,
    items: '233 Items',
  ),
  CategoriesItems(
    img: const AssetImage('assets/icons/Wooden.png'),
    name: metal,
    items: '1300 Items',
  ),
];