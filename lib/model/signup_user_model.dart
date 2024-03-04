class signUp_user_model {
  String? name;
  String? email;
  String? userName;
  String? password;

  signUp_user_model({this.name, this.email, this.userName, this.password});

  signUp_user_model.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    userName = json['userName'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['userName'] = this.userName;
    data['password'] = this.password;
    return data;
  }
}