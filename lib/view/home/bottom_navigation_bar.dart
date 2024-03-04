import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:infoprofiledemo/model/user_model.dart';
import 'package:infoprofiledemo/res/AppColors.dart';
import 'package:infoprofiledemo/utils/route/routeName.dart';
import 'package:infoprofiledemo/view/home/home_screen.dart';
import 'package:infoprofiledemo/view/profile/profile_screen.dart';
import 'package:infoprofiledemo/view_model/provider/user_view_model.dart';


class BottomNavigation extends StatefulWidget{
  const BottomNavigation({super.key,
  });
  State<BottomNavigation> createState()=> _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation>{ 
  int _bottomNavIndex = 0;
  // static const TextStyle optionStyle =
  //     TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget>  widgetOptions = <Widget>[
    const HomeScreen(),
    FutureBuilder<UserModel>(
      future: UserViewModel().getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final user = snapshot.data!.data!;  
          return UserProfileScreen(userid: user.userInfo!.sId!,);
          }}),          
    
  ];

  void _onItemTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: widgetOptions.elementAt(_bottomNavIndex),
      floatingActionButton: SizedBox(
        height: 65,
        width: 65,
        child: FloatingActionButton(
          backgroundColor:AppColors.theme,
          shape:const CircleBorder(),
          elevation: 20,
          
          onPressed: (){
            Navigator.pushNamed(context, RouteName.createPost);
          },child: const Icon(Icons.add,color: Colors.white,),),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        activeColor: AppColors.theme,
        splashColor: AppColors.theme,
      icons: [Icons.home,Icons.person_2_outlined,],
      activeIndex: _bottomNavIndex,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.softEdge,
      leftCornerRadius: 32,
      rightCornerRadius: 32,
      onTap: (index) => setState(() => _bottomNavIndex = index),
      //other params
   ),
  
      
    );
  }
}