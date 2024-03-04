import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:infoprofiledemo/res/AppColors.dart';
import 'package:infoprofiledemo/res/AppString.dart';
import 'package:infoprofiledemo/res/app_images.dart';
import 'package:infoprofiledemo/res/component/buttonCustom.dart';
import 'package:infoprofiledemo/res/string_text_style.dart';
import 'package:infoprofiledemo/view_model/provider/auth_view_model.dart';
import 'package:provider/provider.dart';

class OTPScreen extends StatefulWidget {
  final String email;
  const OTPScreen({super.key,required this.email});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {
    final authViewModel=Provider.of<AuthViewModel>(context);    
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.otptitle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.otp,
            scale: 0.4,
          ),
          const Text(
            AppString.verify,
            style: StringTextStyle.logintitle,
          ),
          const Text(AppString.verifyInfo),
          OtpTextField(
            fieldWidth: 50,
            margin: const EdgeInsets.all(20),
            numberOfFields: 4,
            borderColor: const Color(0xFF512DA8),
            //set to true to show as box or false to show as dash
            showFieldAsBox: true,
            //runs when a code is typed in
            onCodeChanged: (String code) {
              //handle validation or checks here
            },
            //runs when every textfield is filled
            onSubmit: (String verificationCode) {              
              Map<String,dynamic> data={
                "email":widget.email.trim(),
                "verify_otp": verificationCode.trim(),
              };              
              authViewModel.verifyOtp(data, context);
            }, // end onSubmit
          ),
          SubmitButton(
            textCol: AppColors.white,
            he: MediaQuery.of(context).size.height * 0.05,
            wi: MediaQuery.of(context).size.width * 0.9,
            buttonLabel: AppString.veri,
            col: AppColors.theme,
            submitFuction: () {
              Map<String,dynamic> data={
                "email":widget.email.trim(),
              };
              authViewModel.resend(data, context);              
            },
          ),
        ],
      ),
    );
  }
}
