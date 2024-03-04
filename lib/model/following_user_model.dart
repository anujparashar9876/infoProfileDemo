class Following_user_Model {
  int? statusCode;
  String? type;
  List<Data>? data;

  Following_user_Model({this.statusCode, this.type, this.data});

  Following_user_Model.fromJson(Map<String, dynamic> json) {
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
  List<Following>? following;
  int? followingcount;

  Data(
      {this.userId,
      this.followingId,
      this.status,
      this.following,
      this.followingcount});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    followingId = json['followingId'];
    status = json['status'];
    if (json['following'] != null) {
      following = <Following>[];
      json['following'].forEach((v) {
        following!.add(new Following.fromJson(v));
      });
    }
    followingcount = json['followingcount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['followingId'] = this.followingId;
    data['status'] = this.status;
    if (this.following != null) {
      data['following'] = this.following!.map((v) => v.toJson()).toList();
    }
    data['followingcount'] = this.followingcount;
    return data;
  }
}

class Following {
  String? name;
  String? email;
  String? userName;
  String? profilePicUrl;

  Following({this.name, this.email, this.userName, this.profilePicUrl});

  Following.fromJson(Map<String, dynamic> json) {
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
