import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_furniture_store/views/buyers/screens/widgets/all_category_widget.dart';
import 'package:multi_furniture_store/views/buyers/screens/widgets/banner_widget.dart';
import 'package:multi_furniture_store/views/buyers/screens/widgets/category_text.dart';
import 'package:multi_furniture_store/views/buyers/screens/widgets/product_widget.dart';
import 'package:multi_furniture_store/views/buyers/screens/widgets/search_input_widget.dart';

import 'widgets/welcome_text_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WelcomeText(),
          SearchInputWidget().paddingOnly(top: 14),
          BannerWidget(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.topLeft,
              child: Text(
                'Categories',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          CategoryText(),
          CategoryHomeScreenWidget().paddingAll(10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.topLeft,
              child: Text(
                'Products',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ProductWidget().paddingAll(10),
        ],
      ),
    );
  }
}
