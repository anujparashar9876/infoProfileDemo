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

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final obsecureProvider = Provider.of<ObsecureProvider>(context);
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(AppString.signup),
      // ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.4,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                image: DecorationImage(image: AssetImage(AppImages.background1),fit: BoxFit.cover)
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3,sigmaY: 3),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(AppString.appName, style: StringTextStyle.title)),
              ),
              ),
              
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFieldCustom(
                            control: nameController,
                            obsecure: false,
                            validate: (value) {
                              if (nameController.text.isEmpty ||
                                  nameController.text.length > 20 ||
                                  !RegExp(RegEx.FullNameRegExp)
                                      .hasMatch(nameController.text)) {
                                return AppString.invalidfullName;
                              } else {
                                return null;
                              }
                            },
                            preIcon: Icons.person_2_outlined,
                            hint: AppString.fullName,
                            labeltext: AppString.fullName,
                            ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025,
                        ),
                        TextFieldCustom(
                            control: usernameController,
                            preIcon: Icons.person,
                            obsecure: false,
                            hint: AppString.username,
                            labeltext: AppString.username,
                            validate: (value) {
                              if (usernameController.text.isEmpty ||
                                  !RegExp(RegEx.userNameRegexp)
                                      .hasMatch(usernameController.text)) {
                                return AppString.fieldmust;
                              } else {
                                return null;
                              }
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFieldCustom(
                          control: emailController,
                          preIcon: Icons.email_outlined,
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
                          height: MediaQuery.of(context).size.height * 0.025,
                        ),
                        TextFieldCustom(
                          control: passController,
                          preIcon: Icons.lock,
                          suficon: obsecureProvider.ob
                              ? Icons.visibility
                              : Icons.visibility_off,
                          sufFunction: () {
                            obsecureProvider.obsecure();
                          },
                          validate: (value) {
                            // if (passController.text.isEmpty) {
                            //   return AppString.passrequire;
                            // }
                            // else if (
                            //   RegExp(
                            //         RegEx.passRegExp)
                            //     .hasMatch(passController.text)) {
                            //   return AppString.invalid;
                            // }
                            // else {
                            //   return null;
                            // }
                          },
                          obsecure: !obsecureProvider.ob,
                          hint: AppString.pass,
                          labeltext: AppString.pass,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025,
                        ),
                        SubmitButton(
                          buttonLabel: AppString.signup,
                          col: AppColors.theme,
                          submitFuction: () {
                            if (!formKey.currentState!.validate()) {
                              return;
                            } else {
                              Map data = {
                                'name': nameController.text.toString(),
                                'userName': usernameController.text.toString(),
                                'email': emailController.text.toString(),
                                'password': passController.text.toString(),
                                'profilePicUrl':'https://images.pexels.com/photos/7422160/pexels-photo-7422160.jpeg',
                              };
                              authViewModel.registerApi(data, context);                              
                            }              
                          },
                          textCol: AppColors.white,
                          he: MediaQuery.of(context).size.height * 0.05,
                          wi: MediaQuery.of(context).size.width * 0.4,
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(AppString.doAccount, style: StringTextStyle.account),
                  CupertinoButton(
                    child: const Text(AppString.login),
                    onPressed: () {
                      Navigator.pushNamed(context, RouteName.login);
                    },
                  )
                ],
              ),
            ]),
      ),
    );
  }
}
