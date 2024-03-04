import 'package:flutter/material.dart';
import 'package:infoprofiledemo/res/AppColors.dart';
import 'package:infoprofiledemo/res/string_text_style.dart';

// ignore: must_be_immutable
class OnBoardContent extends StatelessWidget {
  OnBoardContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.color,
    required this.buttonText,
    
  });

  String image;
  String title;
  String description;
  Color? color;
  String buttonText;


  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        color: color,
        ),
      Positioned(
        bottom: 0,
        child: Container(
          
          height: MediaQuery.of(context).size.height*0.6,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: AppColors.theme,
            borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width*0.1)
          ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            const SizedBox(height: 20,),
            Text(title,style: StringTextStyle.tut,),
            const SizedBox(height: 20,),
            Text(description,style: StringTextStyle.tutdesc,),
        
            
          ],),
        ),
      )),
      Positioned(
        top: 0,
        child: Container(
        height: MediaQuery.of(context).size.height*0.5,
        width: MediaQuery.of(context).size.width*1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width*1),
          color: AppColors.white
        ),
        child: Image.asset(image,),
      ))
    ],);
  }
}