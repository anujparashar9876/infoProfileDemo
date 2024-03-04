
import 'package:flutter/material.dart';
import 'package:infoprofiledemo/view/home/bottom_navigation_bar.dart';
import 'package:infoprofiledemo/utils/route/routeName.dart';
import 'package:infoprofiledemo/view/Auth/complete_profile_screen.dart';
import 'package:infoprofiledemo/view/Auth/forget_password_screen.dart';
import 'package:infoprofiledemo/view/Auth/login_screen.dart';
import 'package:infoprofiledemo/view/Auth/new_password_screen.dart';
import 'package:infoprofiledemo/view/Auth/otp_screen.dart';
import 'package:infoprofiledemo/view/Auth/otp_screen_forget_screen.dart';
import 'package:infoprofiledemo/view/Auth/signup_screen.dart';
import 'package:infoprofiledemo/view/profile/create_post_screen.dart';
import 'package:infoprofiledemo/view/profile/follower_following.dart';
import 'package:infoprofiledemo/view/home/home_screen.dart';
import 'package:infoprofiledemo/view/home/notification_screen.dart';
import 'package:infoprofiledemo/view/profile/post_screen.dart';
import 'package:infoprofiledemo/view/profile/profile_screen.dart';
import 'package:infoprofiledemo/view/home/search_screen.dart';
import 'package:infoprofiledemo/view/splash/splash_screen.dart';
import 'package:infoprofiledemo/view/tutorial_screen/first_tutorial_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name) {
      case RouteName.splash:
        return MaterialPageRoute(builder: (context)=>SplashScreen());
      case RouteName.login:
        return MaterialPageRoute(builder: (context)=>LoginScreen());
      case RouteName.signup:
        return MaterialPageRoute(builder: (context) =>SignUpScreen());
      case RouteName.complete:
      Map<String, dynamic> complete= settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (context)=>CompleteProfileScreen(accessToken: complete['accessToken'],userid: complete['userid'],));
      case RouteName.otp:
        Map<String, dynamic> otp= settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (context)=>OTPScreen(email: otp['email'],));
      case RouteName.forget:
        return MaterialPageRoute(builder: (context)=>ForgetPasswordScreen());
      case RouteName.otpfoget:
        Map<String, dynamic> forgetOTP= settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (context)=>OTPForgetScreen(email: forgetOTP['email'],));
      case RouteName.newpass:
      Map<String, dynamic> change= settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (context)=>NewPasswordScreen(forgetToken: change['forgetToken'],));
      case RouteName.profile:
      Map<String, dynamic> bottom= settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (context)=>UserProfileScreen(userid: bottom['userid'],));
      case RouteName.home:
        return MaterialPageRoute(builder: (context)=>HomeScreen());
      case RouteName.bottomNav:
      // Map<String, dynamic> bottom= settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (context)=>BottomNavigation());
          // data: bottom['data'],
      case RouteName.createPost:
        return MaterialPageRoute(builder: (context)=>CreatePostScreen());
      case RouteName.firstTutorial:
        return MaterialPageRoute(builder: (context)=>FirstTutorialScreen());
      case RouteName.search:
        return MaterialPageRoute(builder: (context)=>SearchScreen());
      case RouteName.follower:
      Map<String, dynamic> follow= settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (context)=>FollowerFollowing(userid: follow['userid'],accessToken: follow['accessToken'],));

      case RouteName.notification:      
        return MaterialPageRoute(builder: (context)=>NotificationScreen());
      case RouteName.post:
      Map<String, dynamic> post= settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (context)=>PostScreen(
          accessToken: post['accesstoken'],
          index: post['index'],
          // profilepic: post['profilepic'],
          // name: post['name'],
          // userData: post['userData'],
          postId: post['postId'],
          ));
      default:
      return MaterialPageRoute(builder: (context){
        return Scaffold(
          body: Center(child: Text('No Route Found'),),
        );
      });
    }
  }
}