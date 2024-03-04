import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:infoprofiledemo/res/AppColors.dart';

class Utils{
  static focusNode(BuildContext context,FocusNode current,FocusNode next){
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  static toastMessage(String message){
    Fluttertoast.showToast(msg: message);
  }
  static void flushBarErrorMessage(String message,BuildContext context){
    showFlushbar(context: context, flushbar: Flushbar(
      forwardAnimationCurve: Curves.bounceIn,
      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      padding: const EdgeInsets.all(15),
      flushbarPosition: FlushbarPosition.TOP,
      reverseAnimationCurve: Curves.bounceOut,
      icon: const Icon(Icons.error,color: Colors.white,size: 30,),
      
      message: message,
      backgroundColor: AppColors.red,
      title: 'Error',
      messageColor: Colors.white,
      duration: const Duration(seconds: 4 ),
    )..show(context)
    );
  }

  static void flushBarSuccessMessage(String message,BuildContext context){
    showFlushbar(context: context, flushbar: Flushbar(
      forwardAnimationCurve: Curves.bounceIn,
      borderRadius: BorderRadius.circular(20),
      borderColor: AppColors.white,
      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      padding: const EdgeInsets.all(15),
      flushbarPosition: FlushbarPosition.TOP,
      reverseAnimationCurve: Curves.bounceOut,
      icon: const Icon(Icons.done,color: Colors.white,size: 30,),      
      message: message,
      backgroundColor: AppColors.black,
      messageColor: Colors.white,
      duration: const Duration(seconds: 4 ),
    )..show(context)
    );
  }
  static snackBar(String message ,BuildContext context){
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: AppColors.theme,content: Text(message ),));
  }

  static void showCircularProgress(BuildContext context) {
    AlertDialog loadingScreenDialog = AlertDialog(
      content: Container(
        padding: const EdgeInsets.all(20),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 40,
            ),
            Text('Loading...'),
          ],
        ),
      ),
    );
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return loadingScreenDialog;
        });
  }

  static void showAlertDialog(
      BuildContext context, String title, String content,Function() ontap,String buttontext) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel')),
        TextButton(onPressed: ontap, child: Text(buttontext)),
      ],
    );
    showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }

  static void showEditDialog(
      BuildContext context, String title, var content,Function() ontap,String buttontext) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: content,
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel')),
        TextButton(onPressed: ontap, child: Text(buttontext)),
      ],
    );
    showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }

  static void showImageDialog(
      BuildContext context, var content,) {
    AlertDialog alertDialog = AlertDialog(      
      content: content,
      contentPadding: EdgeInsets.all(0),
    );
    showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }
}