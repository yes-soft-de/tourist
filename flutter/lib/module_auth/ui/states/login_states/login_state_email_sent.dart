import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:tourists/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:tourists/module_auth/ui/states/login_states/login_state.dart';

class LoginStateEmailSent extends LoginState {
  LoginStateEmailSent(LoginScreenState screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Center(
      child: Lottie.asset('resources/animations/email_sent.json'),
    );
  }
}