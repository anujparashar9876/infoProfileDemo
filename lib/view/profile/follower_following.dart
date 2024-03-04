import 'package:flutter/material.dart';
import 'package:infoprofiledemo/model/follower_user_model.dart';
import 'package:infoprofiledemo/model/following_user_model.dart';
import 'package:infoprofiledemo/res/AppColors.dart';
import 'package:infoprofiledemo/utils/route/routeName.dart';
import 'package:infoprofiledemo/view_model/provider/auth_view_model.dart';

class FollowerFollowing extends StatefulWidget {
  final String userid;
  final String accessToken;
  const FollowerFollowing({super.key,required this.accessToken,required this.userid});

  @override
  FollowerFollowingState createState() => FollowerFollowingState();
}

class FollowerFollowingState extends State<FollowerFollowing>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2, // Two tabs: Followers and Following
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Profile'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              // text: 'Followers',
              child: Text('Follower',style: TextStyle(color: AppColors.white),),
            ),
            Tab(
              child: Text('Following',style: TextStyle(color: AppColors.white),),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Followers Tab
          FutureBuilder(
            future: AuthViewModel().followerList(widget.userid,widget.accessToken
              ,
              context,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: const CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                if (snapshot.hasData) {
                  final queryData = snapshot.data;
                final userData = Follower_user_Model.fromJson(queryData);
                debugPrint(
                    'future buidder: $queryData\n type: ${queryData.runtimeType}');
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: userData.data!.length-1,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, RouteName.profile,arguments: {
                            'userid':userData.data![index].userId
                          });
                        },
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(userData.data![index].followers![0].profilePicUrl!),
                        ),
                        title: Text(userData.data![index].followers![0].name!),
                        subtitle: Text(userData.data![index].followers![0].userName!),
                      );
                    });
                } else {
                  return Text('No Data');
                }
              }
            },
          ),
          // Following Tab
          FutureBuilder(
            future: AuthViewModel().followingList(widget.userid,widget.accessToken
              ,
              context,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: const CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                if (snapshot.hasData) {
                  final queryData = snapshot.data;
                final userData = Following_user_Model.fromJson(queryData);                
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: userData.data!.length-1,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, RouteName.profile,arguments: {
                            'userid':userData.data![index].followingId
                          });
                        },
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(userData.data![index].following![0].profilePicUrl!),
                        ),
                        title: Text(userData.data![index].following![0].name!),
                        subtitle: Text(userData.data![index].following![0].userName!),
                      );
                    });
                } else {
                  return Text('No Data');
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
