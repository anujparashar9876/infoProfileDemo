// To parse this JSON data, do
//
//     final specificPostUserModel = specificPostUserModelFromJson(jsonString);

import 'dart:convert';

SpecificPostUserModel specificPostUserModelFromJson(String str) => SpecificPostUserModel.fromJson(json.decode(str));

String specificPostUserModelToJson(SpecificPostUserModel data) => json.encode(data.toJson());

class SpecificPostUserModel {
    int statusCode;
    String type;
    List<Datum> data;

    SpecificPostUserModel({
        required this.statusCode,
        required this.type,
        required this.data,
    });

    factory SpecificPostUserModel.fromJson(Map<String, dynamic> json) => SpecificPostUserModel(
        statusCode: json["statusCode"],
        type: json["type"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "type": type,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    String id;
    String userId;
    String description;
    String picUrl;
    bool status;
    DateTime createdAt;
    DateTime updatedAt;
    bool isLiked;
    List<dynamic> postComments;
    List<PostLikes1> postLikes1;
    Users users;
    int postLikesCount;
    int commentsCount;

    Datum({
        required this.id,
        required this.userId,
        required this.description,
        required this.picUrl,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.isLiked,
        required this.postComments,
        required this.postLikes1,
        required this.users,
        required this.postLikesCount,
        required this.commentsCount,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        userId: json["userId"],
        description: json["description"],
        picUrl: json["picUrl"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        isLiked: json["isLiked"],
        postComments: List<dynamic>.from(json["postComments"].map((x) => x)),
        postLikes1: List<PostLikes1>.from(json["postLikes1"].map((x) => PostLikes1.fromJson(x))),
        users: Users.fromJson(json["users"]),
        postLikesCount: json["postLikesCount"],
        commentsCount: json["commentsCount"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "description": description,
        "picUrl": picUrl,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "isLiked": isLiked,
        "postComments": List<dynamic>.from(postComments.map((x) => x)),
        "postLikes1": List<dynamic>.from(postLikes1.map((x) => x.toJson())),
        "users": users.toJson(),
        "postLikesCount": postLikesCount,
        "commentsCount": commentsCount,
    };
}

class PostLikes1 {
    String id;
    String userId;
    String postId;
    bool status;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    PostLikes1({
        required this.id,
        required this.userId,
        required this.postId,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory PostLikes1.fromJson(Map<String, dynamic> json) => PostLikes1(
        id: json["_id"],
        userId: json["userId"],
        postId: json["postId"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "postId": postId,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class Users {
    String id;
    String name;
    String userName;
    String profilePicUrl;
    DateTime createdAt;
    DateTime updatedAt;

    Users({
        required this.id,
        required this.name,
        required this.userName,
        required this.profilePicUrl,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["_id"],
        name: json["name"],
        userName: json["userName"],
        profilePicUrl: json["profilePicUrl"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "userName": userName,
        "profilePicUrl": profilePicUrl,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
