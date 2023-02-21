import 'package:flutter/material.dart';
import 'package:multi_furniture_store/utils/color_utilites.dart';
import 'package:multi_furniture_store/utils/textstyle_utilites.dart';

Widget commonTextField({
  TextEditingController? controller,
  String? name,
  TextInputType? keyBoard,
  String? hintText,
  String? suggestionTxt,
  TextInputAction? action,
  String? Function(String?)? validator,
  void Function(String)? onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(name ?? '', style: color999999w40016.copyWith(fontSize: 17)),
      TextFormField(
        validator: validator,
        onChanged: onChanged,
        textInputAction: action,
        controller: controller,
        cursorColor: Colors.amber,
        keyboardType: keyBoard,
        decoration: InputDecoration(
          hintText: suggestionTxt,
          hintStyle: TextStyle(fontSize: 20),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: colorFFCA27,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget commonPasswordTextField({
  TextEditingController? controller,
  String? name,
  String? hintText,
  String? suggestionTxt,
  Function()? onPressed,
  TextInputAction? action,
  required bool obsecure,
  IconButton? btn,
  String? Function(String?)? validator,
  void Function(String)? onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(name ?? '', style: color999999w40016.copyWith(fontSize: 17)),
      TextFormField(
        validator: validator,
        onChanged: onChanged,
        obscureText: obsecure,
        controller: controller,
        textInputAction: action,
        cursorColor: Colors.amber,
        decoration: InputDecoration(
          hintText: suggestionTxt,
          hintStyle: TextStyle(fontSize: 20),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: colorFFCA27,
            ),
          ),
          suffixIcon: btn,
        ),
      ),
    ],
  );
}