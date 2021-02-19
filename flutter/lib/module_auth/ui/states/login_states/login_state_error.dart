import 'package:tourists/module_auth/enums/user_type.dart';
import 'package:tourists/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:tourists/module_auth/ui/states/login_states/login_state.dart';
import 'package:tourists/module_auth/ui/widget/email_password_login/email_password_login.dart';
import 'package:tourists/module_auth/ui/widget/phone_email_link_login/phone_email_link_login.dart';
import 'package:tourists/module_auth/ui/widget/phone_login/phone_login.dart';
import 'package:flutter/material.dart';

class LoginStateError extends LoginState {
  String errorMsg;
  UserRole userType = UserRole.ROLE_OWNER;
  final loginTypeController =
      PageController(initialPage: UserRole.ROLE_OWNER.index);
  bool loading = false;

  String email;
  String password;

  LoginStateError(
      LoginScreenState screen, this.errorMsg, this.email, this.password)
      : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: PhoneEmailLinkLoginFormWidget(
                onEmailLinkRequest: (email) {
                  screen.sendLoginLink(email, UserRole.ROLE_OWNER);
                },
                onCodeRequested: (phoneNumber) {
                  screen.loginViaPhone(phoneNumber);
                },
                onGmailLoginRequested: () {
                  screen.loginViaGoogle();
                },
                onSnackBarRequested: (msg) {
                  screen.showSnackBar(msg);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(errorMsg, maxLines: 3,),
          )
        ],
      ),
    );
  }
}
