import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List _bannerImage = [];

  getBanners(){
    return _firestore
        .collection('banners')
        .get()
        .then((QuerySnapshot querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            setState(() {
              _bannerImage.add(doc['image']);
            });
          });
        },
    );
  }

  @override
  void initState() {
    getBanners();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 140,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.yellow.shade900,
          borderRadius: BorderRadius.circular(10),
        ),
        // child: CarouselSlider(
        //   items: ,
        //   options: CarouselOptions(
        //     autoPlay: true,
        //       height: 350,
        //       pauseAutoPlayOnTouch: true,
        //       viewportFraction: 1.0
        //   ),
        // ),
        child: PageView.builder(
          itemCount: _bannerImage.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                _bannerImage[index],
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
    );
  }
}
