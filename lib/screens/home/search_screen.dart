import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multi_furniture_store/config/colors.dart';
import 'package:multi_furniture_store/config/text.dart';
import 'package:get/get.dart';
import 'package:multi_furniture_store/screens/product_overview/product_overview.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? userName;
  String? userEmail;

  Stream<QuerySnapshot>? _stream;

  List searchResult = [];

  void searchForCategory(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('products')
        .where('productCategory', isEqualTo: query)
        .get();

    setState(() {
      searchResult = result.docs.map((e) => e.data()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorFFFFFF,
      appBar: AppBar(
        backgroundColor: color5254A8,
        elevation: 0.0,
        title: Text("Search"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Search Here ...",
              ),
              onChanged: (query) {
                searchForCategory(query);
              },
            ).paddingAll(15),
            StreamBuilder<QuerySnapshot>(
              stream: _stream,
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
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    scrollDirection: Axis.vertical,
                    itemCount: searchResult.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          child: ListTile(
                            leading: Image.network(
                              searchResult[index]['image'],
                              fit: BoxFit.fill,
                              width: 125,
                            ),
                            title: Text(
                              searchResult[index]['productName'],
                              style: TextStyle(
                                      color: Color(0xFF000000),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins')
                                  .copyWith(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            subtitle: Text(
                              rupees +
                                  searchResult[index]['productPrice']
                                      .toString(),
                              style: TextStyle(
                                      color: Color(0xFF999999),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Poppins')
                                  .copyWith(fontSize: 18),
                            ),
                          ),
                        ),
                      ).paddingOnly(left: 10);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
