import 'package:tourists/module_auth/enums/user_type.dart';
import 'package:tourists/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:tourists/module_auth/ui/states/login_states/login_state.dart';
import 'package:tourists/module_auth/ui/widget/email_password_login/email_password_login.dart';
import 'package:tourists/module_auth/ui/widget/phone_email_link_login/phone_email_link_login.dart';
import 'package:tourists/module_auth/ui/widget/phone_login/phone_login.dart';
import 'package:flutter/material.dart';

class LoginStateInit extends LoginState {
  UserRole userType = UserRole.ROLE_OWNER;
  final loginTypeController =
      PageController(initialPage: UserRole.ROLE_OWNER.index);

  LoginStateInit(LoginScreenState screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return SafeArea(
      child: Center(
        child: PhoneEmailLinkLoginFormWidget(
          onEmailLinkRequest: (email) {
            screen.sendLoginLink(email, UserRole.ROLE_OWNER);
          },
          onGmailLoginRequested: () {
            screen.loginViaGoogle();
          },
          onSnackBarRequested: (msg) {
            screen.showSnackBar(msg);
          },
        ),
      ),
    );
  }
}
