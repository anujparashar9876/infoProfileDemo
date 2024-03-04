class notification_user_model {
  int? statusCode;
  String? type;
  List<Notification>? notification;
  int? notificationCount;

  notification_user_model(
      {this.statusCode, this.type, this.notification, this.notificationCount});

  notification_user_model.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    type = json['type'];
    if (json['notification'] != null) {
      notification = <Notification>[];
      json['notification'].forEach((v) {
        notification!.add(new Notification.fromJson(v));
      });
    }
    notificationCount = json['NotificationCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['type'] = this.type;
    if (this.notification != null) {
      data['notification'] = this.notification!.map((v) => v.toJson()).toList();
    }
    data['NotificationCount'] = this.notificationCount;
    return data;
  }
}

class Notification {
  String? sId;
  String? senderId;
  String? receiverId;
  String? title;
  String? activityId;
  String? message;
  String? type;
  bool? isRead;
  bool? status;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Notification(
      {this.sId,
      this.senderId,
      this.receiverId,
      this.title,
      this.activityId,
      this.message,
      this.type,
      this.isRead,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Notification.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    title = json['title'];
    activityId = json['activityId'];
    message = json['message'];
    type = json['type'];
    isRead = json['isRead'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['senderId'] = this.senderId;
    data['receiverId'] = this.receiverId;
    data['title'] = this.title;
    data['activityId'] = this.activityId;
    data['message'] = this.message;
    data['type'] = this.type;
    data['isRead'] = this.isRead;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
