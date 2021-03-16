import 'package:tourists/module_auth/enums/user_type.dart';

class RegisterRequest {
  String userID;
  String password;
  UserRole roles;

  RegisterRequest({this.userID, this.password, this.roles});

  RegisterRequest.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] = this.userID;
    data['password'] = this.password;
    data['roles'] =
        this.roles == UserRole.ROLE_GUIDE ? 'ROLE_GUIDE' : 'ROLE_TOURIST';
    data['places'] = ['-1'];
    return data;
  }
}
