import 'package:flutter/material.dart';
import 'package:Reflex_Furniture/config/colors.dart';
import 'package:Reflex_Furniture/config/text_style.dart';

Widget commonTextField({
  TextEditingController? controller,
  String? name,
  bool? enabled,
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
        enabled: enabled,
        validator: validator,
        onChanged: onChanged,
        textInputAction: action,
        controller: controller,
        cursorColor: color5254A8,
        keyboardType: keyBoard,
        decoration: InputDecoration(
          hintText: suggestionTxt,
          hintStyle: TextStyle(fontSize: 20),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: color5254A8,
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
        cursorColor: color5254A8,
        decoration: InputDecoration(
          hintText: suggestionTxt,
          hintStyle: TextStyle(fontSize: 20),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: color5254A8,
            ),
          ),
          suffixIcon: btn,
        ),
      ),
    ],
  );
}
