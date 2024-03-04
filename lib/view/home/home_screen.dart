import 'package:flutter/material.dart';
import 'package:infoprofiledemo/model/feed_user_model.dart';
import 'package:infoprofiledemo/model/user_model.dart';
import 'package:infoprofiledemo/utils/route/routeName.dart';
import 'package:infoprofiledemo/utils/utils.dart';
import 'package:infoprofiledemo/view/home/post_design.dart';
import 'package:infoprofiledemo/view_model/provider/auth_view_model.dart';
import 'package:infoprofiledemo/view_model/provider/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userPreference = Provider.of<UserViewModel>(context, listen: false);
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
              automaticallyImplyLeading: false,  
              title: Text('InfoProfile',
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold)),              
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RouteName.search);
                    },
                    icon: const Icon(Icons.search)),
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RouteName.notification);
                    },
                    icon: Icon(Icons.notifications)),
                IconButton(
                    onPressed: () {
                      Utils.showAlertDialog(
                          context, 'LogOut', 'Do you want to Log out ?', () {
                        Map data = {"accessToken": user.accessToken};
                        authViewModel.logout(data, user.accessToken!, context);
                        userPreference.remove();
                      }, 'Yes');
                    },
                    icon: const Icon(Icons.logout))
              ],
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                setState(() {});
              },
              child: FutureBuilder(
                future: AuthViewModel().feed(user.accessToken!, context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    // final user = snapshot.data!.data!.userInfo;
                    if (snapshot.hasData) {
                      final queryData = snapshot.data;                    
                      final userData = FeedUserModel.fromJson(queryData);
                      return ListView.builder(
                        padding: const EdgeInsets.all(0),
                        itemCount: userData.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return PostDesign(                    
                            accessToken: user.accessToken!,
                            profilePicUrl:
                                userData.data[index].users.profilePicUrl,
                            imageUrl: userData.data[index].followedPosts.picUrl,
                            desc:
                                userData.data[index].followedPosts.description,
                            userData: userData,
                            index: index,
                            userid: user.userInfo!.sId!,
                            likeCount:
                                userData.data[index].postLikesCount.toString(),
                            commentCount:
                                userData.data[index].commentsCount.toString(),
                            userName: user.userInfo!.userName!,
                          );
                        },
                      );
                    } else {
                      return const Text('No Data');
                    }
                  }
                },
              ),
            ),
          );
        }
      },
    );
  }
}
