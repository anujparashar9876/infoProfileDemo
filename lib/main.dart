import 'package:flutter/material.dart';
import 'package:infoprofiledemo/res/AppColors.dart';
import 'package:infoprofiledemo/res/string_text_style.dart';
import 'package:infoprofiledemo/utils/route/routeName.dart';
import 'package:infoprofiledemo/utils/route/routes.dart';
import 'package:infoprofiledemo/view_model/provider/auth_view_model.dart';
import 'package:infoprofiledemo/view_model/provider/like_provider.dart';
import 'package:infoprofiledemo/view_model/provider/obsecure_provider.dart';
import 'package:infoprofiledemo/view_model/provider/user_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
  
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
   
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ObsecureProvider()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => LikeProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.theme,
              titleTextStyle: StringTextStyle.appbar,
              iconTheme: IconThemeData(color: AppColors.white)),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: RouteName.splash,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
