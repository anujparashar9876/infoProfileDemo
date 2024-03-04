import 'package:flutter/material.dart';
import 'package:infoprofiledemo/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserViewModel with ChangeNotifier{
  Future <bool> saveUser(Data user) async{
    final SharedPreferences sp =await SharedPreferences.getInstance();
    sp.setString('accessToken', user.accessToken.toString());
    sp.setString('name',user.userInfo!.name.toString());
    sp.setString('userName',user.userInfo!.userName.toString());
    sp.setString('email',user.userInfo!.email.toString());
    sp.setString('_id',user.userInfo!.sId.toString());
    sp.setString('profilePicUrl',user.userInfo!.profilePicUrl!.toString());
    notifyListeners();
    return true;
  }
  

  Future<UserModel> getUser() async{
    final SharedPreferences sp=await SharedPreferences.getInstance();
    final String? accessToken=sp.getString('accessToken');
    final String? name=sp.getString('name');
    final String? userName=sp.getString('userName');
    final String? email=sp.getString('email');
    final String? sId=sp.getString('_id');
    final String? profilePicUrl=sp.getString('profilePicUrl');
    notifyListeners();
    return UserModel(
      data: Data(
      accessToken: accessToken.toString(),
      userInfo:UserInfo(
        sId: sId.toString(),
        name: name.toString(),
        userName: userName.toString(),
        email: email.toString(),
        profilePicUrl: profilePicUrl.toString()
      )
      ),
      
      );
    
  }
  

  Future<bool> remove() async{
    final SharedPreferences sp=await SharedPreferences.getInstance();
    sp.remove('accessToken');
    // notifyListeners();
    return true;
  }
}