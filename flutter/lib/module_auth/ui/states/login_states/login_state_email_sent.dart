import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:tourists/generated/l10n.dart';
import 'package:tourists/module_auth/ui/screen/login_screen/login_screen.dart';
import 'package:tourists/module_auth/ui/states/login_states/login_state.dart';

class LoginStateEmailSent extends LoginState {
  LoginStateEmailSent(LoginScreenState screen) : super(screen);

  @override
  Widget getUI(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Lottie.asset('resources/animations/email_sent.json'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            S.of(context).pleaseCheckYourEmail,
            style: GoogleFonts.openSans(
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}
