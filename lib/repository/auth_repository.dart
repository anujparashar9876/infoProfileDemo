

import 'package:infoprofiledemo/data/network/base_api_service.dart';
import 'package:infoprofiledemo/data/network/network_api_service.dart';
import 'package:infoprofiledemo/res/app_url.dart';

class AuthRepository{
  BaseApiServices _apiServices=NetworkApiServices();

  Future<dynamic> loginApi(dynamic data) async{
    try{
      dynamic response=await _apiServices.getPostApiResponse(AppUrl.loginurl, data,header: {
        "Content-Type": "application/json",
      });
      return response;
    } catch(e){
      throw e;
    }
  }

  Future<dynamic> registerApi(dynamic data) async{
    try{
      dynamic response=await _apiServices.getPostApiResponse(AppUrl.registerurl, data, header: {
        "Content-Type": "application/json",
        'Authorization': "Basic QURNSU46QURNSU4="
        });
      return response;
    } catch(e){
      throw e;
    }
  }
  Future<dynamic> otpVerify(dynamic data) async{
    try {
      dynamic response=await _apiServices.getPostApiResponse(AppUrl.otpverify, data,header: {
        "Content-Type": "application/json",
      });
      return response;
    } catch (e) {
      throw e;
    }
  }
  Future<dynamic> resendOTP(dynamic data) async{
    try {
      dynamic response=await _apiServices.getPostApiResponse(AppUrl.resendOTP, data,header: {
        "Content-Type": "application/json",
      });
      return response;
    } catch (e) {
      throw e;
    }
  }
  Future<dynamic> forget(dynamic data) async{
    try {
      dynamic response=await _apiServices.getPostApiResponse(AppUrl.forget, data,header: {
        "Content-Type": "application/json",
      });
      return response;
    } catch (e) {
      throw e;
    }
  }
  Future<dynamic> forget_otp(dynamic data) async{
    try {
      dynamic response=await _apiServices.getPostApiResponse(AppUrl.forgetOTP, data,header: {
        "Content-Type": "application/json",
      });
      return response;
    } catch (e) {
      throw e;
    }
  }
  Future<dynamic> changePassword(dynamic data,String forget) async{
    try {
      dynamic response=await _apiServices.getPostApiResponse(AppUrl.changePassword, data,header: {
        "Content-Type": "application/json",
        'Authorization': "Bearer $forget"
      });
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> logout(dynamic data,String accessToken) async{
    try {
      dynamic response=await _apiServices.getPostApiResponse(AppUrl.logOut, data,header: {
        "Content-Type": "application/json",
        'Authorization': "Bearer $accessToken"
      });
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> createPost(dynamic data,String accessToken) async{
    try {
      dynamic response=await _apiServices.getPostApiResponse(AppUrl.createPost, data,header: {
        "Content-Type": "application/json",
        'Authorization': "Bearer $accessToken"
      });
      return response;
    } catch (e) {
      throw e;
    }
  }
  Future<dynamic> showUserPost(String accessToken) async{
    try {
      dynamic response=await _apiServices.getGetApiResponse(AppUrl.showUserPost,header: {
        "Content-Type": "application/json",
        'Authorization': "Bearer $accessToken"
      });
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> likePost(dynamic data,String accessToken) async{
    try {
      dynamic response=await _apiServices.getPostApiResponse(AppUrl.likePost, data,header: {
        "Content-Type": "application/json",
        'Authorization': "Bearer $accessToken"
      });
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> unlikePost(dynamic data,String accessToken) async{
    try {
      dynamic response=await _apiServices.getPostApiResponse(AppUrl.unlikePost, data,header: {
        "Content-Type": "application/json",
        'Authorization': "Bearer $accessToken"
      });
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> addComment(dynamic data,String accessToken) async{
    try {
      dynamic response=await _apiServices.getPostApiResponse(AppUrl.addComment, data,header: {
        "Content-Type": "application/json",
        'Authorization': "Bearer $accessToken"
      });
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> follow(dynamic data,String accessToken) async{
    try {
      dynamic response=await _apiServices.getPostApiResponse(AppUrl.follow, data,header: {
        "Content-Type": "application/json",
        'Authorization': "Bearer $accessToken"
      });
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> unfollow(dynamic data,String accessToken) async{
    try {
      dynamic response=await _apiServices.getPostApiResponse(AppUrl.unfollow, data,header: {
        "Content-Type": "application/json",
        'Authorization': "Bearer $accessToken"
      });
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> reportPost(dynamic data,String accessToken) async{
    try {
      dynamic response=await _apiServices.getPostApiResponse(AppUrl.reportPost, data,header: {
        "Content-Type": "application/json",
        'Authorization': "Bearer $accessToken"
      });
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> sendFollowNotification(dynamic data,String accessToken) async{
    try {
      dynamic response=await _apiServices.getPostApiResponse(AppUrl.followNotify, data,header: {
        "Content-Type": "application/json",
        'Authorization': "Bearer $accessToken"
      });
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> editProfile(dynamic data,String accessToken) async{
    try {
      dynamic response=await _apiServices.getPatchApiResponse(AppUrl.editProfile, data,header: {
        "Content-Type": "application/json",
        'Authorization': "Bearer $accessToken"
      });
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> editPost(dynamic data,String accessToken) async{
    try {
      dynamic response=await _apiServices.getPatchApiResponse(AppUrl.editPost, data,header: {
        "Content-Type": "application/json",
        'Authorization': "Bearer $accessToken"
      });
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> showComment(String userId,String accessToken) async{
    try {
      dynamic response=await _apiServices.getGetApiResponse(AppUrl.showComment+userId,header: {
        "Content-Type": "application/json",
        'Authorization': "Bearer $accessToken"
      });
      return response;
    } catch (e) {
      throw e;
    }
  }

Future<dynamic> showNotification(String accessToken) async{
    try {
      dynamic response=await _apiServices.getGetApiResponse(AppUrl.followNotify,header: {
        "Content-Type": "application/json",
        'Authorization': "Bearer $accessToken"
      });
      return response;
    } catch (e) {
      throw e;
    }
  }


  Future<dynamic> searchUsers(String userName) async{
    try {
      dynamic response=await _apiServices.getGetApiResponse(AppUrl.search+userName,header: {
        "Content-Type": "application/json",
        // 'Authorization': "Bearer $accessToken"
      });
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> profile(String userId,String accessToken) async{
    try {
      dynamic response=await _apiServices.getGetApiResponse(AppUrl.profile+userId,header: {
        "Content-Type": "application/json",
        'Authorization': "Bearer $accessToken"
      });
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> followerList(String userId,String accessToken) async{
    try {
      dynamic response=await _apiServices.getGetApiResponse(AppUrl.followerList+userId,header: {
        "Content-Type": "application/json",
        'Authorization': "Bearer $accessToken"
      });
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> followingList(String userId,String accessToken) async{
    try {
      dynamic response=await _apiServices.getGetApiResponse(AppUrl.followingList+userId,header: {
        "Content-Type": "application/json",
        'Authorization': "Bearer $accessToken"
      });
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> likePostList(String postId,String accessToken) async{
    try {
      dynamic response=await _apiServices.getGetApiResponse(AppUrl.likePostList+postId,header: {
        "Content-Type": "application/json",
        'Authorization': "Bearer $accessToken"
      });
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> feed(String accessToken) async{
    try {
      dynamic response=await _apiServices.getGetApiResponse(AppUrl.feed,header: {
        "Content-Type": "application/json",
        'Authorization': "Bearer $accessToken"
      });
      return response;
    } catch (e) {
      throw e;
    }
  }


  Future<dynamic> specificPost(String accessToken,String userid) async{
    try {
      dynamic response=await _apiServices.getGetApiResponse(AppUrl.specificPost+userid,header: {
        "Content-Type": "application/json",
        'Authorization': "Bearer $accessToken"
      });
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> deleteComment(String accessToken,dynamic data) async{
    try {
      dynamic response=await _apiServices.getDeleteApiResponse(AppUrl.deleteComment,data,header: {
        "Content-Type": "application/json",
        'Authorization': "Bearer $accessToken"
      });
      return response;
    } catch (e) {
      throw e;
    }
  }
  Future<dynamic> editComment(String accessToken,dynamic data) async{
    try {
      dynamic response=await _apiServices.getPatchApiResponse(AppUrl.editComment,data,header: {
        "Content-Type": "application/json",
        'Authorization': "Bearer $accessToken"
      });
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> deletePost(String accessToken,dynamic data) async{
    try {
      dynamic response=await _apiServices.getDeleteApiResponse(AppUrl.deletePost,data,header: {
        "Content-Type": "application/json",
        'Authorization': "Bearer $accessToken"
      });
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> deleteNotification(String accessToken,dynamic data) async{
    try {
      dynamic response=await _apiServices.getDeleteApiResponse(AppUrl.followNotify,data,header: {
        "Content-Type": "application/json",
        'Authorization': "Bearer $accessToken"
      });
      return response;
    } catch (e) {
      throw e;
    }
  }
}