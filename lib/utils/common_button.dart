import 'package:flutter/material.dart';
import 'package:multi_furniture_store/utils/textstyle_utilites.dart';

Widget commonButton({
  Function()? onPressed,
  Color? buttonColor,
  double width = 300,
  Widget? child,
}) {
  return MaterialButton(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    onPressed: onPressed,
    minWidth: width,
    height: 60,
    color: buttonColor,
    elevation: 0,
    child: child,
  );
}

Widget commonWelcomeButton({
  VoidCallback? onPressed,
  Color? buttonColor,
  String? txt,
  double minWidth = 120,
}) {
  return MaterialButton(
    minWidth: minWidth,
    onPressed: onPressed,
    height: 50,
    color: buttonColor,
    child: Text(
      txt ?? '',
      style: color172F49w70016.copyWith(fontSize: 20),
    ),
  );
}