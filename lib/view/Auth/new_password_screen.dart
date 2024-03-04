import 'package:flutter/material.dart';
import 'package:infoprofiledemo/res/AppColors.dart';
import 'package:infoprofiledemo/res/AppString.dart';
import 'package:infoprofiledemo/res/component/buttonCustom.dart';
import 'package:infoprofiledemo/res/component/text_field_custom.dart';
import 'package:infoprofiledemo/res/regExp.dart';
import 'package:infoprofiledemo/res/string_text_style.dart';
import 'package:infoprofiledemo/view_model/provider/auth_view_model.dart';
import 'package:provider/provider.dart';

class NewPasswordScreen extends StatefulWidget {
  final String forgetToken;
  const NewPasswordScreen({super.key,required this.forgetToken});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  TextEditingController passController=TextEditingController();
  TextEditingController confirmpasswordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authViewModel=Provider.of<AuthViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.newpass),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [            
            const Text(
                      AppString.appName,
                      style: StringTextStyle.logintitle
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.05,
                    ),
                    TextFieldCustom(
                      control: passController,
                      preIcon: Icons.lock,
                      validate: (value) {
                        if (passController.text.isEmpty) {
                          return AppString.passrequire;
                        } else if (RegExp(
                                RegEx.passRegExp)
                            .hasMatch(passController.text)) {
                          return AppString.invalid;
                        } else {
                          return null;
                        }
                      },
                      obsecure: true,
                      hint: AppString.newpass,
                      labeltext: AppString.newpass,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.025,
                    ),
                    TextFieldCustom(
                      control: confirmpasswordController,
                      preIcon: Icons.lock,
                      obsecure: true,
                      hint: AppString.cPass,
                      labeltext: AppString.cPass,
                      validate: (value) {
                        if (confirmpasswordController.text.isEmpty) {
                          return AppString.fieldmust;
                        } else if (confirmpasswordController.text !=
                            passController.text) {
                          return AppString.noMatch;
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.025,
                    ),
                    SubmitButton(
                      buttonLabel: AppString.signup,
                      col: AppColors.theme,
                      submitFuction: () {
                        Map data={
                          "new_password":passController.text.toString().trim()
                        };
                        authViewModel.resetPassword(data, widget.forgetToken,context);
                        // Navigator.pushNamed(context, RouteName.complete);
                      },
                      textCol: AppColors.white,
                      he: MediaQuery.of(context).size.height*0.05,
                      wi: MediaQuery.of(context).size.width*0.9,
                    ),
          ],
        ),
      ),
    );
  }
}