class RegisterRequest {
  String userID;
  String password;
  String name;
  String roles;

  RegisterRequest({
    this.userID,
    this.password,
    this.roles,
    this.name,
  });

  RegisterRequest.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    password = json['password'];
    roles = json['roles'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] = this.userID;
    data['password'] = this.password;
    data['roles'] = this.roles;
    return data;
  }
}
