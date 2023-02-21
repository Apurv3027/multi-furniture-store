import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SearchInputWidget extends StatelessWidget {
  const SearchInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: TextField(
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'Search For Products',
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            prefixIcon: SvgPicture.asset('assets/icons/searchicon.svg',width: 10,).paddingAll(14.0),
          ),
        ),
      ),
    );
  }
}
