import 'package:flutter/material.dart';
import 'package:infoprofiledemo/res/app_images.dart';
import 'package:infoprofiledemo/view_model/service/splash_service/splash_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashService splashService=SplashService();
  @override
  void initState() {
    super.initState();
    splashService.checkAuth(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
                0.5,
                1
              ],
              colors: [
          Color.fromARGB(255, 254, 249, 233),
          Color.fromARGB(255, 228, 189, 129),
        ])),
        child: Center(child: Image.asset(AppImages.login),)),
    );
  }
}