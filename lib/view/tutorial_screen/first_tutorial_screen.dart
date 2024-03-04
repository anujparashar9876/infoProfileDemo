// ignore_for_file: avoid_print, must_be_immutable

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:infoprofiledemo/res/AppColors.dart';
import 'package:infoprofiledemo/res/AppString.dart';
import 'package:infoprofiledemo/res/app_images.dart';
import 'package:infoprofiledemo/res/component/on_board_content.dart';
import 'package:infoprofiledemo/utils/route/routeName.dart';


// OnBoarding content Model
class OnBoard {
  final String image, title, description,buttonText;
  final Color color;

  OnBoard({
    required this.image,
    required this.title,
    required this.description,
    required this.color,
    required this.buttonText
  });
}

// OnBoarding content list
final List<OnBoard> demoData = [
  OnBoard(
    image: AppImages.share,
    title: AppString.firsttut,
    color: AppColors.white,
    buttonText: 'Next',
    description: AppString.firsttutdesc
  ),
  OnBoard(
    image: AppImages.connect,
    title: AppString.secondtut,
    color: AppColors.white,
    buttonText: 'Next',
    description:AppString.secondtutdesc
  ),
  OnBoard(
    image: AppImages.create,
    color: AppColors.white,
    title: AppString.thirdtut,
    buttonText: 'Login',
    description:
        "",
  ),
  
];

// OnBoardingScreen
class FirstTutorialScreen extends StatefulWidget {
  const FirstTutorialScreen({super.key});

  @override
  State<FirstTutorialScreen> createState() => _FirstTutorialScreenState();
}

class _FirstTutorialScreenState extends State<FirstTutorialScreen> {
  // Variables
  late PageController _pageController;
  int _pageIndex = 0;
  

 void onNextPage(){
 if(_pageIndex < demoData.length - 1) {
 _pageController.nextPage(
 duration: const Duration(milliseconds: 500),
 curve: Curves.fastEaseInToSlowEaseOut,);
 }}
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Initialize page controller
    _pageController = PageController(initialPage: 0);
    // Automatic scroll behaviour
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_pageIndex < 2) {
        _pageIndex++;
      } else {
        _pageIndex = 0;
      }

      _pageController.animateToPage(
        _pageIndex,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    // Dispose everything
    _pageController.dispose();
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(        
        decoration: const BoxDecoration(
          color: AppColors.white
          
        ),
        child: Column(
          children: [
            // Carousel area
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  setState(() {
                    _pageIndex = index;
                  });
                },
                itemCount: demoData.length,
                controller: _pageController,
                itemBuilder: (context, index) => OnBoardContent(
                  title: demoData[index].title,
                  description: demoData[index].description,
                  image: demoData[index].image,
                  color: demoData[index].color,
                  buttonText: demoData[index].buttonText,
                  
                ),
              ),
            ),
            // Indicator area
            Padding(
              padding: const EdgeInsets.only(top: 10,bottom: 16.0,left: 0,right: 20),
              child: Row(              
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(onPressed: (){
                    Navigator.pushReplacementNamed(context, RouteName.login);
                  }, child: const Text('Skip',style: TextStyle(decoration: TextDecoration.underline),)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    ...List.generate(
                    demoData.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: DotIndicator(
                        isActive: index == _pageIndex,
                      ),
                    ),
                  ),
                  ],),
                  _pageIndex!=2? InkWell(
                    onTap: () => Navigator.pushNamed(context, RouteName.login),
                    child: const Icon(Icons.arrow_forward_outlined,color: AppColors.white,)):InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, RouteName.login);
                      },
                      child: const Icon(Icons.check))
                  
                ],
              ),
            ),                        
          ],
        ),
      ),
    );
  }
}



// Dot indicator widget
class DotIndicator extends StatelessWidget {
  const DotIndicator({
    this.isActive = false,
    super.key,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 10,
      width: isActive ? 34 : 10,
      decoration: BoxDecoration(
        color: isActive ? AppColors.theme : Colors.white,
        border: isActive ? null : Border.all(color: AppColors.black),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }
}