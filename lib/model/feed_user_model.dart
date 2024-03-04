// To parse this JSON data, do
//
//     final feedUserModel = feedUserModelFromJson(jsonString);

import 'dart:convert';

FeedUserModel feedUserModelFromJson(String str) => FeedUserModel.fromJson(json.decode(str));

String feedUserModelToJson(FeedUserModel data) => json.encode(data.toJson());

class FeedUserModel {
    int statusCode;
    String type;
    List<Datum> data;

    FeedUserModel({
        required this.statusCode,
        required this.type,
        required this.data,
    });

    factory FeedUserModel.fromJson(Map<String, dynamic> json) => FeedUserModel(
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
    FollowedPosts followedPosts;
    bool isLiked;
    Users users;
    int postLikesCount;
    int commentsCount;

    Datum({
        required this.followedPosts,
        required this.isLiked,
        required this.users,
        required this.postLikesCount,
        required this.commentsCount,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        followedPosts: FollowedPosts.fromJson(json["followedPosts"]),
        isLiked: json["isLiked"],
        users: Users.fromJson(json["users"]),
        postLikesCount: json["postLikesCount"],
        commentsCount: json["commentsCount"],
    );

    Map<String, dynamic> toJson() => {
        "followedPosts": followedPosts.toJson(),
        "isLiked": isLiked,
        "users": users.toJson(),
        "postLikesCount": postLikesCount,
        "commentsCount": commentsCount,
    };
}

class FollowedPosts {
    String id;
    String description;
    String picUrl;
    DateTime createdAt;
    DateTime updatedAt;

    FollowedPosts({
        required this.id,
        required this.description,
        required this.picUrl,
        required this.createdAt,
        required this.updatedAt,
    });

    factory FollowedPosts.fromJson(Map<String, dynamic> json) => FollowedPosts(
        id: json["_id"],
        description: json["description"],
        picUrl: json["picUrl"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "description": description,
        "picUrl": picUrl,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}

class Users {
    String sId;
    String name;
    String email;
    String userName;
    String profilePicUrl;

    Users({
        required this.sId,
        required this.name,
        required this.email,
        required this.userName,
        required this.profilePicUrl,
    });

    factory Users.fromJson(Map<String, dynamic> json) => Users(
        sId: json["_id"],
        name: json["name"],
        email: json["email"],
        userName: json["userName"],
        profilePicUrl: json["profilePicUrl"],
    );

    Map<String, dynamic> toJson() => {
        "_id": sId,
        "name": name,
        "email": email,
        "userName": userName,
        "profilePicUrl": profilePicUrl,
    };
}
