import 'package:flutter/material.dart';
import 'package:infoprofiledemo/model/userprofile_user_model.dart';
import 'package:infoprofiledemo/model/user_model.dart';
import 'package:infoprofiledemo/res/AppColors.dart';
import 'package:infoprofiledemo/res/AppString.dart';
import 'package:infoprofiledemo/res/app_images.dart';
import 'package:infoprofiledemo/res/string_text_style.dart';
import 'package:infoprofiledemo/utils/route/routeName.dart';
import 'package:infoprofiledemo/utils/utils.dart';
import 'package:infoprofiledemo/view_model/provider/auth_view_model.dart';
import 'package:infoprofiledemo/view_model/provider/user_view_model.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatefulWidget {
  final String userid;
  const UserProfileScreen({super.key, required this.userid});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
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
              
                 
              appBar: user.userInfo!.sId != widget.userid?AppBar(
                      backgroundColor: AppColors.theme.withOpacity(0.5),
                    ):null,
              body: RefreshIndicator(
                onRefresh: () async{
                  setState(() {
                    
                  });
                },
                child: FutureBuilder(
                  future: AuthViewModel().profile(
                    user.accessToken!,
                    widget.userid,
                    context,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      if (snapshot.hasData) {
                        final queryData = snapshot.data;
                        final userData = UserProfileUserModel.fromJson(queryData);
                        return Stack(
                          children: [
                            Container(),
                            Positioned(
                                top: MediaQuery.of(context).size.height * -0.4,
                                left: MediaQuery.of(context).size.width * -0.208,
                                child: RotationTransition(
                                  turns: const AlwaysStoppedAnimation(45 / 360),
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height * 0.75,
                                    width:
                                        MediaQuery.of(context).size.width * 1.5,
                                    decoration: BoxDecoration(
                                        color: AppColors.theme.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(
                                            MediaQuery.of(context).size.width *
                                                0.45)),
                                  ),
                                )),
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          0.055),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CircleAvatar(
                                        radius: 60,
                                        backgroundImage: NetworkImage(userData
                                            .data.userData.profilePicUrl),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                      ),
                                      Text(
                                        userData.data.userData.name,
                                        style: StringTextStyle.profile,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.width * 0.05),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            "${userData.data.postCount}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const Text(AppString.post)
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, RouteName.follower,
                                              arguments: {
                                                "userid":
                                                    userData.data.userData.id,
                                                "accessToken": user.accessToken,
                                              });
                                        },
                                        child: Column(
                                          children: [
                                            Text(
                                              "${userData.data.followerFeed.length - 1}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const Text(AppString.follower)
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, RouteName.follower,
                                              arguments: {
                                                "userid":
                                                    userData.data.userData.id,
                                                "accessToken": user.accessToken,
                                              });
                                        },
                                        child: Column(
                                          children: [
                                            Text(
                                              "${userData.data.followeringFeed.length - 1}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const Text(AppString.following)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                                user.userInfo!.sId != userData.data.userData.id
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () async{
                                            Map data = {
                                              "followingId":
                                                  userData.data.userData.id
                                            };
                                            Map data1 = {
                                              "receiverId":
                                                  userData.data.userData.id,
                                              "activityId":
                                                  user.userInfo!.sId,
                                              "title": user.userInfo!.userName,
                                              "type": "FOLLOW"
                                            };
                                            if (userData.data.isFollowing) {
                                              authViewModel.unfollow(data,
                                                  user.accessToken!, context);
                                                  setState(() {
                                                    
                                                  });
                                              
                                            } else {
                                              authViewModel.follow(data,
                                                  user.accessToken!, context);
                                                  
                                              authViewModel.followNotify(data1, context,user.accessToken!);
                                              setState(() {
                                                
                                              });
                                            }
                                          },
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.04,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            decoration: BoxDecoration(
                                                color: AppColors.white,
                                                border: Border.all(
                                                    color: AppColors.theme
                                                        .withOpacity(0.5)),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Center(
                                                child: Text(
                                              userData.data.isFollowing ? AppString.unfollow : AppString.follow,
                                            )),
                                          ),
                                        ),
                                      )
                                    : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(context, RouteName.complete,arguments: {
                                            'accessToken':user.accessToken,
                                            'userid':userData.data.userData.id
                                          });
                                        },
                                        child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.04,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4,
                                                decoration: BoxDecoration(
                                                    color: AppColors.white,
                                                    border: Border.all(
                                                        color: AppColors.theme
                                                            .withOpacity(0.5)),
                                                    borderRadius:
                                                        BorderRadius.circular(15)),
                                                child: const Center(
                                                    child: Text(
                                                  AppString.editProfile,
                                                )),
                                              ),
                                      ),
                                    ),
                                const SizedBox(
                                  height: 35,
                                ),
                                Expanded(
                                  child: GridView.builder(
                                    padding: const EdgeInsets.all(0),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 0,
                                      mainAxisSpacing: 0,
                                    ),
                                    itemCount: userData.data.postCount,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        margin: const EdgeInsets.all(10),                                    
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: AppColors.theme,
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                           Utils.showImageDialog(context, FadeInImage.assetNetwork(placeholder: AppImages.loader, image: userData
                                                  .data.postData[index].picUrl,fit: BoxFit.cover,));
                                          },
                                          onLongPress:
                                              user.userInfo!.sId == widget.userid
                                                  ? () {
                                                      Utils.showAlertDialog(
                                                          context,
                                                          "Delete Post",
                                                          'Are You sure to Delete Post?',
                                                          () {
                                                        Map data = {
                                                          "postId": userData.data
                                                              .postData[index].id
                                                        };
                                                        authViewModel.deletePost(
                                                            data,
                                                            user.accessToken!,
                                                            context);
                                                        Navigator.pop(context);
                                                      }, 'Yes');
                                                    }
                                                  : null,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: FadeInImage.assetNetwork(placeholder: AppImages.loader, image: userData
                                                  .data.postData[index].picUrl,fit: BoxFit.cover,)                                          
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ],
                        );
                      } else {
                        return const Text('No data');
                      }
                    }
                  },
                ),
              ));
        }
      },
    );
  }
}
