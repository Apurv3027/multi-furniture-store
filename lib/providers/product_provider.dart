import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:multi_furniture_store/models/product_model.dart';

class ProductProvider with ChangeNotifier {
  late ProductModel productModel;

  List<ProductModel> search = [];
  productModels(QueryDocumentSnapshot element) {

    productModel = ProductModel(
      productImage: element.get("productImage"),
      productName: element.get("productName"),
      productPrice: element.get("productPrice"),
      productId: element.get("productId"),
      productQuantity: element.get("productQuantity"),
    );
    search.add(productModel);
  }

  /////////////// Chair Product ///////////////////////////////
  List<ProductModel> chairProductList = [];

  fatchChairProductData() async {
    List<ProductModel> newList = [];

    QuerySnapshot value =
    await FirebaseFirestore.instance.collection("ChairProduct").get();

    value.docs.forEach(
          (element) {
        productModels(element);

        newList.add(productModel);
      },
    );
    chairProductList = newList;
    notifyListeners();
  }

  List<ProductModel> get getChairProductDataList {
    return chairProductList;
  }

//////////////// Light Product ///////////////////////////////////////

  List<ProductModel> lightProductList = [];

  fatchLightProductData() async {
    List<ProductModel> newList = [];

    QuerySnapshot value =
    await FirebaseFirestore.instance.collection("LightProduct").get();

    value.docs.forEach(
          (element) {
        productModels(element);
        newList.add(productModel);
      },
    );
    lightProductList = newList;
    notifyListeners();
  }

  List<ProductModel> get getLightProductDataList {
    return lightProductList;
  }

//////////////// Clock Product ///////////////////////////////////////

  List<ProductModel> clockProductList = [];

  fatchClockProductData() async {
    List<ProductModel> newList = [];

    QuerySnapshot value =
    await FirebaseFirestore.instance.collection("ClockProduct").get();

    value.docs.forEach(
          (element) {
        productModels(element);
        newList.add(productModel);
      },
    );
    clockProductList = newList;
    notifyListeners();
  }

  List<ProductModel> get getClockProductDataList {
    return clockProductList;
  }

  /////////////////// Search Return ////////////
  List<ProductModel> get gerAllProductSearch {
    return search;
  }
}