class RegisterGuideRequest {
  String userID;
  String email;
  String password;
  String name;
  String roles;

  RegisterGuideRequest(
      {this.userID, this.email, this.password, this.name, this.roles});

  RegisterGuideRequest.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    email = json['email'];
    password = json['password'];
    name = json['name'];
    roles = json['roles'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['email'] = this.email;
    data['password'] = this.password;
    data['name'] = this.name;
    data['roles'] = this.roles;
    return data;
  }
}