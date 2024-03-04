import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infoprofiledemo/res/AppColors.dart';
import 'package:infoprofiledemo/res/AppString.dart';
import 'package:infoprofiledemo/res/app_images.dart';
import 'package:infoprofiledemo/res/component/buttonCustom.dart';
import 'package:infoprofiledemo/res/component/text_field_custom.dart';
import 'package:infoprofiledemo/res/regExp.dart';
import 'package:infoprofiledemo/res/string_text_style.dart';
import 'package:infoprofiledemo/utils/route/routeName.dart';
import 'package:infoprofiledemo/view_model/provider/auth_view_model.dart';
import 'package:infoprofiledemo/view_model/provider/obsecure_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final obsecureProvider = Provider.of<ObsecureProvider>(context);
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(        
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(AppImages.login2),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                const Text(
                  AppString.appName,
                  style: StringTextStyle.logintitle,
                ),
                // Image.asset("assets/loginLogo.png",scale: 3,),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                const Text(
                  AppString.login,
                  style: StringTextStyle.profile,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFieldCustom(
                          control: emailController,
                          preIcon: Icons.email,
                          obsecure: false,
                          hint: AppString.emailHint,
                          labeltext: AppString.emailLabel,
                          validate: (value) {
                            if (emailController.text.isEmpty ||
                                !RegExp(RegEx.emailRegExp)
                                    .hasMatch(emailController.text)) {
                              return AppString.fieldmust;
                            } else if (!emailController.text.contains('@')) {
                              return AppString.require;
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        TextFieldCustom(
                          control: passController,
                          preIcon: Icons.lock,
                          validate: (value) {
                            // if (passController.text.isEmpty) {
                            //   return AppString.passrequire;
                            // } else if (RegExp(RegEx.passRegExp)
                            //     .hasMatch(passController.text)) {
                            //   return AppString.invalid;
                            // } else {
                            //   return null;
                            // }
                          },
                          obsecure: !obsecureProvider.ob,
                          hint: AppString.pass,
                          labeltext: AppString.pass,
                          suficon: obsecureProvider.ob
                              ? Icons.visibility
                              : Icons.visibility_off,
                          sufFunction: () {
                            obsecureProvider.obsecure();
                          },
                        ),
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SubmitButton(
                              textCol: AppColors.black,
                              buttonLabel: AppString.forget,
                              submitFuction: () {
                                Navigator.pushNamed(context, RouteName.forget);
                              },
                              he: MediaQuery.of(context).size.height * 0.05,
                              wi: MediaQuery.of(context).size.width*0.4,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        SubmitButton(
                          buttonLabel: AppString.login,
                          textCol: AppColors.white,
                          col: AppColors.theme,
                          submitFuction: () {
                            if (!formKey.currentState!.validate()) {
                              return;
                            } else {
                              Map data = {
                                "email": emailController.text.toString(),
                                "password": passController.text.toString()
                              };
                              authViewModel.loginApi(data, context);
                            }                            
                          },
                          he: MediaQuery.of(context).size.height * 0.05,
                          wi: MediaQuery.of(context).size.width * 0.4,
                        ),
                      ],
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      AppString.account,
                      style: StringTextStyle.account,
                    ),
                    CupertinoButton(
                        child: const Text(AppString.signup),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, RouteName.signup);
                        }),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
