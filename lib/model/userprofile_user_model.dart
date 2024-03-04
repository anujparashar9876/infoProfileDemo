// To parse this JSON data, do
//
//     final userProfileUserModel = userProfileUserModelFromJson(jsonString);

import 'dart:convert';

UserProfileUserModel userProfileUserModelFromJson(String str) => UserProfileUserModel.fromJson(json.decode(str));

String userProfileUserModelToJson(UserProfileUserModel data) => json.encode(data.toJson());

class UserProfileUserModel {
    int statusCode;
    String type;
    Data data;

    UserProfileUserModel({
        required this.statusCode,
        required this.type,
        required this.data,
    });

    factory UserProfileUserModel.fromJson(Map<String, dynamic> json) => UserProfileUserModel(
        statusCode: json["statusCode"],
        type: json["type"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "type": type,
        "data": data.toJson(),
    };
}

class Data {
    List<FolloweringFeed> followeringFeed;
    List<FollowerFeed> followerFeed;
    List<PostDatum> postData;
    int postCount;
    UserData userData;
    bool isFollowing;

    Data({
        required this.followeringFeed,
        required this.followerFeed,
        required this.postData,
        required this.postCount,
        required this.userData,
        required this.isFollowing,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        followeringFeed: List<FolloweringFeed>.from(json["followeringFeed"].map((x) => FolloweringFeed.fromJson(x))),
        followerFeed: List<FollowerFeed>.from(json["followerFeed"].map((x) => FollowerFeed.fromJson(x))),
        postData: List<PostDatum>.from(json["postData"].map((x) => PostDatum.fromJson(x))),
        postCount: json["postCount"],
        userData: UserData.fromJson(json["userData"]),
        isFollowing: json["isFollowing"],
    );

    Map<String, dynamic> toJson() => {
        "followeringFeed": List<dynamic>.from(followeringFeed.map((x) => x.toJson())),
        "followerFeed": List<dynamic>.from(followerFeed.map((x) => x.toJson())),
        "postData": List<dynamic>.from(postData.map((x) => x.toJson())),
        "postCount": postCount,
        "userData": userData.toJson(),
        "isFollowing": isFollowing,
    };
}

class FollowerFeed {
    String? userId;
    String? followingId;
    bool? status;
    List<Follow>? followers;
    int? followercount;

    FollowerFeed({
        this.userId,
        this.followingId,
        this.status,
        this.followers,
        this.followercount,
    });

    factory FollowerFeed.fromJson(Map<String, dynamic> json) => FollowerFeed(
        userId: json["userId"],
        followingId: json["followingId"],
        status: json["status"],
        followers: json["followers"] == null ? [] : List<Follow>.from(json["followers"]!.map((x) => Follow.fromJson(x))),
        followercount: json["followercount"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "followingId": followingId,
        "status": status,
        "followers": followers == null ? [] : List<dynamic>.from(followers!.map((x) => x.toJson())),
        "followercount": followercount,
    };
}

class Follow {
    String name;
    String email;
    String userName;
    String? profilePicUrl;

    Follow({
        required this.name,
        required this.email,
        required this.userName,
        this.profilePicUrl,
    });

    factory Follow.fromJson(Map<String, dynamic> json) => Follow(
        name: json["name"],
        email: json["email"],
        userName: json["userName"],
        profilePicUrl: json["profilePicUrl"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "userName": userName,
        "profilePicUrl": profilePicUrl,
    };
}

class FolloweringFeed {
    String? userId;
    String? followingId;
    bool? status;
    List<Follow>? following;
    int? followingcount;

    FolloweringFeed({
        this.userId,
        this.followingId,
        this.status,
        this.following,
        this.followingcount,
    });

    factory FolloweringFeed.fromJson(Map<String, dynamic> json) => FolloweringFeed(
        userId: json["userId"],
        followingId: json["followingId"],
        status: json["status"],
        following: json["following"] == null ? [] : List<Follow>.from(json["following"]!.map((x) => Follow.fromJson(x))),
        followingcount: json["followingcount"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "followingId": followingId,
        "status": status,
        "following": following == null ? [] : List<dynamic>.from(following!.map((x) => x.toJson())),
        "followingcount": followingcount,
    };
}

class PostDatum {
    String id;
    String userId;
    String description;
    String picUrl;
    bool status;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    PostDatum({
        required this.id,
        required this.userId,
        required this.description,
        required this.picUrl,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory PostDatum.fromJson(Map<String, dynamic> json) => PostDatum(
        id: json["_id"],
        userId: json["userId"],
        description: json["description"],
        picUrl: json["picUrl"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "description": description,
        "picUrl": picUrl,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class UserData {
    String id;
    String name;
    String email;
    String userName;
    String password;
    String profilePicUrl;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    bool verificationKey;

    UserData({
        required this.id,
        required this.name,
        required this.email,
        required this.userName,
        required this.password,
        required this.profilePicUrl,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.verificationKey,
    });

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        userName: json["userName"],
        password: json["password"],
        profilePicUrl: json["profilePicUrl"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        verificationKey: json["verificationKey"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "userName": userName,
        "password": password,
        "profilePicUrl": profilePicUrl,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "verificationKey": verificationKey,
    };
}
