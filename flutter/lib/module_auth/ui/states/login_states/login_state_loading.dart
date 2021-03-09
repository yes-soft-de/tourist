import 'package:tourists/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:tourists/module_auth/ui/states/login_states/login_state.dart';
import 'package:flutter/material.dart';

class LoginStateLoading extends LoginState {
  LoginStateLoading(LoginScreenState screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return SafeArea(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
