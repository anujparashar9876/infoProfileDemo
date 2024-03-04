

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:infoprofiledemo/model/user_model.dart';
import 'package:infoprofiledemo/repository/auth_repository.dart';
import 'package:infoprofiledemo/utils/route/routeName.dart';
import 'package:infoprofiledemo/utils/utils.dart';
import 'package:infoprofiledemo/view_model/provider/user_view_model.dart';
import 'package:provider/provider.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);
    Utils.showCircularProgress(context);
    _myRepo.loginApi(data).then((value) {
      Navigator.pop(context);
      setLoading(false);
      // Navigator.pop(context);
      print("LOgin data fetch" + value["data"]["UserInfo"]["name"]);
      final userPreference = Provider.of<UserViewModel>(context, listen: false);
      userPreference.saveUser(Data(
          accessToken: value['data']['accessToken'],
          userInfo: UserInfo(
            name: value["data"]["UserInfo"]["name"],
            userName: value["data"]["UserInfo"]["userName"],
            email: value["data"]["UserInfo"]["email"],
            sId: value["data"]["UserInfo"]["_id"],
            profilePicUrl: value["data"]["UserInfo"]["profilePicUrl"],
          )));    
      Utils.toastMessage("Login Successful");
      Navigator.popUntil(context, (route) => route.isFirst,);
      Navigator.pushReplacementNamed(context, RouteName.bottomNav);
      if (kDebugMode) {
        // print(" My deta "+value['data']['userInfo']);
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      Navigator.pop(context);
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage('Invalid Credential', context);
        print(error.toString());
      }
    });
  }

  Future<void> registerApi(dynamic data, BuildContext context) async {
    setLoading(true);
    Utils.showCircularProgress(context);
    _myRepo.registerApi(data).then((value) {
      Navigator.pop(context);
      var a = data['email'];
      print(a);
      setLoading(false);
      Utils.toastMessage("Register Successful");
      Navigator.pushNamed(context, RouteName.otp, arguments: {'email': a});
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }

  Future<void> verifyOtp(
      Map<String, dynamic> data, BuildContext context) async {
        Utils.showCircularProgress(context);
    _myRepo.otpVerify(data).then((value) {
      Navigator.pop(context);
      Utils.flushBarSuccessMessage('OTP Verify', context);
      Utils.toastMessage('OTP Verify');
      Navigator.pushNamed(context, RouteName.login);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage("Invalid OTP", context);
        print(error.toString());
      }
    });
  }

  Future<void> resend(dynamic data, BuildContext context) async {
    Utils.showCircularProgress(context);
    _myRepo.resendOTP(data).then((value) {
      Navigator.pop(context);
      Utils.flushBarSuccessMessage('OTP Resend', context);
      Utils.toastMessage('OTP Resend');
      // Navigator.pushNamed(context, RouteName.login);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage("Error Sending OTP", context);
        print(error.toString());
      }
    });
  }

  Future<void> forgetpassword(dynamic data, BuildContext context) async {
    Utils.showCircularProgress(context);
    _myRepo.forget(data).then((value) {
      Navigator.pop(context);
      var routedata = data['email'];
      Utils.toastMessage('OTP sent');
      Navigator.pushNamed(context, RouteName.otpfoget, arguments: {
        'email': routedata,
      });
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage("Error getting Email", context);
        print(error.toString());
      }
    });
  }

  Future<void> forgetpasswordOTP(dynamic data, BuildContext context) async {
    Utils.showCircularProgress(context);
    _myRepo.forget_otp(data).then((value) {
      Navigator.pop(context);
      print(value['forgetToken']);
      Utils.toastMessage('OTP verify');
      Navigator.pushNamed(context, RouteName.newpass,
          arguments: {'forgetToken': value['forgetToken']});
      if (kDebugMode) {
        // print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage("Error Sending OTP", context);
        print(error.toString());
      }
    });
  }

  Future<void> resetPassword(
    dynamic data,
    String forgetToken,
    BuildContext context,
  ) async {
    Utils.showCircularProgress(context);
    _myRepo.changePassword(data, forgetToken).then((value) {
      Navigator.pop(context);
      Utils.toastMessage('Password change succesfully');
      Navigator.pushNamed(context, RouteName.login);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage("Error reset Password", context);
        print(error.toString());
      }
    });
  }

  Future<void> logout(
    dynamic data,
    String accessToken,
    BuildContext context,
  ) async {
    Navigator.pop(context);
    Future.delayed(Duration.zero,(){

    Utils.showCircularProgress(context);
    });
    _myRepo.logout(data, accessToken).then((value) {
      // Navigator.pop(context);
      Utils.flushBarSuccessMessage('LogOut Successfully', context);
      Navigator.popUntil(context, (route) => route.isFirst,);
      Navigator.pushReplacementNamed(context, RouteName.login);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage("Error LogOut", context);
        print(error.toString());
      }
    });
  }

  Future<void> createPost(
    dynamic data,
    String accessToken,
    BuildContext context,
  ) async {
    
    _myRepo.createPost(data, accessToken).then((value) {
      Navigator.pop(context);
      // Utils.flushBarSuccessMessage('Post Uploaded succesfully', context);
      Utils.toastMessage('Post Uploaded succesfully');
      Navigator.pushNamedAndRemoveUntil(context, RouteName.bottomNav, (route) => false);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage("Error Uploading Image", context);
        print(error.toString());
      }
    });
  }

  Future<void> reportPost(
    dynamic data,
    String accessToken,
    BuildContext context,
  ) async {
    
    _myRepo.reportPost(data, accessToken).then((value) {
      // Utils.flushBarSuccessMessage('Post Uploaded succesfully', context);
      Utils.toastMessage('Post reported');
      // Navigator.pushNamedAndRemoveUntil(context, RouteName.bottomNav, (route) => false);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage("Error Uploading Image", context);
        print(error.toString());
      }
    });
  }

  Future<dynamic> showUserPost(
    String accessToken,
    BuildContext context,
  ) async {
    
    dynamic res;
    await _myRepo.showUserPost(accessToken).then((value) {
      res = value;
      // Utils.flushBarSuccessMessage('user Images', context);
      // Navigator.pushNamed(context, RouteName.login);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage("Error Fetching Image", context);
        print(error.toString());
      }
      // return null;
    });
    return res;
  }

  Future<void> likePost(
    dynamic data,
    String accessToken,
    BuildContext context,
  ) async {
    _myRepo.likePost(data, accessToken).then((value) {
     
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void> unlikePost(
    dynamic data,
    String accessToken,
    BuildContext context,
  ) async {    
    _myRepo.unlikePost(data, accessToken).then((value) {
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void> addComment(
    dynamic data,
    String accessToken,
    BuildContext context,
  ) async {    
    _myRepo.addComment(data, accessToken).then((value) {
      Utils.toastMessage('Comment added');
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage("Error Adding Comment", context);
        print(error.toString());
      }
    });
  }

  

  Future<dynamic> showComment(
    String userId,
    String accessToken,
    BuildContext context,
  ) async {
    
    dynamic res;
    await _myRepo.showComment(userId,accessToken).then((value) {
      res = value;
      // Utils.flushBarSuccessMessage('Comment get', context);
      
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage("Error getting Comments", context);
        print(error.toString());
      }
      // return null;
    });
    return res;
  }

  Future<dynamic> searchuser(
    String userName,
    BuildContext context,
  ) async {
    
    dynamic res;
    await _myRepo.searchUsers(userName).then((value) {
      res = value;
      // Utils.flushBarSuccessMessage('user get', context);
      
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        // Utils.flushBarErrorMessage("Error getting User", context);
        print(error.toString());
      }
      // return null;
    });
    return res;
  }

  Future<dynamic> profile(
    String accessToken,
    String userId,
    BuildContext context,
  ) async {
    dynamic res;
    await _myRepo.profile(userId,accessToken).then((value) {
      res = value;
      // Utils.flushBarSuccessMessage('user get', context);
      
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage("Error getting User", context);
        print(error.toString());
      }
      // return null;
    });
    return res;
  }

  Future<dynamic> feed(
    String accessToken,
    BuildContext context,
  ) async {
    dynamic res;
    await _myRepo.feed(accessToken).then((value) {
      res = value;
      // Utils.flushBarSuccessMessage('user get', context);
      
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage("Error getting data", context);
        print(error.toString());
      }
      // return null;
    });
    return res;
  }

  Future<dynamic> followerList(
    String userid,
    String accessToken,
    BuildContext context,
  ) async {
    dynamic res;
    await _myRepo.followerList(userid,accessToken).then((value) {
      res = value;
      // Utils.flushBarSuccessMessage('Follower get', context);
      
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage("Error getting Follower", context);
        print(error.toString());
      }
      // return null;
    });
    return res;
  }

  Future<dynamic> likePostList(
    String postid,
    String accessToken,
    BuildContext context,
  ) async {
    dynamic res;
    await _myRepo.likePostList(postid,accessToken).then((value) {
      res = value;
      // Utils.flushBarSuccessMessage('Like List get', context);
      
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage("Error getting Like List", context);
        print(error.toString());
      }      
    });
    return res;
  }

  Future<dynamic> followingList(
    String userid,
    String accessToken,
    BuildContext context,
  ) async {
    dynamic res;
    await _myRepo.followingList(userid,accessToken).then((value) {
      res = value;
      // Utils.flushBarSuccessMessage('Follower get', context);
      
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage("Error getting Follower", context);
        print(error.toString());
      }
      // return null;
    });
    return res;
  }


  Future<void> follow(
    dynamic data,
    String accessToken,
    BuildContext context,
  ) async {    
    _myRepo.follow(data, accessToken).then((value) {
      // Utils.flushBarSuccessMessage('Follow Successfully', context);
      Utils.toastMessage('Follow Successfully');
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage("Error Follow", context);
        print(error.toString());
      }
    });
  }

  Future<void> unfollow(
    dynamic data,
    String accessToken,
    BuildContext context,
  ) async {    
    _myRepo.unfollow(data, accessToken).then((value) {
      // Utils.flushBarSuccessMessage('Unfollow Successfully', context);
      Utils.toastMessage('Unfollowed');
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage("Error Unfollow", context);
        print(error.toString());
      }
    });
  }

  Future<void> deletePost(
    dynamic data,
    String accessToken,
    BuildContext context,
  ) async {    
    _myRepo.deletePost(accessToken,data).then((value) {
      // Utils.flushBarSuccessMessage('Post Delete Successfully', context);
      Utils.toastMessage('Post deleted');
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage("Error Deleting Post", context);
        print(error.toString());
      }
    });
  }

  Future<void> deleteComment(
    dynamic data,
    String accessToken,
    BuildContext context,
  ) async {    
    _myRepo.deleteComment(accessToken,data).then((value) {
      
      // Utils.flushBarSuccessMessage('Comment Delete Successfully', context);
      Utils.toastMessage('Comment deleted');
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage("Error Deleting Comment", context);
        print(error.toString());
      }
    });
  }

  Future<void> editComment(
    dynamic data,
    String accessToken,
    BuildContext context,
  ) async {    
    _myRepo.editComment(accessToken,data).then((value) {
      
      // Utils.flushBarSuccessMessage('Comment Edit Successfully', context);
      Utils.toastMessage('Comment edited');
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage("Error Editing Comment", context);
        print(error.toString());
      }
    });
  }

  Future<void> editProfile(
    dynamic data,
    String accessToken,
    BuildContext context,
  ) async { 
    _myRepo.editProfile(data, accessToken).then((value) {
      Navigator.pop(context);
      // Utils.flushBarSuccessMessage('Profile Updated Successfully', context);
      Utils.toastMessage('Porfile edited');
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage("Error Update Profile", context);
        print(error.toString());
      }
    });
  }

  Future<void> editPost(
    dynamic data,
    String accessToken,
    BuildContext context,
  ) async {    
    _myRepo.editPost(data, accessToken).then((value) {
      // Utils.flushBarSuccessMessage('Profile Updated Successfully', context);
      Utils.toastMessage('Post Edited');
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage("Error Update Profile", context);
        print(error.toString());
      }
    });
  }

  Future<void> followNotify(dynamic data, BuildContext context,String accessToken) async {
    _myRepo.sendFollowNotification(data,accessToken).then((value) {      
      // Utils.flushBarSuccessMessage('Notification send', context);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage("Error Sending Notification", context);
        print(error.toString());
      }
    });
  }

  Future<dynamic> notificationList(
    // String userid,
    String accessToken,
    BuildContext context,
  ) async {
    dynamic res;
    await _myRepo.showNotification(accessToken).then((value) {
      res = value;
      // Utils.flushBarSuccessMessage('Follower get', context);
      
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage("Error getting Notification", context);
        print(error.toString());
      }
      // return null;
    });
    return res;
  }

  Future<dynamic> specificPost(
    String userid,
    String accessToken,
    BuildContext context,
  ) async {
    dynamic res;
    await _myRepo.specificPost(accessToken,userid).then((value) {
      res = value;
      // Utils.flushBarSuccessMessage('Follower get', context);
      
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage("Error getting Notification", context);
        print(error.toString());
      }
      // return null;
    });
    return res;
  }


  Future<void> deleteNotify(dynamic data, BuildContext context,String accessToken) async {
    _myRepo.deleteNotification(accessToken,data).then((value) {      
      // Utils.flushBarSuccessMessage('Notification Delete', context);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        Utils.flushBarErrorMessage("Error Deleting Notification", context);
        print(error.toString());
      }
    });
  }

}
