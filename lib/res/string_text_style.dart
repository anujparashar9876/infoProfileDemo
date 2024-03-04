import 'package:flutter/material.dart';
import 'package:infoprofiledemo/res/AppColors.dart';

class StringTextStyle {
  static const TextStyle title = TextStyle(
      color: AppColors.white, fontSize: 55, fontWeight: FontWeight.bold);
  static const TextStyle logintitle = TextStyle(
      color: AppColors.theme, fontSize: 55, fontWeight: FontWeight.bold);
  static const TextStyle account = TextStyle(fontSize: 17);
  static const TextStyle profile =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  static const appbar=TextStyle(fontSize: 22,color: Colors.white);
  static const tut=TextStyle(fontSize: 35,color: AppColors.white,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,);
  static const tutdesc=TextStyle(fontSize: 20,color: AppColors.white);
}
