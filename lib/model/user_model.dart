// class UserModel {
//  String? token;

//  UserModel({this.token});

//  UserModel.fromJson(Map<String, dynamic> json) {
//  token = json['token'];
//  }

//  Map<String, dynamic> toJson() {
//  final Map<String, dynamic> data = <String, dynamic>{};
//  data['token'] = token;
//  return data;
//  }
// }

class UserModel {
  int? statusCode;
  String? type;
  Data? data;

  UserModel({this.statusCode, this.type, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    type = json['type'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['type'] = this.type;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  UserInfo? userInfo;
  String? accessToken;
  String? referaceToken;

  Data({this.userInfo, this.accessToken, this.referaceToken});

  Data.fromJson(Map<String, dynamic> json) {
    userInfo = json['UserInfo'] != null
        ? new UserInfo.fromJson(json['UserInfo'])
        : null;
    accessToken = json['accessToken'];
    referaceToken = json['referaceToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userInfo != null) {
      data['UserInfo'] = this.userInfo!.toJson();
    }
    data['accessToken'] = this.accessToken;
    data['referaceToken'] = this.referaceToken;
    return data;
  }
}

class UserInfo {
  String? sId;
  String? name;
  String? email;
  String? userName;
  String? profilePicUrl;
  String? password;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? verificationKey;

  UserInfo(
      {this.sId,
      this.name,
      this.email,
      this.userName,
      this.password,
      this.profilePicUrl,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.verificationKey});

  UserInfo.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    userName = json['userName'];
    password = json['password'];
    profilePicUrl=json['profilePicUrl'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    verificationKey = json['verificationKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['userName'] = this.userName;
    data['password'] = this.password;
    data['profilePicUrl']=this.profilePicUrl;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['verificationKey'] = this.verificationKey;
    return data;
  }
}
