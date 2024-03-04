import 'package:flutter/material.dart';
import 'package:infoprofiledemo/res/AppColors.dart';
import 'package:infoprofiledemo/res/AppString.dart';
import 'package:infoprofiledemo/res/app_images.dart';
import 'package:infoprofiledemo/res/component/buttonCustom.dart';
import 'package:infoprofiledemo/res/component/text_field_custom.dart';
import 'package:infoprofiledemo/res/regExp.dart';
import 'package:infoprofiledemo/res/string_text_style.dart';

import 'package:infoprofiledemo/view_model/provider/auth_view_model.dart';
import 'package:provider/provider.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authViewModel=Provider.of<AuthViewModel>(context);
    return Scaffold(
      // backgroundColor: AppColors.black,
      appBar: AppBar(
        title: const Text(AppString.forget),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(AppImages.forgetPassword),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              const Text(
                AppString.appName,
                style: StringTextStyle.logintitle,
              ),              
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              TextFieldCustom(
                control: emailController,
                preIcon: Icons.email,
                obsecure: false,
                hint: AppString.emailHint,
                labeltext: AppString.emailLabel,
                validate: (value) {
                  if (emailController.text.isEmpty ||
                      !RegExp(RegEx.emailRegExp).hasMatch(emailController.text)) {
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
              SubmitButton(
                      buttonLabel: AppString.forgetbutton,
                      textCol: AppColors.white,
                      col: AppColors.theme,
                      submitFuction: () {
                        Map data={
                          'email':emailController.text.toString()
                        };
                        authViewModel.forgetpassword(data, context);
                        // Navigator.pushNamed(context, RouteName.otpfoget);
                      },
                      he: MediaQuery.of(context).size.height*0.05,
                      wi: MediaQuery.of(context).size.width*0.9,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
