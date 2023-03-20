import 'package:flutter/material.dart';
import 'package:multi_furniture_store/config/colors.dart';

class RatingAndReview extends StatefulWidget {
  const RatingAndReview({Key? key}) : super(key: key);

  @override
  State<RatingAndReview> createState() => _RatingAndReviewState();
}

class _RatingAndReviewState extends State<RatingAndReview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorFFFFFF,
      appBar: AppBar(
        backgroundColor: color5254A8,
        elevation: 0.0,
        title: Text(
          "Rating & Review",
          style: TextStyle(
            fontSize: 18,
            color: colorFFFFFF,
          ),
        ),
      ),
    );
  }
}
