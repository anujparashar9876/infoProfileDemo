class Follower_user_Model {
  int? statusCode;
  String? type;
  List<Data>? data;

  Follower_user_Model({this.statusCode, this.type, this.data});

  Follower_user_Model.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    type = json['type'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['type'] = this.type;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? userId;
  String? followingId;
  bool? status;
  List<Followers>? followers;
  // int? followersCount;
  int? followercount;

  Data(
      {this.userId,
      this.followingId,
      this.status,
      this.followers,
      // this.followersCount,
      this.followercount});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    followingId = json['followingId'];
    status = json['status'];
    if (json['followers'] != null) {
      followers = <Followers>[];
      json['followers'].forEach((v) {
        followers!.add(new Followers.fromJson(v));
      });
    }
    // followersCount = json['followersCount'];
    followercount = json['followercount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['followingId'] = this.followingId;
    data['status'] = this.status;
    if (this.followers != null) {
      data['followers'] = this.followers!.map((v) => v.toJson()).toList();
    }
    // data['followersCount'] = this.followersCount;
    data['followercount'] = this.followercount;
    return data;
  }
}

class Followers {
  String? name;
  String? email;
  String? userName;
  String? profilePicUrl;

  Followers({this.name, this.email, this.userName, this.profilePicUrl});

  Followers.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    userName = json['userName'];
    profilePicUrl = json['profilePicUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['userName'] = this.userName;
    data['profilePicUrl'] = this.profilePicUrl;
    return data;
  }
}
