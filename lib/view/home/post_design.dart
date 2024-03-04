import 'package:flutter/material.dart';
import 'package:infoprofiledemo/model/comment_user_model.dart';
import 'package:infoprofiledemo/model/feed_user_model.dart';
import 'package:infoprofiledemo/model/like_user_model.dart';
import 'package:infoprofiledemo/res/AppColors.dart';
import 'package:infoprofiledemo/res/app_images.dart';
import 'package:infoprofiledemo/utils/route/routeName.dart';
import 'package:infoprofiledemo/utils/utils.dart';
import 'package:infoprofiledemo/view_model/provider/auth_view_model.dart';
import 'package:infoprofiledemo/view_model/provider/like_provider.dart';
import 'package:provider/provider.dart';

class PostDesign extends StatefulWidget {
  final FeedUserModel userData;
  final String accessToken;
  final String imageUrl;
  final String desc;
  final int index;
  final String userid;
  final String likeCount;
  final String commentCount;
  final String userName;
  final String profilePicUrl;


  PostDesign(
      {super.key,
      required this.imageUrl,
      required this.accessToken,
      required this.desc,
      required this.index,
      required this.userid,
      required this.userData,
      required this.likeCount,
      required this.commentCount,
      required this.userName,
      required this.profilePicUrl,
      });

  @override
  State<PostDesign> createState() => _PostDesignState();
}

class _PostDesignState extends State<PostDesign> {
  TextEditingController commentController = TextEditingController();
  TextEditingController EditCommentController = TextEditingController();
  TextEditingController editPostController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const SizedBox(height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.profilePicUrl),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RouteName.profile,arguments: {
                        'userid':widget.userData.data[widget.index].users.sId
                      });
                    },
                    child: Text(
                      widget.userData.data[widget.index].users.userName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (widget.userData.data[widget.index].users.userName ==widget.userName)
                              ListTile(
                                onTap: () {
                                  Utils.showEditDialog(
                                      context,
                                      'Edit Post',
                                      TextField(
                                        controller: editPostController,
                                      ), () {
                                    Map data = {
                                      "postId": widget.userData.data[widget.index].followedPosts.id,
                                      "description": editPostController.text
                                    };
                                    authViewModel.editPost(data, widget.accessToken, context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);                                    
                                  }, 'Update');                          
                                },
                                title: const Text("Edit Post"),
                                leading: const Icon(Icons.edit),
                              ),
                            if (widget.userData.data[widget.index].users
                                    .userName !=
                                widget.userName)
                              ListTile(
                                leading: const Icon(Icons.report),
                                title: const Text('Report Post'),
                                onTap: () {
                                  Utils.showAlertDialog(context, 'Report Post',
                                      'Do You want to Report Post', () {
                                    Map data = {
                                      "postId": widget.userData.data[widget.index].followedPosts.id,
                                    };
                                    authViewModel.reportPost(data, widget.accessToken, context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);                                  
                                  }, 'Report');
                                },
                              ),
                            if (widget.userData.data[widget.index].users.userName ==widget.userName)
                              ListTile(
                                leading: const Icon(Icons.delete_forever),
                                title: const Text('Delete Post'),
                                onTap: () {
                                  Utils.showAlertDialog(context, "Delete Post",
                                      'Are You sure to Delete Post?', () {
                                    Map data = {
                                      "postId": widget.userData.data[widget.index].followedPosts.id,
                                    };
                                    authViewModel.deletePost(data, widget.accessToken, context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);                                  
                                  }, 'Yes');
                                },
                              )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            margin: const EdgeInsets.all(5),
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage.assetNetwork(placeholder: AppImages.loader, image: widget.imageUrl,fit: BoxFit.cover,)
            ),
          ),
          const SizedBox(
            height: 10,
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
                          bool isRed = likeProvider.isLiked(widget.userData.data[widget.index].followedPosts.id);                          
                          // int likeCount=widget.userData.data[widget.index].postLikesCount;
                          // int likeCount=int.parse(widget.likeCount);
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
                                          future: AuthViewModel().likePostList(widget.userData.data[widget.index]
                                                  .followedPosts.id,
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
                              final postId = widget
                                  .userData.data[widget.index].followedPosts.id;
                              likeProvider.toggleLike(postId);
                              // isRed=!isRed;
                              // likeCount=likeCount+1;
                              Map data = {
                                "postId": widget.userData.data[widget.index]
                                    .followedPosts.id,
                              };
                              Map data1 = {
                                            "receiverId":widget.userData.data[widget.index].users.sId,                                                
                                            "activityId":
                                                widget.userData.data[widget.index].followedPosts.id,
                                            "title": widget.userName,
                                            "type": "LIKE"
                                          };
                              if (!isRed) {
                                authViewModel.likePost(
                                    data, widget.accessToken, context);
                                if (widget.userData.data[widget.index].users.sId!=widget.userid) {
                                  authViewModel.followNotify(data1, context, widget.accessToken);
                                }
                                
                              } else {
                                authViewModel.unlikePost(
                                    data, widget.accessToken, context);
                              }
                            },
                            child: Row(children: [ 
                              // widget.userData.data[widget.index].isLiked==true
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
                        widget.likeCount,
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
                                widget.userData.data[widget.index].followedPosts
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
                                                  widget.userName)
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
                                                        Navigator.pop(context);
                                                      }, 'Yes');
                                                    }),
                                              if (userData.data!.comments![index].user![0].userName ==widget.userName)
                                                IconButton(
                                                    onPressed: () {
                                                      Utils.showEditDialog(
                                                          context,
                                                          'Edit Comment',
                                                          TextField(
                                                            controller:EditCommentController,
                                                          ), ()  async{
                                                        Map data = {
                                                          "postId": widget.userData.data[widget.index].followedPosts.id,
                                                          "commentId": userData.data!.comments![index].sId,
                                                          "comment":
                                                              EditCommentController.text.toString()
                                                        };
                                                        await authViewModel
                                                            .editComment(
                                                                data,
                                                                widget
                                                                    .accessToken,
                                                                context);
                                                        Navigator.of(context).pop();
                                                        
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
                          Padding(
                            padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                            child: Row(
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
                                  onPressed: ()  async{
                                    Map data = {
                                      "postId": widget.userData.data[widget.index]
                                          .followedPosts.id,
                                      "comment": commentController.text
                                    };
                                    await authViewModel.addComment(
                                        data, widget.accessToken, context);
                                    commentController.clear();
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ),
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
                        Text(widget.commentCount),
                      ],
                    )),
              ),              
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(widget.desc                
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
