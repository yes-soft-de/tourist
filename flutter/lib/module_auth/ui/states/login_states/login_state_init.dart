import 'package:tourists/module_auth/enums/user_type.dart';
import 'package:tourists/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:tourists/module_auth/ui/states/login_states/login_state.dart';
import 'package:tourists/module_auth/ui/widget/phone_email_link_login/phone_email_link_login.dart';
import 'package:flutter/material.dart';

class LoginStateInit extends LoginState {
  UserRole userType = UserRole.ROLE_TOURIST;
  final loginTypeController =
      PageController(initialPage: UserRole.ROLE_TOURIST.index);

  LoginStateInit(LoginScreenState screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return SafeArea(
      child: Center(
        child: PhoneEmailLinkLoginFormWidget(
          onEmailLinkRequest: (email, UserRole role) {
            screen.sendLoginLink(email, UserRole.ROLE_TOURIST);
          },
          onCodeRequested: (phoneNumber, role) {
            screen.loginViaPhone(phoneNumber, role);
          },
          onGmailLoginRequested: (role) {
            screen.loginViaGoogle(role);
          },
          onSnackBarRequested: (msg) {
            screen.showSnackBar(msg);
          },
        ),
      ),
    );
  }
}
