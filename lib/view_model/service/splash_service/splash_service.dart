import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:infoprofiledemo/model/user_model.dart';
import 'package:infoprofiledemo/utils/route/routeName.dart';
import 'package:infoprofiledemo/view_model/provider/user_view_model.dart';


class SplashService{
  Future<UserModel> getUserData()=>UserViewModel().getUser();

  void checkAuth(BuildContext context)async{
    getUserData().then((value) async{
      if(value.data!.accessToken=='null' || value.data!.accessToken==''){
        await Future.delayed(Duration(seconds: 3));
        Navigator.pushReplacementNamed(context, RouteName.firstTutorial);
      }else{
        await Future.delayed(Duration(seconds: 3));
        Navigator.pushReplacementNamed(context, RouteName.bottomNav);
      }
    }).onError((error, stackTrace){
      if(kDebugMode){
        print(error.toString());
      }
    });
  }
}