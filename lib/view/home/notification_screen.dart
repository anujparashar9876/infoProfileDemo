import 'package:flutter/material.dart';
import 'package:infoprofiledemo/model/notification_user_model.dart';
import 'package:infoprofiledemo/model/user_model.dart';
import 'package:infoprofiledemo/res/AppColors.dart';
import 'package:infoprofiledemo/utils/route/routeName.dart';
import 'package:infoprofiledemo/view_model/provider/auth_view_model.dart';
import 'package:infoprofiledemo/view_model/provider/user_view_model.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    final authViewModel=Provider.of<AuthViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          setState(() {
            
          });
        },
        child: FutureBuilder<UserModel>(
          future: UserViewModel().getUser(),
          builder: (context,snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final user=snapshot.data!.data!;
            return FutureBuilder(
              future: authViewModel.notificationList(user.accessToken!, context), 
              builder: (context,snapshot){
                if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final queryData=snapshot.data;
            final userdata=notification_user_model.fromJson(queryData);
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: userdata.notificationCount,
                itemBuilder: (context,index){
                  return Dismissible(
                    key: UniqueKey(),
                    background: Container(color: AppColors.red,child: const Icon(Icons.delete),),
                    onDismissed:(direction) {
                      Map data={
                        "notificationId":userdata.notification![index].sId,
                      };
                      authViewModel.deleteNotify(data, context, user.accessToken!);
                    },
                    child: ListTile(
                      onTap: () {
                        if (userdata.notification![index].message!.contains('followed')) {                        
                        Navigator.pushNamed(context, RouteName.profile, arguments: {"userid": userdata.notification![index].senderId});                      
                        }
                        else{
                          Navigator.pushNamed(context, RouteName.post,arguments: {
                            'postId':userdata.notification![index].activityId,
                            'accesstoken':user.accessToken,
                            'index':index
                          });
                        }
                      },
                      leading: CircleAvatar(child: userdata.notification![index].message!.contains('followed')?Icon(Icons.person):Icon(Icons.favorite,color: AppColors.red,),),
                      title: RichText(text:TextSpan(text: userdata.notification![index].title!,style: const TextStyle(color: AppColors.theme,fontWeight: FontWeight.bold),children: [
                        TextSpan(text: " ${userdata.notification![index].message}",style: const TextStyle(color: AppColors.black, fontWeight: FontWeight.normal))
                      ])),                    
                    ),
                  );
              });
            }else{
              return const Center(child:Text("No Data Found"));
            }
          }
            });
          }
          }),
      )
    );
  }
}