class Search_user_Model {
  int? statusCode;
  String? type;
  List<Data>? data;

  Search_user_Model({this.statusCode, this.type, this.data});

  Search_user_Model.fromJson(Map<String, dynamic> json) {
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
  String? sId;
  String? name;
  String? email;
  String? userName;
  String? password;
  String? profilePicUrl;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? verificationKey;

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    userName = json['userName'];
    password = json['password'];
    profilePicUrl = json['profilePicUrl'];
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
    data['profilePicUrl'] = this.profilePicUrl;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['verificationKey'] = this.verificationKey;
    return data;
  }
}
