import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infoprofiledemo/model/user_model.dart';
import 'package:infoprofiledemo/res/AppColors.dart';
import 'package:infoprofiledemo/res/AppString.dart';
import 'package:infoprofiledemo/res/component/bottom_sheet_element.dart';
import 'package:infoprofiledemo/res/component/buttonCustom.dart';
import 'package:infoprofiledemo/res/string_text_style.dart';
import 'package:infoprofiledemo/utils/utils.dart';
import 'package:infoprofiledemo/view_model/provider/auth_view_model.dart';
import 'package:infoprofiledemo/view_model/provider/user_view_model.dart';
import 'package:infoprofiledemo/view_model/service/s3_service/s3_image_url.dart';
import 'package:provider/provider.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
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

  Future GalaryPicker() async {
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
    final authViewModel = Provider.of<AuthViewModel>(context);
    return FutureBuilder<UserModel>(
      future: UserViewModel().getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final user = snapshot.data!.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text(AppString.createpost),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Wrap(
                              children: [
                                Align(
                                  heightFactor: 5,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.001,
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(8),
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
                                      // CircleAvatar(backgroundImage: NetworkImage("https://app-development.s3.amazonaws.com/anuj-20231030164914"),),
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
                                              // picProvider.Image1(context);
                                              image1();
                                            },
                                            child: const ProfileImageSelector(
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
                                              // picProvider.GalaryPicker(context);
                                              GalaryPicker();
                                            },
                                            child: const ProfileImageSelector(
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
                                            child: const ProfileImageSelector(
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
                    radius: 140,
                    backgroundImage:
                        profilePic != null ? FileImage(profilePic!) : null,
                    child: Icon(profilePic != null?null:Icons.photo,size: 70,),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    maxLength: 100,
                    controller: nameController,
                    decoration: InputDecoration(
                        hintText: "Write Description",
                        border: OutlineInputBorder()),
                    maxLines: 4,
                  ),
                ),
                SubmitButton(
                  textCol: AppColors.white,
                  he: MediaQuery.of(context).size.height * 0.05,
                  wi: MediaQuery.of(context).size.width * 0.4,
                  buttonLabel: 'Post',
                  col: AppColors.theme,
                  submitFuction: () async {
                    if (profilePic != null && nameController.text != '') {
                      Utils.showCircularProgress(context);
                      var imageLink = await S3Services().upload(
                          file: profilePic!, userid: user.userInfo!.sId!);
                      Map data = {
                        "picUrl": imageLink,
                        "description": nameController.text.toString()
                      };
                      authViewModel.createPost(
                          data, user.accessToken!, context);
                    }
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
