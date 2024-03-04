import 'package:flutter/material.dart';
import 'package:infoprofiledemo/model/comment_user_model.dart';
import 'package:infoprofiledemo/model/like_user_model.dart';
import 'package:infoprofiledemo/model/specific_post_user_model.dart';
import 'package:infoprofiledemo/res/AppColors.dart';

import 'package:infoprofiledemo/res/app_images.dart';
import 'package:infoprofiledemo/utils/utils.dart';
import 'package:infoprofiledemo/view_model/provider/auth_view_model.dart';
import 'package:infoprofiledemo/view_model/provider/like_provider.dart';
import 'package:infoprofiledemo/view_model/provider/user_view_model.dart';
import 'package:provider/provider.dart';

class PostScreen extends StatefulWidget {
  // String profilepic;
  String accessToken;
  // PostDatum userData;
  int index;
  String postId;
  PostScreen({super.key,required this.postId,required this.accessToken,required this.index});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  TextEditingController EditCommentController=TextEditingController();
  TextEditingController commentController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authViewModel=Provider.of<AuthViewModel>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Post'),),
      body: RefreshIndicator(
        onRefresh: () async{
          setState(() {
            
          });
        },
        child: FutureBuilder(
          future: UserViewModel().getUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final user = snapshot.data!.data!;
            return FutureBuilder(future: authViewModel.specificPost(widget.postId, widget.accessToken, context), builder: (context,snapshot){
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: const CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {if (snapshot.hasData) {
                final queryData=snapshot.data!;
                final userData=SpecificPostUserModel.fromJson(queryData);
                return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                  CircleAvatar(backgroundImage: NetworkImage(userData.data[0].users.profilePicUrl),),
                  SizedBox(width: 20,),
                  Text(userData.data[0].users.name)
                ],),
              ),
              Container(
                  margin: const EdgeInsets.all(5),
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage.assetNetwork(placeholder: AppImages.loader, image: userData.data[0].picUrl,fit: BoxFit.cover,)
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                        padding: const EdgeInsets.only(left: 4, right: 4),
                        decoration: const BoxDecoration(                      
                            ),
                        child: Row(
                          children: [
                            Consumer<LikeProvider>(
                              builder: (context, likeProvider, child) {
                                bool isRed = likeProvider.isLiked(userData.data[0].id);                                
                                return InkWell(
                                  onLongPress: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Column(
                                            children: [
                                              Container(
                                                margin:
                                                    const EdgeInsets.only(top: 10),
                                                height: 5,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                  color: AppColors.theme
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(8)),
                                                ),
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.only(top: 20.0),
                                                child: Align(
                                                    alignment: Alignment.topCenter,
                                                    child: Text(
                                                      'Likes',
                                                    )),
                                              ),
                                              const Divider(),
                                              Expanded(
                                                  child: FutureBuilder(
                                                future: AuthViewModel().likePostList(userData.data[0]
                                                        .id,
                                                    widget.accessToken,
                                                    context),
                                                builder: (context, snapshot) {
                                                  if (snapshot.connectionState ==
                                                      ConnectionState.waiting) {
                                                    return const Center(
                                                        child:
                                                            CircularProgressIndicator());
                                                  } else if (snapshot.hasError) {
                                                    return Text(
                                                        'Error: ${snapshot.error}');
                                                  } else {
                                                    if (snapshot.hasData) {
                                                      final queryData = snapshot.data;
                                                      final userData =
                                                          Like_user_model.fromJson(
                                                              queryData);
                                                      return ListView.builder(
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          shrinkWrap: true,
                                                          itemCount:
                                                              userData.data!.isEmpty?userData.data!.length:userData.data![0].likeCount,
                                                          itemBuilder:
                                                              (BuildContext context,
                                                                  int index) {
                                                            return ListTile(
                                                              leading: CircleAvatar(
                                                                backgroundImage:
                                                                    NetworkImage(userData.data![0].users![index].profilePicUrl!),
                                                              ),
                                                              title: Text(userData.data![0].users![index].name!),
                                                              subtitle: Text(userData.data![0].users![index].userName!),
                                                            );
                                                          });
                                                    } else {
                                                      return const Text('No Data');
                                                    }
                                                  }
                                                },
                                              )),
                                            ],
                                          );
                                        });
                                  },
                                  onTap: () {
                                    final postId = userData.data[0].id;
                                    likeProvider.toggleLike(postId);
                                    // isRed=!isRed;
                                    // likeCount=likeCount+1;
                                    Map data = {
                                      "postId": userData.data[0].
                                          id,
                                    };
                                    
                                    if (!isRed) {
                                      authViewModel.likePost(
                                          data, widget.accessToken, context);
                                      
                                      
                                    } else {
                                      authViewModel.unlikePost(
                                          data, widget.accessToken, context);
                                    }
                                  },
                                  child: Row(children: [
                                    
                                    isRed
                                   
                                      ? const Icon(
                                          Icons.favorite,
                                          color: AppColors.red,
                                        )
                                      : const Icon(
                                          Icons.favorite_border,
                                          color: AppColors.black,
                                        ),
                                        const SizedBox(
                              width: 2,
                            ),
                            Text(
                              userData.data[0].postLikesCount.toString(),
                              style: const TextStyle(color: AppColors.black),
                            ),
                                  ],)
                                );
                              },
                            ),
                            
                          ],
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onLongPress: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  height: 5,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: AppColors.theme.withOpacity(0.2),
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(8)),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 20.0),
                                  child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Text(
                                        'Comments',
                                      )),
                                ),
                                const Divider(),
                                Expanded(
                                    child: FutureBuilder(
                                  future: AuthViewModel().showComment(
                                      userData.data[0]
                                          .id,
                                      widget.accessToken,
                                      context),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      if (snapshot.hasData) {
                                        final queryData = snapshot.data;
                                        final userData =
                                            Comment_user_Model.fromJson(queryData);
                                        return ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            itemCount: userData.data!.commentsCount,
                                            itemBuilder:
                                                (BuildContext context, int index) {
                                              return ListTile(
                                                leading: CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                      userData.data!.comments![index]
                                                          .user![0].profilePicUrl!),
                                                ),
                                                title: Text(userData
                                                    .data!
                                                    .comments![index]
                                                    .user![0]
                                                    .userName!),
                                                subtitle: Text(userData
                                                    .data!.comments![index].comment!),
                                                trailing: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    if (userData
                                                            .data!
                                                            .comments![index]
                                                            .user![0]
                                                            .userName ==
                                                        user.userInfo!.userName)
                                                      IconButton(
                                                          icon: const Icon(
                                                              Icons.delete),
                                                          onPressed: () {
                                                            Utils.showAlertDialog(
                                                                context,
                                                                'Comment delete',
                                                                'Do You want to delete this Comments',
                                                                () {
                                                              Map data = {
                                                                "commentId": userData
                                                                    .data!
                                                                    .comments![index]
                                                                    .sId
                                                              };
                                                              authViewModel
                                                                  .deleteComment(
                                                                      data,
                                                                      widget
                                                                          .accessToken,
                                                                      context);
                                                              Navigator.pop(context);
                                                            }, 'Yes');
                                                          }),
                                                    if (userData.data!.comments![index].user![0].userName ==user.userInfo!.userName)
                                                      IconButton(
                                                          onPressed: () {
                                                            Utils.showEditDialog(
                                                                context,
                                                                'Edit Comment',
                                                                TextField(
                                                                  controller:EditCommentController,
                                                                ), () {
                                                              Map data = {
                                                                "postId": userData.data!.post!.sId,
                                                                "commentId": userData.data!.comments![index].sId,
                                                                "comment":
                                                                    EditCommentController.text.toString()
                                                              };
                                                              authViewModel
                                                                  .editComment(
                                                                      data,
                                                                      widget
                                                                          .accessToken,
                                                                      context);
                                                              Navigator.pop(context);
                                                            }, 'OK');
                                                          },
                                                          icon:
                                                              const Icon(Icons.edit)),
                                                  ],
                                                ),
                                              );
                                            });
                                      } else {
                                        return const Text('No data');
                                      }
                                    }
                                  },
                                )),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: TextField(
                                        controller: commentController,
                                        decoration: const InputDecoration(
                                            hintText: "Add Comment",
                                            border: OutlineInputBorder()),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.send_outlined),
                                      onPressed: () {
                                        Map data = {
                                          "postId": userData.data[0]
                                              .id,
                                          "comment": commentController.text
                                        };
                                        authViewModel.addComment(
                                            data, widget.accessToken, context);
                                        commentController.clear();
                                      },
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                )
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                          padding: const EdgeInsets.only(left: 4, right: 4),
                          decoration: const BoxDecoration(                        
                              ),
                          child: Row(
                            children: [
                              const Icon(Icons.comment),
                              const SizedBox(
                                width: 2,
                              ),
                              Text(userData.data[0].commentsCount.toString()),
                            ],
                          )),
                    ),                    
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(userData.data[0].description),
                ),
            ],);
              }else{
                return Text('No Data');
              }}
            });
          }
            
          }
        ),
      ),      
    );
  }
}