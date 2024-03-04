import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SubmitButton extends StatelessWidget {
  String? buttonLabel;
  Function()? submitFuction;
  Color? col;
  Color? textCol;
  double? wi;
  double? he;
  SubmitButton({super.key,this.buttonLabel,this.submitFuction,this.col, required this.textCol,this.wi,required this.he});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: submitFuction,
      child: Container(
        width: wi,
        height: he,
        decoration: BoxDecoration(
          color: col,
          borderRadius: BorderRadius.circular(25)
        ),
        
        child: Center(child: Text('$buttonLabel',style: TextStyle(color:textCol ),)), 
        ),
    );
  }
}