class Comment_user_Model {
  int? statusCode;
  String? type;
  Data? data;

  Comment_user_Model({this.statusCode, this.type, this.data});

  Comment_user_Model.fromJson(Map<String, dynamic> json) {
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
  Post? post;
  List<Comments>? comments;
  int? commentsCount;

  Data({this.post, this.comments, this.commentsCount});

  Data.fromJson(Map<String, dynamic> json) {
    post = json['post'] != null ? new Post.fromJson(json['post']) : null;
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
    commentsCount = json['commentsCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.post != null) {
      data['post'] = this.post!.toJson();
    }
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    data['commentsCount'] = this.commentsCount;
    return data;
  }
}

class Post {
  String? sId;
  String? userId;
  String? createdAt;
  String? updatedAt;

  Post({this.sId, this.userId, this.createdAt, this.updatedAt});

  Post.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Comments {
  String? sId;
  String? comment;
  bool? status;
  List<User>? user;

  Comments({this.sId, this.comment, this.status, this.user});

  Comments.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    comment = json['comment'];
    status = json['status'];
    if (json['user'] != null) {
      user = <User>[];
      json['user'].forEach((v) {
        user!.add(new User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['comment'] = this.comment;
    data['status'] = this.status;
    if (this.user != null) {
      data['user'] = this.user!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  String? sId;
  String? name;
  String? userName;
  String? profilePicUrl;

  User({this.sId, this.name, this.userName, this.profilePicUrl});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    userName = json['userName'];
    profilePicUrl = json['profilePicUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['userName'] = this.userName;
    data['profilePicUrl'] = this.profilePicUrl;
    return data;
  }
}
