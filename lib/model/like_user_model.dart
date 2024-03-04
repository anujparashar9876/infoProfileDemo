class Like_user_model {
  int? statusCode;
  String? type;
  List<Data>? data;

  Like_user_model({this.statusCode, this.type, this.data});

  Like_user_model.fromJson(Map<String, dynamic> json) {
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
  String? description;
  String? picUrl;
  bool? status;
  List<Users>? users;
  int? likeCount;

  Data(
      {this.description, this.picUrl, this.status, this.users, this.likeCount});

  Data.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    picUrl = json['picUrl'];
    status = json['status'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
    likeCount = json['likeCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['picUrl'] = this.picUrl;
    data['status'] = this.status;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    data['likeCount'] = this.likeCount;
    return data;
  }
}

class Users {
  String? name;
  String? email;
  String? userName;
  String? profilePicUrl;
  bool? verificationKey;

  Users(
      {this.name,
      this.email,
      this.userName,
      this.profilePicUrl,
      this.verificationKey});

  Users.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    userName = json['userName'];
    profilePicUrl = json['profilePicUrl'];
    verificationKey = json['verificationKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['userName'] = this.userName;
    data['profilePicUrl'] = this.profilePicUrl;
    data['verificationKey'] = this.verificationKey;
    return data;
  }
}
