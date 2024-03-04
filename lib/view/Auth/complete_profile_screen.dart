import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infoprofiledemo/res/AppColors.dart';
import 'package:infoprofiledemo/res/AppString.dart';
import 'package:infoprofiledemo/res/component/bottom_sheet_element.dart';
import 'package:infoprofiledemo/res/component/buttonCustom.dart';
import 'package:infoprofiledemo/res/string_text_style.dart';
import 'package:infoprofiledemo/utils/utils.dart';
import 'package:infoprofiledemo/view_model/provider/auth_view_model.dart';
import 'package:infoprofiledemo/view_model/service/s3_service/s3_image_url.dart';
import 'package:provider/provider.dart';

class CompleteProfileScreen extends StatefulWidget {
  String accessToken;
  String userid;

  CompleteProfileScreen({super.key, required this.accessToken,required this.userid});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  TextEditingController nameController = TextEditingController();
  File? profilePic;

  Future image1() async {
    XFile? selectedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (selectedImage != null) {
      File convertedFile = File(selectedImage.path);
      setState(() {
        profilePic = convertedFile;
        Navigator.pop(context);
      });

      log('Image selected');
    } else {
      log('No image selected');
    }
  }

  Future galaryPicker() async {
    XFile? selectedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      File convertedFile = File(selectedImage.path);
      setState(() {
        profilePic = convertedFile;
        Navigator.pop(context);
      });
      log('Image selected');
    } else {
      log('No image selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel=Provider.of<AuthViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.completeProfile),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
              vertical: MediaQuery.of(context).size.height * 0.1),
          child: Card(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                      onTap: () async {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Wrap(
                                  children: [
                                    Align(
                                      heightFactor: 5,
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.001,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, bottom: 30),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            AppString.profilePic,
                                            style: StringTextStyle.profile,
                                          ),
                                          IconButton(
                                            icon: profilePic != null
                                                ? const Icon(Icons.delete)
                                                : const Icon(null),
                                            onPressed: () {
                                              setState(() {
                                                profilePic = null;
                                                Navigator.of(context).pop();
                                              });
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  image1();
                                                },
                                                child:
                                                    const ProfileImageSelector(
                                                        icon: Icons.camera,
                                                        title: "Camera")),
                                          ],
                                        ),
                                        const Padding(
                                            padding: EdgeInsets.only(left: 40)),
                                        Column(
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  galaryPicker();
                                                },
                                                child:
                                                    const ProfileImageSelector(
                                                        icon: Icons.image,
                                                        title: "Gallery"))
                                          ],
                                        ),
                                        const Padding(
                                            padding: EdgeInsets.only(left: 40)),
                                        Column(
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    profilePic = null;
                                                    Navigator.of(context).pop();
                                                  });
                                                },
                                                child:
                                                    const ProfileImageSelector(
                                                        icon: Icons.close,
                                                        title: 'Exit'))
                                          ],
                                        )
                                      ],
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(bottom: 100)),
                                  ],
                                ),
                              );
                            });
                      },
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: AppColors.theme,
                        backgroundImage:
                            profilePic != null ? FileImage(profilePic!) : null,
                            child: profilePic==null? Icon(Icons.camera):null,
                      )),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  SubmitButton(
                    buttonLabel: AppString.save,
                    textCol: AppColors.white,
                    submitFuction: () async{
                      if (profilePic != null) {
                        Utils.showCircularProgress(context);
                        var profilePicUrl = await S3Services()
                              .upload(file: profilePic!, userid: widget.userid);
                          Map data = {"profilePicUrl": profilePicUrl};
                          authViewModel.editProfile(
                              data, widget.accessToken, context);                              
                          
                      }
                    },
                    col: AppColors.theme,
                    he: MediaQuery.of(context).size.height * 0.05,
                    wi: MediaQuery.of(context).size.width * 0.9,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
